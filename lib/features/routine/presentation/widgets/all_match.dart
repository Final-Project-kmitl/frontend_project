import 'package:flutter/material.dart';
import 'package:project/core/config/theme/app_color.dart';
import 'package:project/core/config/theme/app_theme.dart';

class AllMatch extends StatelessWidget {
  const AllMatch({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: AppColors.bg_score_card_green,
          borderRadius: BorderRadius.circular(12)),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "ไม่พบส่วนผสมที่ไม่ควรใช้ร่วมกัน",
            style: TextThemes.bodyBold,
          ),
          SizedBox(
            height: 6,
          ),
          Text(
            "ไม่พบส่วนผสมที่ไม่ควรใช้ร่วมกันในรูทีนของคุณ",
            style: TextThemes.desc,
          )
        ],
      ),
    );
  }
}
