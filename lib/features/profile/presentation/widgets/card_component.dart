import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:project/core/config/theme/app_theme.dart';

class CardComponent extends StatelessWidget {
  final int id;
  final String title;
  final String imagePath;
  final bool isSelected;
  final Function(int) onSelect;

  const CardComponent({
    Key? key,
    required this.title,
    required this.id,
    required this.imagePath,
    required this.isSelected,
    required this.onSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onSelect(id); // Call the onSelect function to handle the selection
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300), // Animation duration
        padding: EdgeInsets.symmetric(
          horizontal: 24,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            width: 1,
            color: isSelected
                ? Colors.black
                : Color(0xffD0D0D0), // Animated border color
          ),
        ),
        height: 60,
        child: Row(
          children: [
            Icon(
              isSelected
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked,
              key:
                  ValueKey<bool>(isSelected), // Unique key for AnimatedSwitcher
            ),
            // ),
            const SizedBox(
              width: 12,
            ),
            Text(
              title,
              style: TextThemes.bodyBold,
            ),
            Spacer(),
            Container(
                width: 36,
                height: 36,
                child: SvgPicture.asset(
                  imagePath,
                  fit: BoxFit.contain,
                ))
          ],
        ),
      ),
    );
  }
}
