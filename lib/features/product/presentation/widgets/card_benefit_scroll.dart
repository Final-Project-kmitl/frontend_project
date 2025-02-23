import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:project/core/config/theme/app_color.dart';
import 'package:project/core/config/theme/app_theme.dart';
import 'package:project/features/product/domain/entities/product_entity.dart';

class CardBenefitScroll extends StatelessWidget {
  final UserSpecificInfoEntity userSpecificInfo;
  const CardBenefitScroll({super.key, required this.userSpecificInfo});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> items = [
      // ✅ รายการสารที่แพ้ (พื้นหลังสีแดง) → ให้รวม ingredient เป็น List
      if (userSpecificInfo.allergicIngredients.isNotEmpty)
        {
          'category': 'allergicIngredients',
          'ingredients': userSpecificInfo.allergicIngredients
              .map((item) => item.name)
              .toList(),
        },

      // ✅ รายการส่วนผสมที่อาจก่อให้เกิดปัญหา (พื้นหลังสีส้ม)
      if (userSpecificInfo.ingredientConcerns.isNotEmpty)
        ...userSpecificInfo.ingredientConcerns.map((item) => {
              'category': 'ingredientConcerns',
              'ingredient': item.ingredient.name,
              'concerns': item.concerns.map((c) => c.name).toList(),
            }),

      // ✅ รายการปัญหาผิวที่ช่วยแก้ไขได้ (พื้นหลังสีเขียว)
      if (userSpecificInfo.skinProblemSolutions.isNotEmpty)
        ...userSpecificInfo.skinProblemSolutions.map((item) => {
              'category': 'skinProblemSolutions',
              'problem': item.problem.name,
              'solvingIngredients':
                  item.solvingIngredients.map((ing) => ing.name).toList(),
            }),
    ];

    return SizedBox(
      height: 116, // กำหนดความสูงให้แน่นอน
      child: ListView.separated(
        separatorBuilder: (context, index) {
          return SizedBox(
            width: 12,
          );
        },
        scrollDirection: Axis.horizontal,
        itemCount: items.length + 2,
        itemBuilder: (context, index) {
          if (index == 0 || index == items.length + 1) {
            return SizedBox(
              width: 20 - 12,
            );
          }

          final item = items[index - 1];

          if (item['category'] == 'allergicIngredients') {
            return Container(
              height: 116,
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.bg_score_card_red,
                borderRadius: BorderRadius.circular(10),
              ),
              child: IntrinsicWidth(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "มีสารที่คุณแพ้",
                      style: TextThemes.bodyBold,
                    ),
                    SizedBox(height: 12),
                    ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 210),
                      child: Text(
                        "ผลิตภัณฑ์นี้มีส่วนผสมของ ${item['ingredients'][0]} ${item['ingredients'].length > 1 ? "เเละอื่นๆ" : ""}",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style:
                            TextThemes.desc.copyWith(color: AppColors.darkGrey),
                      ),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        SvgPicture.asset(
                          "assets/icon_pin.svg",
                          color: AppColors.red,
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Text(
                          "หนึ่งในสารที่คุณแพ้",
                          style: TextThemes.desc,
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          } else if (item['category'] == 'ingredientConcerns') {
            return Container(
              height: 116,
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.bg_score_card_orange,
                borderRadius: BorderRadius.circular(10),
              ),
              child: IntrinsicWidth(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      item['ingredient'],
                      style: TextThemes.bodyBold,
                    ),
                    SizedBox(height: 12),
                    ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 210),
                      child: Text(
                        "ผลิตภัณฑ์นี้มีส่วนผสมของ ${item['concerns'][0]} ${item['concerns'].length > 1 ? "เเละอื่นๆ" : ""} ซึ่งอาจส่งผลต่อ ${item['ingredient']}",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style:
                            TextThemes.desc.copyWith(color: AppColors.darkGrey),
                      ),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        SvgPicture.asset(
                          "assets/icon_pin.svg",
                          color: AppColors.quality_poor_match,
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Text(
                          "หนึ่งในปัญหาผิวของคุณ",
                          style: TextThemes.desc,
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          } else if (item['category'] == 'skinProblemSolutions') {
            return Container(
              height: 116,
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.bg_score_card_green,
                borderRadius: BorderRadius.circular(10),
              ),
              child: IntrinsicWidth(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      item['problem'],
                      style: TextThemes.bodyBold,
                    ),
                    SizedBox(height: 12),
                    ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 210),
                      child: Text(
                        "ผลิตภัณฑ์นี้มีส่วนผสมของ ${item['solvingIngredients'][0]} ${item['solvingIngredients'].length > 1 ? "เเละอื่นๆ" : ""} ซึ่ง ${item['problem']}",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style:
                            TextThemes.desc.copyWith(color: AppColors.darkGrey),
                      ),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        SvgPicture.asset(
                          "assets/icon_pin.svg",
                          color: AppColors.quality_good_match,
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Text(
                          "คุณมีปัญหาผิว ${item['problem']}",
                          style: TextThemes.desc,
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          }
          return Container(
            height: 116,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            child: IntrinsicWidth(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "เหมาะกับผิวแห้งและผิวผสม",
                    style: TextThemes.bodyBold,
                  ),
                  SizedBox(height: 12),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: 220,
                    ),
                    child: Text(
                      "ผลิตภัณฑ์นี้มีส่วนผสมของ (ชื่อสาร) (และอื่น ๆ) ซึ่งอาจส่งผลต่อ (ปัญหาผิว)",
                      maxLines: 2,
                      overflow: TextOverflow
                          .ellipsis, // ถ้าข้อความเกิน 2 บรรทัดให้มี ...
                      style:
                          TextThemes.desc.copyWith(color: AppColors.darkGrey),
                    ),
                  ),
                  Spacer(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        "assets/icon_pin.svg",
                        color: AppColors.black,
                        width: 16,
                        height: 16,
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Text(
                        "data",
                        style: TextThemes.desc,
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
