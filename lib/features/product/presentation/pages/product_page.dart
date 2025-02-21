import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project/core/common/helper/widgets/center_loading.dart';
import 'package:project/core/config/assets/svg_assets.dart';
import 'package:project/core/config/theme/app_color.dart';
import 'package:project/core/config/theme/app_theme.dart';
import 'package:project/features/product/presentation/bloc/product_bloc.dart';
import 'package:project/main.dart';

class ProductPage extends StatefulWidget {
  final int productId;
  const ProductPage({super.key, required this.productId});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  void initState() {
    // TODO: implement initState
    context.read<ProductBloc>()
      ..add(ProductDetailRequestedEvent(productId: widget.productId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is ProductDetailLoading) {
          return CenterLoading();
        } else if (state is ProductDetailLoaded) {
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
                              padding: EdgeInsets.only(
                                top: 20,
                                bottom: 20,
                              ),
                              height: 372,
                              child: Image.network(
                                "",
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
                                      Navigator.pop(context);
                                    },
                                    icon: Icon(
                                      Icons.chevron_left_outlined,
                                      size: 34,
                                    ))),
                            Positioned(
                              top: 0,
                              right: 10,
                              child: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.favorite,
                                  size: 34,
                                ),
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
                                    crossAxisAlignment: CrossAxisAlignment.end,
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
                                            "${state.product.price.min} - ${state.product.price.max} บาท",
                                            style: TextThemes.bodyBold,
                                          ),
                                          SizedBox(
                                            height: 4,
                                          ),
                                          Text(
                                            "*ราคาขึ้นอยู่กับขนาดของผลิตภัณฑ์",
                                            style: TextThemes.desc.copyWith(
                                                color: AppColors.darkGrey),
                                          )
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 6,
                                              vertical: 4,
                                            ),
                                            decoration: BoxDecoration(
                                                color: AppColors
                                                    .quality_good_match,
                                                borderRadius:
                                                    BorderRadius.circular(4)),
                                            child: Text(
                                              "61/100",
                                              style: TextThemes.descBold
                                                  .copyWith(
                                                      color: AppColors.white),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 4,
                                          ),
                                          Text(
                                            "เหมาะกับคุณมาก",
                                            style: TextThemes.desc.copyWith(
                                              color: AppColors.darkGrey,
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 24,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 116, // กำหนดความสูงให้แน่นอน
                              child: ListView.separated(
                                separatorBuilder: (context, index) {
                                  return SizedBox(
                                    width: 12,
                                  );
                                },
                                scrollDirection: Axis.horizontal,
                                itemCount: 10 + 2,
                                itemBuilder: (context, index) {
                                  if (index == 0 || index == 10 + 1) {
                                    return SizedBox(
                                      width: 20 - 12,
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                              style: TextThemes.desc.copyWith(
                                                  color: AppColors.darkGrey),
                                            ),
                                          ),
                                          Spacer(),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
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
                            ),
                            SizedBox(
                              height: 24,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "data",
                                    style: TextThemes.headline2,
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  Row(
                                    children: [
                                      Column(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(6),
                                            decoration: BoxDecoration(
                                                color: AppColors.paleBlue,
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            child: SvgPicture.asset(
                                                SvgAssets.product_good),
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
                                        children: [
                                          Text(
                                            "คุณสมบัติ",
                                            style: TextThemes.bodyBold,
                                          )
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
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
                        print("FAVORITE");
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
                              child: Icon(Icons.favorite),
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
                        onTap: () {},
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.black,
                            border: Border.all(
                              color: AppColors.black,
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                SvgAssets.product_routine,
                                color: AppColors.white,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                "เพิ่มลงรูทีน",
                                style: TextThemes.bodyBold.copyWith(
                                  color: AppColors.white,
                                ),
                              )
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

// class ProductPage extends StatelessWidget {
//   const ProductPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xffF7F7F7),
//       bottomNavigationBar: Container(
//         decoration: BoxDecoration(boxShadow: [
//           BoxShadow(
//               color: Colors.black.withOpacity(0.15),
//               blurRadius: 20,
//               offset: Offset(0, -4))
//         ]),
//         child: BottomAppBar(
//           color: Colors.white,
//           padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
//           child: Container(
//             decoration: BoxDecoration(color: Colors.white),
//             child: Row(
//               children: [
//                 GestureDetector(
//                   onTap: () {},
//                   child: Container(
//                     width: MediaQuery.of(context).size.width / 3,
//                     padding: EdgeInsets.symmetric(vertical: 10),
//                     decoration: BoxDecoration(
//                       border: Border.all(color: Colors.black),
//                       borderRadius: BorderRadius.circular(16),
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         AnimatedSwitcher(
//                           duration: Duration(
//                               milliseconds:
//                                   300), // Shortened duration for quicker feedback
//                           transitionBuilder:
//                               (Widget child, Animation<double> animation) {
//                             return ScaleTransition(
//                               scale: animation,
//                               child: child,
//                             );
//                           },
//                           child: Icon(Icons.favorite),
//                         ),
//                         SizedBox(width: 8),
//                         Text(
//                           "ถูกใจ", // "Like" in Thai
//                           style: Theme.of(context).textTheme.headlineLarge,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   width: 16,
//                 ),
//                 Expanded(
//                   child: GestureDetector(
//                     onTap: () {},
//                     child: Container(
//                         decoration: BoxDecoration(
//                             color: Colors.black,
//                             border: Border.all(color: Colors.black),
//                             borderRadius: BorderRadius.circular(16)),
//                         padding: EdgeInsets.symmetric(vertical: 10),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             SvgPicture.asset(
//                               "assets/bottomNavigation/routine.svg",
//                               color: Colors.white,
//                             ),
//                             SizedBox(
//                               width: 8,
//                             ),
//                             Text(
//                               "เพิ่มลงรูทีน",
//                               style: Theme.of(context)
//                                   .textTheme
//                                   .headlineLarge
//                                   ?.copyWith(color: Colors.white),
//                             )
//                           ],
//                         )),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//       body: FutureBuilder(
//         future: futureProduct,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           } else {
//             final product = snapshot.data!;
//             return SafeArea(
//               top: true,
//               left: false,
//               right: false,
//               bottom: false,
//               child: CustomScrollView(
//                 slivers: [
//                   SliverPersistentHeader(
//                     delegate: _SliverAppBarDelegate(
//                       minHeight: 350.0,
//                       maxHeight: 450.0,
//                       child: Stack(
//                         fit: StackFit.expand,
//                         children: [
//                           Container(
//                             padding: EdgeInsets.only(top: 20, bottom: 20),
//                             height: 372,
//                             child: Image.asset(
//                               "${product.productImg.toString()}",
//                               fit: BoxFit.contain,
//                             ),
//                           ),
//                           Positioned(
//                             top: 0,
//                             left: 10,
//                             child: IconButton(
//                               icon: const Icon(
//                                 Icons.chevron_left,
//                                 color: Colors.black,
//                                 size: 34,
//                               ),
//                               onPressed: () {
//                                 Navigator.pop(context);
//                               },
//                             ),
//                           ),
//                           Positioned(
//                             top: 0,
//                             right: 10,
//                             child: GestureDetector(
//                               onTap: () => onFavToggle(),
//                               child: AnimatedSwitcher(
//                                 transitionBuilder: (Widget child,
//                                     Animation<double> animation) {
//                                   return ScaleTransition(
//                                     scale: animation,
//                                     child: child,
//                                   );
//                                 },
//                                 duration: Duration(milliseconds: 300),
//                                 child: Icon(
//                                   isFav
//                                       ? Icons.favorite
//                                       : Icons.favorite_border,
//                                   key: ValueKey<bool>(isFav),
//                                   color: Colors.black,
//                                   size: 34,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   SliverToBoxAdapter(
//                     child: Container(
//                       decoration: BoxDecoration(
//                         boxShadow: [
//                           BoxShadow(
//                               color: Colors.black.withOpacity(0.15),
//                               blurRadius: 20,
//                               offset: Offset(0, -4))
//                         ],
//                         color: Colors.white,
//                         borderRadius: BorderRadius.only(
//                           topLeft: Radius.circular(28),
//                           topRight: Radius.circular(28),
//                         ),
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Container(
//                             padding: const EdgeInsets.only(
//                                 left: 20, right: 20, top: 24),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(product.productName.toString(),
//                                     maxLines: 2,
//                                     overflow: TextOverflow.ellipsis,
//                                     style: Theme.of(context)
//                                         .textTheme
//                                         .displayMedium),
//                                 const SizedBox(height: 12),

//                                 //New Row
//                                 Column(
//                                   children: [
//                                     Row(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Text(
//                                           product.brand,
//                                           style: Theme.of(context)
//                                               .textTheme
//                                               .bodyMedium
//                                               ?.copyWith(
//                                                   color: Color(0xff7E7E7E)),
//                                         ),
//                                         Container(
//                                             decoration: BoxDecoration(
//                                                 color: int.parse(
//                                                             product.score) >
//                                                         70
//                                                     ? Colors.green
//                                                     : int.parse(product.score) >
//                                                             35
//                                                         ? Color(0xffFFCC00)
//                                                         : int.parse(product
//                                                                     .score) >
//                                                                 0
//                                                             ? Color(0xffFF9500)
//                                                             : Colors.red,
//                                                 border: Border.all(
//                                                     width: 0,
//                                                     color: Colors.transparent),
//                                                 borderRadius:
//                                                     BorderRadius.circular(4)),
//                                             padding: EdgeInsets.symmetric(
//                                                 horizontal: 6, vertical: 4),
//                                             child: Text(
//                                               "${product.score}/100",
//                                               style: Theme.of(context)
//                                                   .textTheme
//                                                   .bodyLarge
//                                                   ?.copyWith(
//                                                       color: Colors.white),
//                                             ))
//                                       ],
//                                     ),
//                                     SizedBox(
//                                       height: 4,
//                                     ),
//                                     Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Text(
//                                           "${product.price == null || product.price.isEmpty ? "-" : "${product.price}"} บาท",
//                                           style: Theme.of(context)
//                                               .textTheme
//                                               .headlineLarge,
//                                         ),
//                                         Text(
//                                           "เหมาะแหละ",
//                                           style: Theme.of(context)
//                                               .textTheme
//                                               .bodyMedium
//                                               ?.copyWith(
//                                                   color: Color(0xff7E7E7E)),
//                                         )
//                                       ],
//                                     )
//                                   ],
//                                 ),

//                                 const SizedBox(height: 24),
//                               ],
//                             ),
//                           ),
//                           Container(
//                             height: 135,
//                             child: ListView.separated(
//                               scrollDirection: Axis.horizontal,
//                               itemBuilder: (context, index) {
//                                 if (index == 0) {
//                                   return const SizedBox(width: 8);
//                                 } else if (index == mockCardDetail.length + 1) {
//                                   return const SizedBox(width: 8);
//                                 } else {
//                                   final actualIndex = index - 1;
//                                   return CardInProductPage(
//                                     state: mockCardDetail[actualIndex]['state']
//                                         as int,
//                                     title: mockCardDetail[actualIndex]['title']
//                                         as String,
//                                     desc: mockCardDetail[actualIndex]['desc']
//                                         as String,
//                                     userDetail: mockCardDetail[actualIndex]
//                                         ['userDetail'] as String,
//                                   );
//                                 }
//                               },
//                               separatorBuilder: (context, index) => SizedBox(
//                                 width: 12,
//                               ),
//                               itemCount: mockCardDetail.length + 2,
//                             ),
//                           ),
//                           SizedBox(
//                             height: 24,
//                           ),
//                           ConPros(
//                               categorizedIngredients: categorizedIngredients),
//                           SizedBox(
//                             height: 24,
//                           ),
//                           SimilarProduct(),
//                           SizedBox(
//                             height: 24,
//                           ),
//                           Container(
//                             padding: EdgeInsets.symmetric(horizontal: 20),
//                             child: Column(
//                               children: [
//                                 LinearScore(
//                                     good: good,
//                                     avg: avg,
//                                     bad: bad,
//                                     dontKnow: dontKnow),
//                                 SizedBox(
//                                   height: 16,
//                                 ),
//                                 showAllIngredients(
//                                     ingredients: product.ingredients),
//                                 SizedBox(
//                                   height: 16,
//                                 )
//                               ],
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }
// }

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
