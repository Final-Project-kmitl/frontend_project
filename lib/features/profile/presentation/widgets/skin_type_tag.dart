import 'package:flutter/material.dart';
import 'package:project/core/config/theme/app_color.dart';
import 'package:project/core/config/theme/app_theme.dart';

class SkinTypeTag extends StatelessWidget {
  final String text;
  final Color color;

  const SkinTypeTag({
    super.key,
    required this.text,
    this.color = AppColors.beige, // ค่าเริ่มต้นเป็นสีน้ำเงิน
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      margin:
          const EdgeInsets.only(right: 12, bottom: 12), // เว้นระยะระหว่างแท็ก
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: TextThemes.bodyBold.copyWith(color: AppColors.black),
      ),
    );
  }
}
