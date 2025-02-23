import 'package:flutter/material.dart';
import 'package:project/core/config/theme/app_color.dart';
import 'package:project/core/config/theme/app_theme.dart';
import 'package:project/features/product/domain/entities/product_entity.dart';

class IngredientRating extends StatelessWidget {
  final List<IngredientEntity> ingredients;
  const IngredientRating({
    super.key,
    required this.ingredients,
  });

  @override
  Widget build(BuildContext context) {
    var good = 0;
    var avg = 0;
    var bad = 0;
    var not_rate = 0;

    for (var ingredient in ingredients) {
      if (ingredient.rating == 1 || ingredient.rating == 2) {
        good += 1;
      } else if (ingredient.rating == 3) {
        avg += 1;
      } else if (ingredient.rating == 4 || ingredient.rating == 5) {
        bad += 1;
      } else {
        not_rate += 1;
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "ส่วนผสม",
                style: TextThemes.headline2,
              ),
              Text("  ${good + avg + bad + not_rate}",
                  style: TextThemes.headline2.copyWith(
                    color: AppColors.grey,
                  ))
            ],
          ),
          SizedBox(
            height: 16,
          ),
          Row(
            children: [
              //Good section
              Expanded(
                flex: good.toInt(),
                child: good.toInt() == 0
                    ? SizedBox()
                    : Container(
                        decoration: BoxDecoration(
                            color: AppColors.light_green,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8),
                                bottomLeft: Radius.circular(8))),
                        height: 30,
                        child: Center(
                          child: Text(
                            "${good.toInt()}",
                            style: TextThemes.bodyBold
                                .copyWith(color: AppColors.green),
                          ),
                        ),
                      ),
              ),
              //AVG section
              Expanded(
                flex: avg.toInt() == 0 ? 0 : avg.toInt(),
                child: avg.toInt() == 0
                    ? SizedBox()
                    : Container(
                        decoration: BoxDecoration(
                            color: AppColors.paleBlue,
                            borderRadius: BorderRadius.only(
                                topLeft: good.toInt() == 0
                                    ? Radius.circular(8)
                                    : Radius.circular(0),
                                bottomLeft: good.toInt() == 0
                                    ? Radius.circular(8)
                                    : Radius.circular(0),
                                topRight:
                                    bad.toInt() == 0 && not_rate.toInt() == 0
                                        ? Radius.circular(8)
                                        : Radius.circular(0),
                                bottomRight:
                                    bad.toInt() == 0 && not_rate.toInt() == 0
                                        ? Radius.circular(8)
                                        : Radius.circular(0))),
                        height: 30,
                        child: Center(
                          child: Text(
                            "${avg.toInt()}",
                            style: TextThemes.bodyBold.copyWith(
                              color: AppColors.miscellaneous,
                            ),
                          ),
                        ),
                      ),
              ),
              //Bad section
              Expanded(
                flex: bad.toInt() == 0 ? 0 : bad.toInt(),
                child: bad.toInt() == 0
                    ? SizedBox()
                    : Container(
                        decoration: BoxDecoration(
                          color: AppColors.light_red,
                          borderRadius: BorderRadius.only(
                            topLeft: good.toInt() == 0 && avg.toInt() == 0
                                ? Radius.circular(8)
                                : Radius.circular(0),
                            bottomLeft: good.toInt() == 0 && avg.toInt() == 0
                                ? Radius.circular(8)
                                : Radius.circular(0),
                            topRight: not_rate.toInt() == 0
                                ? Radius.circular(8)
                                : Radius.circular(0),
                            bottomRight: not_rate.toInt() == 0
                                ? Radius.circular(8)
                                : Radius.circular(0),
                          ),
                        ),
                        height: 30,
                        child: Center(
                          child: Text(
                            "${bad.toInt()}",
                            style: TextThemes.bodyBold
                                .copyWith(color: AppColors.red),
                          ),
                        ),
                      ),
              ),
              //Not Rate section
              Expanded(
                flex: not_rate.toInt() == 0 ? 0 : not_rate.toInt(),
                child: not_rate.toInt() == 0
                    ? SizedBox()
                    : Container(
                        decoration: BoxDecoration(
                          color: AppColors.grey,
                          borderRadius: BorderRadius.only(
                              topLeft: good.toInt() == 0 &&
                                      avg.toInt() == 0 &&
                                      bad.toInt() == 0
                                  ? Radius.circular(8)
                                  : Radius.circular(0),
                              bottomLeft: good.toInt() == 0 &&
                                      avg.toInt() == 0 &&
                                      bad.toInt() == 0
                                  ? Radius.circular(8)
                                  : Radius.circular(0),
                              topRight: Radius.circular(8),
                              bottomRight: Radius.circular(8)),
                        ),
                        height: 30,
                        child: Center(
                          child: Text(
                            "${not_rate.toInt()}",
                            style: TextThemes.bodyBold
                                .copyWith(color: AppColors.darkGrey),
                          ),
                        ),
                      ),
              ),
            ],
          ),
          SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Color(0xffE4FDDA)),
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  Text(
                    "ดี",
                    style: TextThemes.body,
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Color(0xffE9F2FB)),
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  Text(
                    "กลาง",
                    style: TextThemes.body,
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Color(0xffFFD4DC)),
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  Text(
                    "แย่",
                    style: TextThemes.body,
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Color(0xffD0D0D0)),
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  Text(
                    "ไม่ทราบ",
                    style: TextThemes.body,
                  )
                ],
              ),
            ],
          ),
          SizedBox(
            height: 16,
          ),
          Container(
            padding: EdgeInsets.zero,
            child: (ingredients != null && ingredients.isNotEmpty)
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListView.separated(
                          padding: EdgeInsets.zero, // Ensure padding is zero
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            String categoriesText = ingredients[index]
                                .categories
                                .map((e) => e.name)
                                .join(",");
                            return Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: (ingredients[index].rating == 1 ||
                                            ingredients[index].rating == 2)
                                        ? AppColors.light_green
                                        : ingredients[index].rating == 3
                                            ? AppColors.paleBlue
                                            : (ingredients[index].rating == 4 ||
                                                    ingredients[index].rating ==
                                                        5)
                                                ? AppColors.light_red
                                                : AppColors.grey,
                                  ),
                                  width: 30,
                                  height: 30,
                                  child: Center(
                                      child: Text(
                                    "${index + 1}",
                                    style: TextThemes.bodyBold.copyWith(
                                      color: (ingredients[index].rating == 1 ||
                                              ingredients[index].rating == 2)
                                          ? AppColors.green
                                          : ingredients[index].rating == 3
                                              ? AppColors.miscellaneous
                                              : (ingredients[index].rating ==
                                                          4 ||
                                                      ingredients[index]
                                                              .rating ==
                                                          5)
                                                  ? AppColors.red
                                                  : AppColors.darkGrey,
                                    ),
                                  )),
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      ingredients[index].name,
                                      style: TextThemes.bodyBold,
                                    ),
                                    Text(
                                      "${categoriesText}",
                                      style: TextThemes.desc
                                          .copyWith(color: AppColors.darkGrey),
                                    ),
                                  ],
                                )
                              ],
                            );
                          },
                          separatorBuilder: (context, index) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: Divider(
                                  height: 0.5,
                                ),
                              ),
                          itemCount: ingredients.length)
                    ],
                  )
                : Center(child: Text("NO INGREDIENT")),
          ),
          // Expanded(
          //   child: ListView.separated(
          //     separatorBuilder: (context, index) {
          //       return Container(
          //         color: AppColors.darkGrey,
          //         height: 2,
          //       );
          //     },
          //     itemCount: ingredients!.length,
          //     itemBuilder: (context, index) {
          //       if (ingredients != null && ingredients.isNotEmpty) {
          //         return Row();
          //       } else {
          //         return Container(
          //           child: Center(
          //             child: Text("ผิดพลาดในการโหลด ingredient"),
          //           ),
          //         );
          //       }
          //     },
          //   ),
          // )
        ],
      ),
    );
  }
}
