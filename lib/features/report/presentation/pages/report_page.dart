import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobkit_dashed_border/mobkit_dashed_border.dart';
import 'package:project/core/common/helper/navigation/app_navigation.dart';
import 'package:project/core/config/theme/app_color.dart';
import 'package:project/core/config/theme/app_theme.dart';
import 'package:project/features/home/presentation/bloc/home_bloc.dart';
import 'package:project/features/home/presentation/pages/home_page.dart';
import 'package:project/features/report/presentation/widgets/text_field.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  TextEditingController productText = TextEditingController();
  TextEditingController brandText = TextEditingController();
  TextEditingController ingredientText = TextEditingController();
  List<File> image = [];
  int? selectedIndex;

  void _showActionsheet(BuildContext context) {
    showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoActionSheet(
              title: Text(
                "นำเข้ารูปภาพ",
                style: TextThemes.bodyBold,
              ),
              actions: <CupertinoActionSheetAction>[
                CupertinoActionSheetAction(
                  onPressed: () async {
                    final pickedFile = await ImagePicker()
                        .pickImage(source: ImageSource.camera);
                    if (pickedFile != null && pickedFile.path != null) {
                      setState(() {
                        image.add(File(pickedFile.path));
                      });
                    }
                  },
                  child: Text("กล้องถ่ายรูป"),
                ),
                CupertinoActionSheetAction(
                  onPressed: () async {
                    final pickedFile = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);
                    if (pickedFile != null && pickedFile.path != null) {
                      setState(() {
                        image.add(File(pickedFile.path));
                      });
                    }
                    Navigator.pop(context);
                  },
                  child: Text("แกลลอรี่"),
                )
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        setState(() {
          selectedIndex = null;
        });
      },
      child: Scaffold(
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 52),
          child: ElevatedButton(
            onPressed: () async {
              showDialog(
                  barrierDismissible: true,
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text(
                        "ส่งรายงานเรียบร้อย",
                        style: TextThemes.headline2,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      backgroundColor: AppColors.white,
                      icon: Icon(
                        Icons.check_circle_outline_outlined,
                        size: 80,
                        color: AppColors.quality_good_match,
                      ),
                    );
                  });

              await Future.delayed(Duration(seconds: 2));

              context.read<HomeBloc>().add(RestoreHomeEvent());
              AppNavigator.pushAndRemove(context, HomePage());
            },
            style: ((productText.text.isEmpty || brandText.text.isEmpty) ||
                    (ingredientText.text.isEmpty && image.length == 0))
                ? ElevatedButton.styleFrom(
                    backgroundColor: AppColors.grey, // สีปุ่ม
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 16),
                  )
                : ElevatedButton.styleFrom(
                    backgroundColor: AppColors.black, // สีปุ่ม
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 16),
                  ),
            child: Text(
              "ส่งรายงาน",
              style: TextThemes.bodyBold.copyWith(color: Colors.white),
            ),
          ),
        ),
        appBar: AppBar(
          backgroundColor: AppColors.white,
          surfaceTintColor: AppColors.white,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.chevron_left)),
          title: Text(
            "รายงาน",
            style: TextThemes.headline2,
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(TextSpan(
                        text: "ชื่อผลิตภัณฑ์ที่คุณตามหา",
                        style: TextThemes.bodyBold,
                        children: <InlineSpan>[
                          TextSpan(
                              text: "*",
                              style: TextThemes.bodyBold
                                  .copyWith(color: AppColors.red))
                        ])),
                    SizedBox(
                      height: 12,
                    ),
                    TextReport(
                        textEditingController: productText,
                        hintText: "เช่น Senka All Clear Double W "),
                    SizedBox(
                      height: 24,
                    ),
                    Text.rich(TextSpan(
                        text: "ยี่ห้อผลิตภัณฑ์ที่คุณตามหา",
                        style: TextThemes.bodyBold,
                        children: <InlineSpan>[
                          TextSpan(
                              text: "*",
                              style: TextThemes.bodyBold
                                  .copyWith(color: AppColors.red))
                        ])),
                    SizedBox(
                      height: 12,
                    ),
                    TextReport(
                        textEditingController: brandText,
                        hintText: "เช่น Senka "),
                    SizedBox(
                      height: 24,
                    ),
                    Text.rich(TextSpan(
                      text: "รายการส่วนผสมของผลิตภัณฑ์",
                      style: TextThemes.bodyBold,
                    )),
                    SizedBox(
                      height: 12,
                    ),
                    TextField(
                      controller: ingredientText,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: AppColors.black),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: AppColors.black),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                                  BorderSide(color: AppColors.black, width: 2)),
                          hintText:
                              "เช่น Water, Isopentyldiol, Glycerin, 1,2-Hexanediol"),
                      minLines: 3, // แสดงเริ่มต้น 3 บรรทัด
                      maxLines: 5,
                      keyboardType: TextInputType.multiline,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Expanded(child: Divider()),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          "หรือ",
                          style: TextThemes.descBold
                              .copyWith(color: AppColors.grey),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Expanded(child: Divider())
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    GridView.builder(
                      shrinkWrap: true, // เพิ่ม shrinkWrap: true
                      physics:
                          NeverScrollableScrollPhysics(), // ป้องกันการ scroll ของ GridView
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 1,
                          crossAxisSpacing: 10),
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        if (index < image.length) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                if (selectedIndex == index) {
                                  image.removeAt(
                                      index); // ลบรูปภาพถ้ากดซ้ำที่ตำแหน่งเดิม
                                  selectedIndex = null;
                                } else {
                                  selectedIndex = index;
                                }
                              });
                            },
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Image.file(
                                    image[index],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                if (selectedIndex ==
                                    index) // แสดงไอคอนถังขยะถ้าถูกเลือก
                                  Expanded(
                                      child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color:
                                            AppColors.black.withOpacity(0.3)),
                                    child: Center(
                                      child: Icon(
                                        Icons.delete_forever,
                                        size: 42,
                                        color: AppColors.white,
                                      ),
                                    ),
                                  ))
                              ],
                            ),
                          );
                        }
                        if (index == image.length) {
                          return GestureDetector(
                            onTap: () => _showActionsheet(context),
                            child: Container(
                              decoration: BoxDecoration(
                                border: DashedBorder.fromBorderSide(
                                  dashLength: 5,
                                  side: BorderSide(
                                      color: AppColors.grey, width: 1),
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.add_photo_alternate,
                                  color: AppColors.darkGrey,
                                  size: 40,
                                ),
                              ),
                            ),
                          );
                        }

                        return Container();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
