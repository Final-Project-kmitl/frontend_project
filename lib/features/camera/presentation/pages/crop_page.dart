import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:project/core/config/theme/app_color.dart';
import 'package:project/core/config/theme/app_theme.dart';

class CropPage extends StatefulWidget {
  final String imagePath;
  const CropPage({super.key, required this.imagePath});

  @override
  State<CropPage> createState() => _CropPageState();
}

class _CropPageState extends State<CropPage> {
  String? _croppedImagePath;
  bool _isCropping = true;
  Future<void> _cropImage() async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: widget.imagePath,
      aspectRatio: null, // Change here
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'กรุณาครอปเฉพาะที่เป็นส่วนผสม',
          toolbarColor: Colors.black,
          toolbarWidgetColor: Colors.white,
          lockAspectRatio: false, // Allow any aspect ratio
        ),
        IOSUiSettings(
          title: 'กรุณาครอปเฉพาะที่เป็นส่วนผสม',
          aspectRatioLockEnabled: false, // Allow any aspect ratio
        ),
      ],
    );

    if (croppedFile != null) {
      setState(() {
        _croppedImagePath = croppedFile.path;
      });
    } else {
      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    super.initState();
    _cropImage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.black,
        body: _croppedImagePath == null
            ? const Center(child: CircularProgressIndicator())
            : Stack(
                children: [
                  Center(child: Image.file(File(_croppedImagePath!))),
                  Align(
                    // Use Align instead of Positioned
                    alignment: Alignment.bottomCenter, // Align to bottom center
                    child: Padding(
                      // Add Padding for spacing
                      padding: const EdgeInsets.only(bottom: 105),
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                child: Text(
                                  "ถ่ายใหม่",
                                  style: TextThemes.bodyBold
                                      .copyWith(color: AppColors.white),
                                ),
                              ),
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context, _croppedImagePath);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(1000),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                                child: Text(
                                  "เก็บภาพ",
                                  style: TextThemes.bodyBold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ));
  }
}
