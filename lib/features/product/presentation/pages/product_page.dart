import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project/core/common/helper/navigation/app_navigation.dart';
import 'package:project/core/common/widgets/center_loading.dart';
import 'package:project/core/config/assets/svg_assets.dart';
import 'package:project/core/config/theme/app_color.dart';
import 'package:project/core/config/theme/app_theme.dart';
import 'package:project/features/home/presentation/bloc/home_bloc.dart' as home;
import 'package:project/features/home/presentation/pages/home_page.dart';
import 'package:project/features/product/presentation/bloc/product_bloc.dart';
import 'package:project/features/product/presentation/widgets/card_benefit_scroll.dart';
import 'package:project/features/product/presentation/widgets/ingredient_detail.dart';
import 'package:project/features/product/presentation/widgets/ingredient_rating.dart';
import 'package:project/features/product/presentation/widgets/product_relate_card.dart';
import 'package:project/features/product/presentation/widgets/show_rating.dart';
import 'package:project/features/report/presentation/pages/report_page.dart';

class ProductPage extends StatefulWidget {
  final int productId;
  const ProductPage({super.key, required this.productId});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  void initState() {
    super.initState();
    context
        .read<ProductBloc>()
        .add(ProductDetailRequestedEvent(productId: widget.productId));
  }

  // @override
  // void didUpdateWidget(ProductPage oldWidget) {
  //   super.didUpdateWidget(oldWidget);
  //   if (oldWidget.productId != widget.productId) {
  //     context
  //         .read<ProductBloc>()
  //         .add(ProductDetailRequestedEvent(productId: widget.productId));
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is ProductDetailLoading) {
          return CenterLoading();
        } else if (state is ProductDetailLoaded) {
          print("📱 Rendering ProductDetailLoaded UI");
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
                              child: Image.network(
                                state.product.imageUrl ?? "",
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                  if (loadingProgress == null) {
                                    return child;
                                  } else {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                },
                                errorBuilder: (context, error, stackTrace) {
                                  return Image.asset(
                                    "assets/test_img.png",
                                    fit: BoxFit.contain,
                                  );
                                },
                              ),
                            ),
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
                                        context
                                            .read<home.HomeBloc>()
                                            .add(home.RestoreHomeEvent());

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
                                                  .copyWith(
                                                      color: AppColors.white),
                                            )
                                          ],
                                        ),
                                      )),
                                  PopupMenuItem(
                                      onTap: () {
                                        AppNavigator.push(
                                            context, ReportPage());
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
                                                  .copyWith(
                                                      color: AppColors.red),
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
                                padding: EdgeInsets.only(
                                    left: 20, right: 20, top: 24),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${state.product.name}",
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${state.product.brand}",
                                              style: TextThemes.desc.copyWith(
                                                  color: AppColors.darkGrey),
                                            ),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Text(
                                              (state.product.price.max == "0" &&
                                                      state.product.price.min ==
                                                          "0")
                                                  ? "- บาท"
                                                  : (state.product.price.max ==
                                                          state.product.price
                                                              .min)
                                                      ? "${state.product.price.max} บาท"
                                                      : "${state.product.price.max} - ${state.product.price.min} บาท",
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            ShowRating(
                                              rating: state.product.rating
                                                  .toString(),
                                            ),
                                            SizedBox(
                                              height: 4,
                                            ),
                                            Text(
                                              "${state.product.rating > 75 ? "เหมาะกับคุณมาก" : state.product.rating > 50 ? "เหมาะกับคุณปานกลาง" : state.product.rating > 25 ? "ไม่ค่อยเหมาะกับคุณ" : "ไม่เหมาะกับคุณ"}",
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
                                    color: state.product.rating.floor() > 75
                                        ? AppColors.light_green
                                        : state.product.rating.floor() > 50
                                            ? AppColors.yellow
                                            : state.product.rating.floor() > 25
                                                ? AppColors.bgOrange
                                                : AppColors.light_red),
                                child: CardBenefitScroll(
                                    userSpecificInfo:
                                        state.product.userSpecificInfo),
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              IngredientDetail(
                                  ingredients: state.product.ingredients),
                              const SizedBox(
                                height: 24,
                              ),
                              Container(
                                child: ProductRelateCard(
                                    product: state.productRelate),
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              IngredientRating(
                                ingredients: state.product.ingredients,
                              ),
                            ]),
                      ),
                    )
                  ],
                )),
            bottomNavigationBar: Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: AppColors.black.withOpacity(0.15),
                  blurRadius: 20,
                  offset: Offset(0, -4),
                )
              ]),
              child: BottomAppBar(
                color: AppColors.white,
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        context.read<ProductBloc>().add(ToggleFavoriteEvent(
                            productId: widget.productId,
                            isFavorite: !state.isFav));
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width / 3,
                        padding: EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.black,
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AnimatedSwitcher(
                              duration: Duration(seconds: 1),
                              transitionBuilder: (child, animation) {
                                return ScaleTransition(
                                  scale: animation,
                                  child: child,
                                );
                              },
                              child: state.isFav
                                  ? Icon(Icons.favorite)
                                  : Icon(Icons.favorite_border),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              "ถูกใจ",
                              style: TextThemes.bodyBold,
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: (state.isRoutine ?? false) ||
                                (state.routineCount ?? 0) >= 10
                            ? null
                            : () {
                                context.read<ProductBloc>().add(
                                    AddProductToRoutineEvent(
                                        productId: widget.productId));
                              },
                        child: Container(
                          decoration: BoxDecoration(
                            color: state.isRoutine || state.routineCount! >= 10
                                ? AppColors.grey
                                : AppColors.black, // เปลี่ยนสีปุ่ม
                            border: Border.all(
                              color:
                                  state.isRoutine || state.routineCount! >= 10
                                      ? AppColors.grey
                                      : AppColors.black, // เปลี่ยนสีขอบ
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                SvgAssets.product_routine,
                                color:
                                    state.isRoutine || state.routineCount! >= 10
                                        ? AppColors.darkGrey
                                        : AppColors.white,
                              ),
                              SizedBox(width: 8),
                              Text(
                                state.isRoutine!
                                    ? "อยู่ในรูทีนแล้ว"
                                    : state.routineCount! >= 10
                                        ? "สินค้าเกินกำหนด"
                                        : "เพิ่มลงรูทีน",
                                style: TextThemes.bodyBold.copyWith(
                                  color: state.isRoutine! ||
                                          state.routineCount! >= 10
                                      ? AppColors.darkGrey
                                      : AppColors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        return Center(
          child: Text(state.toString()),
        );
      },
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
