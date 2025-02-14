// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';

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

// class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
//   _SliverAppBarDelegate({
//     required this.minHeight,
//     required this.maxHeight,
//     required this.child,
//   });

//   final double minHeight;
//   final double maxHeight;
//   final Widget child;

//   @override
//   double get minExtent => minHeight;

//   @override
//   double get maxExtent => maxHeight;

//   @override
//   Widget build(
//       BuildContext context, double shrinkOffset, bool overlapsContent) {
//     return SizedBox.expand(child: child);
//   }

//   @override
//   bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
//     return maxHeight != oldDelegate.maxHeight ||
//         minHeight != oldDelegate.minHeight ||
//         child != oldDelegate.child;
//   }
// }
