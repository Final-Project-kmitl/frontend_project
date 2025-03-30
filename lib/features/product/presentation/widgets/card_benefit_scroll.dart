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
              'concerns': item.concern.name,
              'ingredients': item.ingredients.map((c) => c.name).toList(),
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
                color: AppColors.white,
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
                color: AppColors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: IntrinsicWidth(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "${item['concerns'] == "มีจุดด่างดำ" ? 'จุดด่างดำ' : item['concerns'] == "เป็นสิว" ? 'สิว' : item['concerns'] == "มีริ้วรอย" ? 'ริ้วรอย' : item['concerns'] == "รูขุมขนกว้าง" ? 'รูขุมขนกว้าง' : item['concerns'] == "หน้ามัน" ? 'หน้ามัน' : item['concerns'] == "สีผิวไม่สม่ำเสมอ" ? 'สีผิวไม่สม่ำเสมอ' : item['concerns'] == "ผิวขาดความชุ่มชื้น/แสบแดง" ? 'อาจทำให้ผิวขาดความชุ่มชื้น/แสบแดง' : 'ผิวไม่เรียบเนียน'}",
                      style: TextThemes.bodyBold,
                    ),
                    SizedBox(height: 12),
                    ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 240),
                      child: Text(
                        "ผลิตภัณฑ์นี้มีส่วนผสมของ ${item['ingredients'][0]} ${item['concerns'].length > 1 ? "เเละอื่นๆ" : ""} ซึ่งอาจส่งผล${item['concerns'] == "มีจุดด่างดำ" ? 'จุดด่างดำบนใบหน้า' : item['concerns'] == "เป็นสิว" ? 'สิวบนใบหน้า' : item['concerns'] == "มีริ้วรอย" ? 'ริ้วรอยบนใบหน้า' : item['concerns'] == "รูขุมขนกว้าง" ? 'ทำให้รูขุมขนกว้าง' : item['concerns'] == "หน้ามัน" ? 'ต่อความหน้ามัน' : item['concerns'] == "สีผิวไม่สม่ำเสมอ" ? 'ทำให้สีผิวไม่สม่ำเสมอ' : item['concerns'] == "ผิวขาดความชุ่มชื้น/แสบแดง" ? 'ทำให้ผิวขาดความชุ่มชื้น/แสบแดง' : 'ทำให้ผิวไม่เรียบเนียน'}",
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
                color: AppColors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: IntrinsicWidth(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "${item['problem'] == "มีจุดด่างดำ" ? 'ช่วยลดจุดด่างดำ' : item['problem'] == "เป็นสิว" ? 'ช่วยลดสิว' : item['problem'] == "มีริ้วรอย" ? 'ลดริ้วรอย' : item['problem'] == "รูขุมขนกว้าง" ? 'กระชับรูขุมขน' : item['problem'] == "หน้ามัน" ? 'ลดความมัน' : item['problem'] == "สีผิวไม่สม่ำเสมอ" ? 'ช่วยให้ผิวสม่ำเสมอ' : item['problem'] == "ผิวขาดความชุ่มชื้น/แสบแดง" ? 'เพิ่มความชุ่มชื้น' : 'ช่วยให้ผิวเรียบเนียน'}",
                      style: TextThemes.bodyBold,
                    ),
                    SizedBox(height: 12),
                    ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 210),
                      child: Text(
                        "ผลิตภัณฑ์นี้มีส่วนผสมของ ${item['solvingIngredients'][0]} ${item['solvingIngredients'].length > 1 ? "เเละอื่นๆ" : ""} ซึ่ง${item['problem'] == "มีจุดด่างดำ" ? 'ช่วยลดจุดด่างดำ' : item['problem'] == "เป็นสิว" ? 'ช่วยลดสิว' : item['problem'] == "มีริ้วรอย" ? 'ลดริ้วรอย' : item['problem'] == "รูขุมขนกว้าง" ? 'กระชับรูขุมขน' : item['problem'] == "หน้ามัน" ? 'ลดความมัน' : item['problem'] == "สีผิวไม่สม่ำเสมอ" ? 'ช่วยให้ผิวสม่ำเสมอ' : item['problem'] == "ผิวขาดความชุ่มชื้น/แสบแดง" ? 'เพิ่มความชุ่มชื้นให้กับผิว' : 'ช่วยทำให้ผิวเรียบเนียน'}",
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
                          "คุณมีปัญหา${item['problem']}",
                          style: TextThemes.desc,
                          overflow: TextOverflow.ellipsis,
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
