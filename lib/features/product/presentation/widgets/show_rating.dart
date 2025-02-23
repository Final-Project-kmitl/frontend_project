import 'package:flutter/material.dart';
import 'package:project/core/config/theme/app_color.dart';
import 'package:project/core/config/theme/app_theme.dart';

class ShowRating extends StatelessWidget {
  final String rating;
  const ShowRating({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    Color _containerColor() {
      var ratingInInt = double.parse(rating).toInt();

      if (ratingInInt > 70) {
        return AppColors.quality_good_match;
      } else if (ratingInInt > 35) {
        return AppColors.quality_medium_match;
      } else if (ratingInInt > 0) {
        return AppColors.quality_poor_match;
      }
      return AppColors.quality_not_math;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 6,
        vertical: 4,
      ),
      decoration: BoxDecoration(
          color: _containerColor(), borderRadius: BorderRadius.circular(4)),
      child: Text(
        "${rating}/100",
        style: TextThemes.descBold.copyWith(color: AppColors.white),
      ),
    );
  }
}
