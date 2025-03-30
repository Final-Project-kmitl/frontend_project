import 'package:flutter/material.dart';
import 'package:project/core/config/theme/app_color.dart';
import 'package:project/core/config/theme/app_theme.dart';

class ReloadButton extends StatelessWidget {
  final VoidCallback fn;
  const ReloadButton({super.key, required this.fn});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: AppColors.black),
        onPressed: fn,
        child: Text(
          "ลองใหม่อีกครั้ง",
          style: TextThemes.body.copyWith(color: AppColors.white),
        ));
  }
}
