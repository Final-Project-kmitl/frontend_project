import 'package:flutter/material.dart';
import 'package:project/core/config/theme/app_color.dart';

class TextThemes {
  static const font = "IBMPlexSansThai";
  static const headline1 = TextStyle(
    fontFamily: font,
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: AppColors.black,
  );
  static const headline2 = TextStyle(
    fontFamily: font,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.black,
  );
  static const bodyBold = TextStyle(
    fontFamily: font,
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: AppColors.black,
  );
  static const body = TextStyle(
    fontFamily: font,
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.black,
  );

  static const descBold = TextStyle(
    fontFamily: font,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.black,
  );
  static const desc = TextStyle(
    fontFamily: font,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.black,
  );
}

class ButtonThemes {
  static final disableButton = ElevatedButton.styleFrom(
      backgroundColor: AppColors.grey,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)));
  static final normalButton = ElevatedButton.styleFrom(
      backgroundColor: AppColors.black,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)));
  static final denialButton = FilledButton.styleFrom(
      backgroundColor: AppColors.bg_score_card_red,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)));
  static final backwardButton = ElevatedButton.styleFrom(
      backgroundColor: AppColors.transparent,
      shadowColor: Colors.transparent,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)));
}

class AppTheme {
  static final appTheme = ThemeData(
    primaryColor: AppColors.white,
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.white,
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(width: 1, color: AppColors.beige),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(width: 1, color: AppColors.beige),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(width: 3, color: AppColors.beige),
      ),
      fillColor: AppColors.white,
      hintStyle: TextThemes.body.copyWith(color: AppColors.grey),
    ),
  );
}
