import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/core/config/theme/app_color.dart';
import 'package:project/core/config/theme/app_theme.dart';
import 'package:project/features/profile/domain/entities/user_entity.dart';
import 'package:project/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:project/features/profile/presentation/widgets/custom_text_form_field.dart';

class EditSkinAllergiesPage extends StatefulWidget {
  final List<AllergyEntity> allergics;
  const EditSkinAllergiesPage({super.key, required this.allergics});

  @override
  State<EditSkinAllergiesPage> createState() => _EditSkinAllergiesPageState();
}

class _EditSkinAllergiesPageState extends State<EditSkinAllergiesPage> {
  late List<AllergyEntity> _allergics = [];
  TextEditingController _textEditingController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _allergics = List.from(widget.allergics);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        surfaceTintColor: AppColors.white,
        title: const Text(
          'หน้าแก้ skin allergies',
          style: TextThemes.headline2,
        ),
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () {
            context.read<ProfileBloc>().add(ProfileLoadEvent());
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: _allergics.isEmpty
                ? Center(
                    child: Text("ไม่มีสารที่แพ้"),
                  )
                : Container(
                    width: double.infinity,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      reverse: true,
                      child: Row(
                        children: _allergics.map((allergic) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: Chip(
                              backgroundColor:
                                  _allergics.indexOf(allergic) % 2 == 0
                                      ? AppColors.black
                                      : AppColors.white,
                              labelPadding:
                                  const EdgeInsets.only(left: 12, right: 8),
                              side: BorderSide(
                                color: _allergics.indexOf(allergic) % 2 == 0
                                    ? AppColors.black
                                    : AppColors.grey,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                              onDeleted: () {
                                setState(() {
                                  _allergics.remove(
                                      allergic); // Remove item from list
                                });
                              },
                              deleteIcon: Icon(
                                Icons.close,
                                size: 20,
                                color: _allergics.indexOf(allergic) % 2 == 0
                                    ? AppColors.white
                                    : AppColors.black,
                              ),
                              label: Container(
                                constraints: BoxConstraints(maxWidth: 150),
                                child: Text(
                                  allergic.name,
                                  style: TextThemes.descBold.copyWith(
                                    color: _allergics.indexOf(allergic) % 2 == 0
                                        ? AppColors.white
                                        : AppColors.black,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
          ),
          SizedBox(
            height: 24,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomTextFormField(
                controller: _textEditingController,
                hintText: "",
                fn: (value) {},
                ondelete: () {
                  context.read<ProfileBloc>().add(DeleteQuery());
                },
                onChange: (value) {
                  if (value.isEmpty) {
                    context.read<ProfileBloc>().add(DeleteQuery());
                  } else {
                    context
                        .read<ProfileBloc>()
                        .add(QueryIngredientAllergic(query: value));
                  }
                }),
          ),
          BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              if (state is AllergicLoaded) {
                final filteredAllergy = state.allergy
                    .where((allergy) => !_allergics.contains(allergy))
                    .toList();
                if (filteredAllergy.isNotEmpty) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                    child: Container(
                      child: ListView.builder(
                          itemBuilder: (context, index) {
                            final allergy = filteredAllergy[index];

                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  _allergics.add(allergy); // ✅ อัปเดต UI ทันที
                                });

                                print(_allergics.length);

                                _textEditingController.clear();
                                context.read<ProfileBloc>().add(DeleteQuery());
                              },
                              child: ListTile(
                                title: Text(
                                  allergy.name,
                                  style: TextThemes.body,
                                  maxLines: 1,
                                ),
                              ),
                            );
                          },
                          itemCount: filteredAllergy.length),
                      height: filteredAllergy.length >= 7
                          ? 400
                          : filteredAllergy.length * 56,
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColors.grey),
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  );
                } else {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColors.grey),
                          borderRadius: BorderRadius.circular(12)),
                      height: 400,
                      child: Center(
                        child: Text(
                          "ไม่พบสารที่ต้องการค้นหา",
                          style: TextThemes.bodyBold,
                        ),
                      ),
                    ),
                  );
                }
              }
              if (state is AllergicEmpty) {
                return SizedBox();
              }

              return SizedBox();
            },
          ),
          Spacer(),
          BlocListener<ProfileBloc, ProfileState>(
            listener: (context, state) {
              if (state is UpdateAllergicLoading) {
                showDialog(
                  context: context,
                  barrierDismissible: false, // ❌ ป้องกันการกดออก
                  builder: (context) {
                    return const AlertDialog(
                      backgroundColor: AppColors.white,
                      content: Row(
                        children: [
                          CircularProgressIndicator(
                            color: AppColors.black,
                          ),
                          SizedBox(width: 16),
                          Text("กำลังอัปเดตข้อมูล..."),
                        ],
                      ),
                    );
                  },
                );
              }
              // TODO: implement listener
              if (state is UpdateAllergicSuccess) {
                context.read<ProfileBloc>().add(ProfileLoadEvent());
                Navigator.pop(context);
                Navigator.pop(context);
              }
            },
            child: GestureDetector(
              onTap: () async {
                final List<AllergyEntity> onDelete = widget.allergics
                    .where((allergy) => !_allergics.contains(allergy))
                    .toList();

                // ✅ หาค่าที่มีอยู่ใน _allergics แต่ไม่มีใน widget.allergics
                final List<AllergyEntity> onAdd = _allergics
                    .where((allergy) => !widget.allergics.contains(allergy))
                    .toList();

                context.read<ProfileBloc>().add(
                    UpdateAlleregicEvent(onAdd: onAdd, onDelete: onDelete));
              },
              child: Container(
                margin: EdgeInsets.only(bottom: 52, left: 20, right: 20),
                decoration: BoxDecoration(
                    color: AppColors.black,
                    borderRadius: BorderRadius.circular(16)),
                height: 52,
                width: double.infinity,
                child: Center(
                    child: Text(
                  "บันทึก",
                  style: TextThemes.bodyBold.copyWith(color: AppColors.white),
                )),
              ),
            ),
          )
        ],
      ),
    );
  }
}
