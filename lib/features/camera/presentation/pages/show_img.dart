import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/core/config/theme/app_color.dart';
import 'package:project/core/config/theme/app_theme.dart';

class ShowImg extends StatefulWidget {
  final List<XFile> photoPaht;
  final void Function(int) fn;
  const ShowImg({super.key, required this.photoPaht, required this.fn});

  @override
  State<ShowImg> createState() => _ShowImgState();
}

class _ShowImgState extends State<ShowImg> {
  late PageController _pageController;
  late int _page;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController();
    _page = 0;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff222222),
      body: Stack(
        children: [
          PageView.builder(
              controller: _pageController,
              itemCount: widget.photoPaht.length,
              onPageChanged: (value) {
                setState(() {
                  _page = value;
                });
              },
              itemBuilder: (context, index) {
                return Center(
                  child: Image.file(
                    File(widget.photoPaht[index].path), // ✅ แสดงรูปจาก path
                    fit: BoxFit.contain, // ✅ ปรับขนาดให้เหมาะสม
                  ),
                );
              }),
          SafeArea(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Align(
                alignment: Alignment.topCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        print("object");
                        Navigator.pop(context);
                      },
                      child: Text(
                        "เสร็จสิ้น",
                        style: TextThemes.bodyBold
                            .copyWith(color: AppColors.white),
                      ),
                    ),
                    Text(
                      "${_page + 1} จาก ${widget.photoPaht.length}",
                      style: TextThemes.body.copyWith(color: AppColors.white),
                    ),
                    IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              print(_page);
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16)),
                                title: Text(
                                  "ต้องการลบรูปภาพ",
                                  style: TextThemes.bodyBold,
                                ),
                                content: Text(
                                  "หากดำเนินการแล้วจะไม่สามารถแก้ไขได้",
                                  style: TextThemes.desc,
                                ),
                                actions: [
                                  GestureDetector(
                                    onTap: () async {
                                      if (widget.photoPaht.isEmpty) return;

                                      int lastIndex =
                                          widget.photoPaht.length - 1;
                                      bool isLastPic =
                                          (widget.photoPaht.length == 1 &&
                                              _page == 0);
                                      bool isFirstPic = (_page == 0);

                                      if (isLastPic) {
                                        widget.fn(_page);
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                        return;
                                      }

                                      // ถ้าภาพแรกถูกลบ → ให้เลื่อนไปภาพถัดไปก่อน
                                      if (isFirstPic) {
                                        await _pageController.animateToPage(
                                          _page + 1,
                                          duration: Duration(milliseconds: 300),
                                          curve: Curves.easeOut,
                                        );
                                        setState(() {
                                          widget.fn(_page - 1);
                                        });
                                      }
                                      // ถ้าภาพที่ไม่ใช่อันแรกถูกลบ → ให้เลื่อนไปภาพก่อนหน้า
                                      else {
                                        await _pageController.animateToPage(
                                          _page - 1,
                                          duration: Duration(milliseconds: 300),
                                          curve: Curves.easeOut,
                                        );
                                        setState(() {
                                          widget.fn(_page + 1);
                                        });
                                      }
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 8),
                                      child: Text("ทิ้งภาพ",
                                          style: TextThemes.descBold),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: AppColors.black,
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 8),
                                      child: Text("ยกเลิก",
                                          style: TextThemes.descBold.copyWith(
                                            color: AppColors.white,
                                          )),
                                    ),
                                  ),
                                ],
                              );
                            });
                      },
                      icon: Icon(
                        Icons.delete_outline_outlined,
                        size: 28,
                        color: AppColors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
