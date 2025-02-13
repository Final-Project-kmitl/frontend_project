import 'package:flutter/material.dart';
import 'package:project/core/config/theme/app_color.dart';
import 'package:project/core/config/theme/app_theme.dart';

class DeleteRoutineAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  @override
  final Size preferredSize;
  final VoidCallback fn;
  final bool selectNotEmpty;

  const DeleteRoutineAppBar(
      {Key? key, required this.fn, required this.selectNotEmpty})
      : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 1,
      backgroundColor: AppColors.white,
      actions: [
        Row(
          children: [
            IconButton(
              icon: Icon(
                Icons.delete_forever_outlined,
                size: 24,
                color: selectNotEmpty ? AppColors.red : AppColors.grey,
              ),
              onPressed: fn,
            ),
            const SizedBox(
              width: 10,
            )
          ],
        )
      ],
      title: const Text(
        "แก้ไขรายการ",
        style: TextThemes.headline2,
      ),
      centerTitle: true,
    );
  }
}
