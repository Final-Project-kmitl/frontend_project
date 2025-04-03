import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/core/common/widgets/center_loading.dart';
import 'package:project/core/config/theme/app_color.dart';
import 'package:project/core/config/theme/app_theme.dart';
import 'package:project/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:project/features/auth/presentation/widgets/card_components.dart';
import 'package:project/features/auth/domain/entities/ingredient_entity.dart';

class AllergicSection extends StatefulWidget {
  final List<String> allergicTypes;
  final List<String> allergicTypeImages;
  final Function(List<int>) onSelectid;
  final String? selectAllergicType;
  final Function(String) onSelect;

  const AllergicSection(
      {Key? key,
      required this.allergicTypes,
      required this.allergicTypeImages,
      required this.selectAllergicType,
      required this.onSelect,
      required this.onSelectid})
      : super(key: key);

  @override
  State<AllergicSection> createState() => _AllergicSectionState();
}

class _AllergicSectionState extends State<AllergicSection> {
  List<IngredientEntity> selectedItem = [];
  List<int> selectedItemId = [];
  bool _showListView = false;
  late TextEditingController _textEditingController;

  // Add debounce timer to optimize search
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    _textEditingController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  // Debounce search to reduce lag
  void _onSearchChanged() {
    setState(() {
      // Show the list view only when there's text
      _showListView = _textEditingController.text.isNotEmpty;
    });

    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      if (_textEditingController.text.isNotEmpty) {
        context
            .read<AuthBloc>()
            .add(AuthQueryChanged(query: _textEditingController.text));
      } else {
        // When text is cleared, reset the state to hide results
        context.read<AuthBloc>().add(ResetAuthState());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            'คุณมีสาร/ส่วนผสมที่แพ้หรือไม่??',
            style: TextThemes.headline1,
          ),
        ),

        // Replace Flexible with Expanded to prevent overflow
        Expanded(
          child: LayoutBuilder(builder: (context, constraints) {
            double itemWidth = 60;
            double itemHeight = 170;
            double aspectRatio = itemHeight / itemWidth;

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Grid for allergy type selection
                  GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: aspectRatio,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      CardComponent(
                          title: widget.allergicTypes[0],
                          imagePath: widget.allergicTypeImages[0],
                          isSelected: widget.selectAllergicType ==
                              widget.allergicTypes[0],
                          onSelect: (type) {
                            widget.onSelect(type);
                            setState(() {
                              selectedItem.clear();
                              selectedItemId.clear();
                              _textEditingController.clear();
                            });
                          }),
                      CardComponent(
                          title: widget.allergicTypes[1],
                          imagePath: widget.allergicTypeImages[1],
                          isSelected: widget.selectAllergicType ==
                              widget.allergicTypes[1],
                          onSelect: (type) {
                            widget.onSelect(type);
                            context.read<AuthBloc>().add(ResetAuthState());
                          })
                    ],
                  ),

                  // Only show space if there are selected items
                  if (selectedItem.isNotEmpty) SizedBox(height: 12),

                  // Selected items chips
                  if (widget.selectAllergicType == "มี")
                    Container(
                      width: double.infinity,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        reverse: true,
                        child: Row(
                          children: selectedItem.map((item) {
                            final isEven = selectedItem.indexOf(item) % 2 == 0;
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              child: Chip(
                                side: BorderSide(
                                    color: isEven
                                        ? Colors.black
                                        : Color(0xffD0D0D0)),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                labelPadding:
                                    EdgeInsets.only(left: 12, right: 8),
                                label: Text(
                                  item.name,
                                  style: TextThemes.descBold.copyWith(
                                      color: isEven
                                          ? AppColors.white
                                          : AppColors.black),
                                ),
                                deleteIcon: Icon(Icons.close,
                                    size: 20,
                                    color:
                                        isEven ? Colors.white : Colors.black),
                                onDeleted: () {
                                  setState(() {
                                    selectedItem.remove(item);
                                    selectedItemId.remove(item.id);
                                  });
                                  widget.onSelectid(selectedItemId);
                                },
                                backgroundColor:
                                    isEven ? Colors.black : Colors.white,
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),

                  SizedBox(height: 12),

                  // Search and results section
                  if (widget.selectAllergicType == "มี")
                    Expanded(
                      child: Column(
                        children: [
                          // Search input field
                          TextField(
                            onTapOutside: (event) =>
                                FocusScope.of(context).unfocus(),
                            controller: _textEditingController,
                            decoration: InputDecoration(
                              hintText: "ใส่สารที่แพ้",
                              hintStyle: TextThemes.body
                                  .copyWith(color: AppColors.darkGrey),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                    color: AppColors.beige, width: 1),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                    color: AppColors.beige, width: 3),
                              ),
                            ),
                            // Removed autofocus and onChanged to use the listener instead
                          ),

                          const SizedBox(height: 6),

                          // Search results in scrollable container
                          // Replace the Expanded container in your code with this:
                          if (_showListView)
                            Expanded(
                              child: Container(
                                  constraints: BoxConstraints(
                                    maxHeight:
                                        290, // Approximately 5 list tiles (58px each)
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: AppColors.grey),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: BlocBuilder<AuthBloc, AuthState>(
                                    builder: (context, state) {
                                      if (state is AuthLoaded) {
                                        final List<IngredientEntity>
                                            filterResult = state.ingredients
                                                .where((e) => !selectedItem.any(
                                                    (item) => item.id == e.id))
                                                .toList();

                                        if (filterResult.isNotEmpty) {
                                          // Calculate the actual height based on number of items
                                          // but limit to a maximum of 5 items
                                          return ListView.builder(
                                            itemCount: filterResult.length,
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) {
                                              return ListTile(
                                                onTap: () {
                                                  setState(() {
                                                    selectedItem.add(
                                                        filterResult[index]);
                                                    selectedItemId.add(
                                                        filterResult[index].id);
                                                    _textEditingController
                                                        .clear();
                                                    _showListView =
                                                        false; // Hide the list when item selected
                                                  });
                                                  widget.onSelectid(
                                                      selectedItemId);
                                                  context
                                                      .read<AuthBloc>()
                                                      .add(ResetAuthState());
                                                },
                                                title: Text(
                                                  filterResult[index].name,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              );
                                            },
                                          );
                                        } else {
                                          return Container(
                                            height:
                                                58, // Height of a single list tile
                                            child: Center(
                                                child: Text(
                                                    "ไม่พบส่วนผสมที่ค้นหา")),
                                          );
                                        }
                                      } else if (state is AuthLoading) {
                                        return Container(
                                          height:
                                              58, // Height of a single list tile
                                          child: Center(child: CenterLoading()),
                                        );
                                      } else if (state is AuthInitial) {
                                        return Padding(
                                            padding: EdgeInsets.all(1));
                                      }
                                      return Container(
                                        height:
                                            58, // Height of a single list tile
                                        child:
                                            Center(child: Text("ไม่พบข้อมูล")),
                                      );
                                    },
                                  )),
                            ),
                        ],
                      ),
                    )
                ],
              ),
            );
          }),
        ),
      ],
    );
  }
}
