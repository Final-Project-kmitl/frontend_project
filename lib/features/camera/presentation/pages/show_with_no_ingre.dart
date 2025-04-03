import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:project/core/common/helper/navigation/app_navigation.dart';
import 'package:project/core/config/theme/app_color.dart';
import 'package:project/core/config/theme/app_theme.dart';
import 'package:project/features/camera/domain/entities/product_photo_entity.dart';
import 'package:project/features/home/presentation/pages/home_page.dart';
import 'package:project/features/home/presentation/bloc/home_bloc.dart' as home;
import 'package:project/features/product/presentation/widgets/card_benefit_scroll.dart';
import 'package:project/features/product/presentation/widgets/show_rating.dart';
import 'package:project/features/report/presentation/pages/report_page.dart';

class ShowWithNoIngre extends StatelessWidget {
  final List<DetectedIngredient> detectedIngredient;
  final ProductDetails productDetails;
  const ShowWithNoIngre({
    super.key,
    required this.detectedIngredient,
    required this.productDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
          top: true,
          child: CustomScrollView(
            slivers: [
              SliverPersistentHeader(
                delegate: _SliverAppBarDelegate(
                  minHeight: 350,
                  maxHeight: 450,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Container(
                          padding: EdgeInsets.only(top: 20, bottom: 20),
                          height: 372,
                          child: Image.asset("assets/test.img")),
                      Positioned(
                          top: 0,
                          left: 10,
                          child: IconButton(
                              onPressed: () {
                                Navigator.pop(
                                    context); // ถ้าไม่มีประวัติก่อนหน้าให้ปิดหน้าปัจจุบัน
                              },
                              icon: Icon(
                                Icons.chevron_left_outlined,
                                size: 34,
                              ))),
                      Positioned(
                        top: 0,
                        right: 10,
                        child: PopupMenuButton(
                          position: PopupMenuPosition.under,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          color: AppColors.black.withOpacity(0.8),
                          clipBehavior: Clip.hardEdge,
                          surfaceTintColor: AppColors.white,
                          itemBuilder: (context) => [
                            PopupMenuItem(
                                onTap: () {
                                  // context
                                  //     .read<home.HomeBloc>()
                                  //     .add(home.RestoreHomeEvent());

                                  AppNavigator.pushAndRemove(
                                      context, HomePage());
                                },
                                child: Container(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(
                                        Icons.home,
                                        color: AppColors.white,
                                      ),
                                      Text(
                                        "หน้าหลัก",
                                        style: TextThemes.bodyBold
                                            .copyWith(color: AppColors.white),
                                      )
                                    ],
                                  ),
                                )),
                            PopupMenuItem(
                                onTap: () {
                                  AppNavigator.push(context, ReportPage());
                                },
                                child: Container(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(
                                        Icons.report,
                                        color: AppColors.red,
                                      ),
                                      Text(
                                        "รายงาน",
                                        style: TextThemes.bodyBold
                                            .copyWith(color: AppColors.red),
                                      )
                                    ],
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.black.withOpacity(0.15),
                        blurRadius: 20,
                        offset: Offset(0, -4),
                      )
                    ],
                    color: AppColors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(28),
                      topRight: Radius.circular(28),
                    ),
                  ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding:
                              EdgeInsets.only(left: 20, right: 20, top: 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "ไม่ทราบ",
                                style: TextThemes.headline2,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "ไม่ทราบ",
                                        style: TextThemes.desc.copyWith(
                                            color: AppColors.darkGrey),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        "-",
                                        style: TextThemes.bodyBold,
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        "*ราคาขึ้นอยู่กับขนาดของผลิตภัณฑ์",
                                        style: TextThemes.desc.copyWith(
                                            color: AppColors.darkGrey),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      ShowRating(
                                        rating: productDetails.analysisRating
                                            .toString(),
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        "${int.parse(productDetails.analysisRating!) > 75 ? "เหมาะกับคุณมาก" : int.parse(productDetails.analysisRating!) > 50 ? "เหมาะกับคุณปานกลาง" : int.parse(productDetails.analysisRating!) > 25 ? "ไม่ค่อยเหมาะกับคุณ" : "ไม่เหมาะกับคุณ"}",
                                        style: TextThemes.desc.copyWith(
                                          color: AppColors.darkGrey,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 24,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(
                              color: int.parse(productDetails.analysisRating!)
                                          .floor() >
                                      75
                                  ? AppColors.light_green
                                  : int.parse(productDetails.analysisRating!)
                                              .floor() >
                                          50
                                      ? AppColors.yellow
                                      : int.parse(productDetails
                                                      .analysisRating!)
                                                  .floor() >
                                              25
                                          ? AppColors.bgOrange
                                          : AppColors.light_red),
                          //card scroll
                          child: Container(),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        // IngredientDetail(
                        //     ingredients: state.product.ingredients),
                        // const SizedBox(
                        //   height: 24,
                        // ),
                        // Container(
                        //   child:
                        //       ProductRelateCard(product: state.productRelate),
                        // ),
                        // const SizedBox(
                        //   height: 24,
                        // ),
                        // IngredientRating(
                        //   ingredients: state.product.ingredients,
                        // ),
                      ]),
                ),
              )
            ],
          )),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
