import 'package:flutter/material.dart';
import 'package:project/core/config/theme/app_color.dart';

class CenterLoading extends StatelessWidget {
  const CenterLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          color: AppColors.black,
          strokeWidth: 6,
        ),
      ),
    );
  }
}
