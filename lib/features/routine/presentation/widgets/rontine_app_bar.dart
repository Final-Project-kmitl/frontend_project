import 'package:flutter/material.dart';
import 'package:project/core/common/helper/navigation/app_navigation.dart';
import 'package:project/core/config/theme/app_color.dart';
import 'package:project/core/config/theme/app_theme.dart';
import 'package:project/features/routine/presentation/pages/routine_delete_page.dart';
import 'package:project/features/routine/presentation/pages/search_product_page.dart';

class RoutineAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  final bool isRoutineFull;

  final bool isEmpty;

  RoutineAppBar({
    Key? key,
    required this.isRoutineFull,
    required this.isEmpty,
  })  : preferredSize = const Size.fromHeight(kToolbarHeight), // ✅ กำหนดขนาด
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      shadowColor: Colors.transparent,
      backgroundColor: AppColors.white,
      surfaceTintColor: Colors.white,
      actions: [
        Row(
          children: [
            IconButton(
              icon: Icon(
                Icons.checklist_rtl,
                size: 24,
                color: isEmpty ? AppColors.darkGrey : AppColors.black,
              ),
              onPressed: isEmpty
                  ? null
                  : () {
                      AppNavigator.push(context, RoutineDeletePage());
                    },
            ),
            IconButton(
              onPressed: () {
                AppNavigator.push(context, SearchProductPage());
              },
              icon: const Icon(
                Icons.add_circle_outline,
                size: 24,
                color: AppColors.black,
              ),
            ),
            const SizedBox(
              width: 10,
            )
          ],
        )
      ],
      title: const Text(
        "เช็คสกินแคร์รูทีน",
        style: TextThemes.headline2,
      ),
      centerTitle: true,
    );
  }
}
