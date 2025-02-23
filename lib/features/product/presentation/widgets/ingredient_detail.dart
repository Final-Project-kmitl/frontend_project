import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:project/core/config/assets/svg_assets.dart';
import 'package:project/core/config/theme/app_color.dart';
import 'package:project/core/config/theme/app_theme.dart';
import 'package:project/features/product/domain/entities/product_entity.dart';

class IngredientDetail extends StatelessWidget {
  final List<IngredientEntity> ingredients;
  const IngredientDetail({
    super.key,
    required this.ingredients,
  });

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> groupIngredientsByBenefitOrConcern(
        List<Map<String, dynamic>> ingredients) {
      Map<String, List<String>> good = {};
      Map<String, List<String>> bad = {};

      for (var ingredient in ingredients) {
        //Group for good benefit
        for (var benefit in ingredient['benefits']) {
          String benefitName = benefit['name'];
          if (!good.containsKey(benefitName)) {
            good[benefitName] = [];
          }
          good[benefitName]!.add(ingredient['name']);
        }

        //Group for bad benefit
        for (var concern in ingredient['concerns']) {
          String benefitName = concern['name'];
          if (!bad.containsKey(benefitName)) {
            bad[benefitName] = [];
          }
          bad[benefitName]!.add(ingredient['name']);
        }
      }

      return {'good': good, 'bad': bad};
    }

    List<Map<String, dynamic>> ingredientList = ingredients.map((ingredient) {
      return {
        'id': ingredient.id,
        'name': ingredient.name,
        'rating': ingredient.rating,
        'categories': ingredient.categories
            .map((c) => {'id': c.id, 'name': c.name})
            .toList(),
        'benefits': ingredient.benefits
            .map((b) => {'id': b.id, 'name': b.name})
            .toList(),
        'concerns': ingredient.concerns
            .map((c) => {'id': c.id, 'name': c.name})
            .toList(),
      };
    }).toList();

