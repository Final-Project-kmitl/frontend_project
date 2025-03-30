import 'package:flutter/material.dart';
import 'package:project/core/config/theme/app_color.dart';

class TextReport extends StatelessWidget {
  final String hintText;
  final TextEditingController textEditingController;
  const TextReport(
      {super.key, required this.textEditingController, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.black),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.black),
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.black, width: 1.5),
              borderRadius: BorderRadius.circular(12))),
    );
  }
}
