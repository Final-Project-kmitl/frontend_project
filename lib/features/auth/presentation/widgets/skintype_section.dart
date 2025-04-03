import 'package:flutter/material.dart';
import 'package:project/core/config/theme/app_theme.dart';
import 'package:project/features/auth/presentation/widgets/card_components.dart';

class QuestionSection extends StatelessWidget {
  final List<String> skinTypes;
  final List<String> skinTypeImages;
  final String? selectedSkinType;
  final Function(String) onSelect;

  const QuestionSection({
    Key? key,
    required this.skinTypes,
    required this.skinTypeImages,
    required this.selectedSkinType,
    required this.onSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            'คุณมีสภาพผิวแบบไหน?',
            style: TextThemes.headline1,
          ),
        ),
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              double itemWidth = 60;
              double itemHeight = 170;
              double aspectRatio = itemHeight / itemWidth;
              return GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: aspectRatio,
                ),
                itemCount: skinTypes.length,
                itemBuilder: (context, index) {
                  return CardComponent(
                    title: skinTypes[index],
                    imagePath: skinTypeImages[index],
                    onSelect: (type) {
                      onSelect(type);
                    },
                    isSelected: selectedSkinType == skinTypes[index],
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
