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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _textEditingController = TextEditingController();
    _textEditingController.addListener(() => setState(() {
          _showListView = _textEditingController.text.isNotEmpty;
        }));
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _textEditingController = TextEditingController();

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
        // ใช้ Flexible เพื่อให้ GridView ขยายตามเนื้อที่
        Flexible(
          child: LayoutBuilder(builder: (context, constraints) {
            double itemWidth = 60;
            double itemHeight = 170;
            double aspectRatio = itemHeight / itemWidth;

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
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
                  SizedBox(
                    height: selectedItem.length == 0 ? 0 : 12,
                  ),
                  Container(
                      width: double.infinity,
                      child: widget.selectAllergicType == "มี"
                          ? SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              reverse: true,
                              child: Row(
                                children: selectedItem.map((item) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4.0),
                                    child: Chip(
                                      side: BorderSide(
                                          color:
                                              selectedItem.indexOf(item) % 2 ==
                                                      0
                                                  ? Colors.black
                                                  : Color(0xffD0D0D0)),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(14),
                                      ),
                                      labelPadding:
                                          EdgeInsets.only(left: 12, right: 8),
                                      label: Row(
                                        mainAxisSize: MainAxisSize
                                            .min, // Min size to fit content
                                        mainAxisAlignment: MainAxisAlignment
                                            .center, // Center the contents horizontally
                                        children: [
                                          Text(item.name,
                                              style: TextThemes.descBold
                                                  .copyWith(
                                                      color: selectedItem
                                                                      .indexOf(
                                                                          item) %
                                                                  2 ==
                                                              0
                                                          ? AppColors.white
                                                          : AppColors.black)),
                                        ],
                                      ),
                                      deleteIcon: Icon(Icons.close,
                                          size: 20,
                                          color:
                                              selectedItem.indexOf(item) % 2 ==
                                                      0
                                                  ? Colors.white
                                                  : Colors.black),
                                      onDeleted: () {
                                        setState(() {
                                          selectedItem.remove(item);
                                          selectedItemId.remove(item.id);
                                        });
                                        widget.onSelectid(selectedItemId);
                                      },
                                      backgroundColor:
                                          selectedItem.indexOf(item) % 2 == 0
                                              ? Colors.black
                                              : Colors.white,
                                    ),
                                  );
                                }).toList(),
                              ),
                            )
                          : SizedBox(
                              height: 0,
                            )),
                  SizedBox(
                    height: 12,
                  ),
                  Container(
                    child: widget.selectAllergicType == "มี"
                        ? Container(
                            child: Column(
                            children: [
                              BlocBuilder<AuthBloc, AuthState>(
                                builder: (context, state) {
                                  return TextField(
                                    // onTapOutside: (event) =>
                                    //     FocusScope.of(context).unfocus(),
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
                                    autofocus: true,
                                    onChanged: (value) {
                                      context
                                          .read<AuthBloc>()
                                          .add(AuthQueryChanged(query: value));
                                    },
                                    onSubmitted: (String value) {},
                                  );
                                },
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              ConstrainedBox(
                                constraints: BoxConstraints(maxHeight: 230),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: AppColors.grey),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: BlocBuilder<AuthBloc, AuthState>(
                                    builder: (context, state) {
                                      if (state is AuthLoaded) {
                                        final List<IngredientEntity>
                                            filterResult = state.ingredients
                                                .where((e) => !selectedItem
                                                    .contains(e.name))
                                                .toList();
                                        if (state.ingredients.length > 0) {
                                          return ListView.builder(
                                            itemCount: filterResult.length,
                                            itemBuilder: (context, index) {
                                              print(filterResult[index].name);
                                              return ListTile(
                                                onTap: () {
                                                  // เพิ่มโค้ดเมื่อเลือกรายการ
                                                  setState(() {
                                                    // เช่น เพิ่มรายการที่เลือกใน selectedItem
                                                    selectedItem.add(
                                                        filterResult[index]);
                                                    selectedItemId.add(
                                                        filterResult[index].id);

                                                    _textEditingController
                                                        .clear();

                                                    context
                                                        .read<AuthBloc>()
                                                        .add(ResetAuthState());
                                                  });
                                                  widget.onSelectid(
                                                      selectedItemId);
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
                                          return Center(
                                            child: Text("No data"),
                                          );
                                        }
                                      } else if (state is AuthLoading) {
                                        return CenterLoading();
                                      } else if (state is AuthInitial) {
                                        return Padding(
                                          padding: EdgeInsets.all(1),
                                        );
                                      }
                                      return Text("ไม่พบข้อมูล");
                                    },
                                  ),
                                ),
                              )
                            ],
                          ))
                        : Container(),
                  ),
                ],
              ),
            );
          }),
        ),
      ],
    );
  }
}
