import 'package:flutter/material.dart';
import 'package:project/core/config/theme/app_color.dart';
import 'package:project/core/config/theme/app_theme.dart';

class SearchBox extends StatelessWidget {
  const SearchBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      height: 36,
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.beige),
          borderRadius: BorderRadius.circular(1000)),
      child: Row(
        children: [
          Icon(Icons.search),
          SizedBox(
            width: 12,
          ),
          Text(
            "ค้นหาชื่อผลิตภัณฑ์, ยี่ห้อ, ส่วนประกอบ",
            style: TextThemes.desc.copyWith(color: AppColors.grey),
          )
        ],
      ),
    );
  }
}