    print("asdfasdf : ${groupIngredientsByBenefitOrConcern(ingredientList)}");

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "รายละเอียด",
            style: TextThemes.headline2,
          ),
          SizedBox(
            height: 16,
          ),

          //คุณสมบัติ
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                        color: AppColors.paleBlue,
                        borderRadius: BorderRadius.circular(8)),
                    child: SvgPicture.asset(SvgAssets.product_good),
                  ),
                  Container(
                    width: 3,
                    color: AppColors.darkGrey,
                  )
                ],
              ),
              SizedBox(
                width: 16,
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "คุณสมบัติ",
                        style: TextThemes.bodyBold,
                      ),
                      Wrap(
                        clipBehavior: Clip.none,
                        spacing: 6,
                        runSpacing: 0,
                        children: groupIngredientsByBenefitOrConcern(
                                ingredientList)['good']
                            .entries
                            .map<Widget>(
                              (entry) => GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Dialog(
                                        backgroundColor: Colors.white,
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize
                                                .min, // ป้องกัน Column จากการขยายเต็มจอ
                                            children: [
                                              /// **🔹 Header และปุ่มปิด**
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "${entry.key}",
                                                    style: TextThemes.bodyBold,
                                                  ),
                                                  GestureDetector(
                                                    onTap: () =>
                                                        Navigator.pop(context),
                                                    child: Icon(Icons.close),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 16),

                                              /// **🔹 ข้อความอธิบาย**
                                              Text(
                                                "ผลิตภัณฑ์นี้มีสารที่ช่วยเรื่อง${entry.key}อยู่ ${entry.value.length} ตัว",
                                                style: TextThemes.desc,
                                              ),
                                              const SizedBox(height: 16),

                                              /// **🔹 รายการแสดงผล พร้อม Bullet**
                                              SizedBox(
                                                height: entry.value.length > 20
                                                    ? 300
                                                    : null, // จำกัดความสูง
                                                child: ListView.builder(
                                                  shrinkWrap: true,
                                                  physics: entry.value.length >
                                                          20
                                                      ? AlwaysScrollableScrollPhysics()
                                                      : NeverScrollableScrollPhysics(),
                                                  itemCount: entry.value.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 1.0),
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                        children: [
                                                          Text("• ",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      16)),
                                                          Expanded(
                                                            child: Text(
                                                              entry.value[
                                                                  index], // ชื่อสารแต่ละตัว
                                                              style: TextThemes
                                                                  .descBold,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Chip(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 6),
                                  backgroundColor: AppColors.paleBlue,
                                  label: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        "${entry.key}",
                                        style: TextThemes.descBold.copyWith(
                                            color: AppColors.miscellaneous),
                                      ),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Container(
                                        width: 20,
                                        height: 20,
                                        decoration: BoxDecoration(
                                          color: AppColors.white,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Center(
                                          child: Text(
                                            "${entry.value.length}",
                                            style: TextThemes.desc.copyWith(
                                                color: AppColors.miscellaneous),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      width: 0,
                                      color: AppColors.transparent,
                                    ),
                                    borderRadius: BorderRadius.circular(1000),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),

          SizedBox(
            height: 16,
          ),
          //ที่ต้องระวัง
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                        color: AppColors.bg_score_card_orange,
                        borderRadius: BorderRadius.circular(8)),
                    child: SvgPicture.asset(SvgAssets.product_hand),
                  ),
                  Container(
                    width: 3,
                    color: AppColors.darkGrey,
                  )
                ],
              ),
              SizedBox(
                width: 16,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "ที่ต้องระวัง",
                    style: TextThemes.bodyBold,
                  ),
                  Wrap(
                      clipBehavior: Clip.none,
                      spacing: 6,
                      children: groupIngredientsByBenefitOrConcern(
                              ingredientList)['bad']
                          .entries
                          .map<Widget>(
                            (entry) => GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Dialog(
                                      backgroundColor: Colors.white,
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize
                                              .min, // ป้องกัน Column จากการขยายเต็มจอ
                                          children: [
                                            /// **🔹 Header และปุ่มปิด**
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "${entry.key}",
                                                  style: TextThemes.bodyBold,
                                                ),
                                                GestureDetector(
                                                  onTap: () =>
                                                      Navigator.pop(context),
                                                  child: Icon(Icons.close),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 16),

                                            /// **🔹 ข้อความอธิบาย**
                                            Text(
                                              "ผลิตภัณฑ์นี้มีสารที่อาจ${entry.key}อยู่ ${entry.value.length} ตัว",
                                              style: TextThemes.desc,
                                            ),
                                            const SizedBox(height: 16),

                                            /// **🔹 รายการแสดงผล พร้อม Bullet**
                                            SizedBox(
                                              height: entry.value.length > 20
                                                  ? 300
                                                  : null, // จำกัดความสูง
                                              child: ListView.builder(
                                                shrinkWrap: true,
                                                physics: entry.value.length > 20
                                                    ? AlwaysScrollableScrollPhysics()
                                                    : NeverScrollableScrollPhysics(),
                                                itemCount: entry.value.length,
                                                itemBuilder: (context, index) {
                                                  return Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 1.0),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        Text("• ",
                                                            style: TextStyle(
                                                                fontSize: 16)),
                                                        Expanded(
                                                          child: Text(
                                                            entry.value[
                                                                index], // ชื่อสารแต่ละตัว
                                                            style: TextThemes
                                                                .descBold,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Chip(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 6),
                                backgroundColor: AppColors.bgOrange,
                                label: Row(
                                  children: [
                                    Text(
                                      "${entry.key}",
                                      style: TextThemes.descBold
                                          .copyWith(color: AppColors.orage),
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Container(
                                      width: 20,
                                      height: 20,
                                      decoration: BoxDecoration(
                                        color: AppColors.white,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Center(
                                        child: Text(
                                          "${entry.value.length}",
                                          style: TextThemes.desc
                                              .copyWith(color: AppColors.orage),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    width: 0,
                                    color: AppColors.transparent,
                                  ),
                                  borderRadius: BorderRadius.circular(1000),
                                ),
                              ),
                            ),
                          )
                          .toList())
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
