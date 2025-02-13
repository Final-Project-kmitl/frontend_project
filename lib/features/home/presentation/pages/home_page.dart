import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:project/core/common/helper/navigation/app_navigation.dart';
import 'package:project/core/config/assets/svg_assets.dart';
import 'package:project/core/config/theme/app_color.dart';
import 'package:project/core/config/theme/app_theme.dart';
import 'package:project/features/favorite/presentation/pages/favorite_page.dart';
import 'package:project/features/home/presentation/widgets/category_section.dart';
import 'package:project/features/home/presentation/widgets/search_box.dart';
import 'package:project/features/home/presentation/widgets/search_textfield.dart';
import 'package:project/features/home/presentation/widgets/suggestion_section.dart';
import 'package:project/features/profile/presentation/pages/profile_page.dart';
import 'package:project/features/routine/presentation/pages/routine_page.dart';
import 'package:project/features/search/presentation/pages/search_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController? _pageController;
  int _currentPage = 0;
  double _bottomsize = 62;

  Route createFadeRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => SearchPage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: _bottomsize,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: AppColors.white.withOpacity(0.7),
              borderRadius: BorderRadius.circular(16),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaY: 3, sigmaX: 3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      onPressed: () {
                        if (_currentPage != 0) {
                          _pageController!.jumpToPage(0);
                          setState(() => _currentPage = 0);
                        }
                      },
                      icon: SvgPicture.asset(
                        SvgAssets.navigatorHome,
                        color: _currentPage == 0
                            ? AppColors.black
                            : AppColors.darkGrey,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        AppNavigator.push(context, const RoutinePage());
                        setState(() {
                          _currentPage = 0;
                        });
                        _pageController!.jumpToPage(0);
                      },
                      icon: SvgPicture.asset(
                        SvgAssets.navigatorRoutine,
                        color: AppColors.darkGrey,
                      ),
                    ),
                    const SizedBox(
                      width: 62,
                    ),
                    IconButton(
                      onPressed: () {
                        _pageController!.jumpToPage(1);
                        setState(() => _currentPage = 1);
                      },
                      icon: SvgPicture.asset(
                        SvgAssets.navigatorFav,
                        color: _currentPage == 1
                            ? AppColors.black
                            : AppColors.darkGrey,
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          _pageController!.jumpToPage(2);
                          setState(() {
                            _currentPage = 2;
                          });
                        },
                        icon: SvgPicture.asset(
                          SvgAssets.navigatorProfile,
                          color: _currentPage == 2
                              ? AppColors.black
                              : AppColors.darkGrey,
                        ))
                  ],
                ),
              ),
            ),
          ),
          Positioned(
              left: MediaQuery.sizeOf(context).width / 2 - 31,
              bottom: 19,
              child: Container(
                width: 62,
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.black,
                ),
                child: SvgPicture.asset(
                  SvgAssets.navigatorScan,
                ),
              ))
        ],
      ),
      body: Stack(
        children: [
          PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _pageController,
            children: [
              SafeArea(
                bottom: false,
                child: CustomScrollView(
                  slivers: [
                    const SliverAppBar(
                      backgroundColor: Colors.white,
                      title: Text(
                        "หน้าหลัก",
                        style: TextThemes.headline1,
                      ),
                      floating: false,
                    ),
                    SliverPersistentHeader(
                      delegate: _SliverAppBarDelegate(
                        minHeight: 60.0,
                        maxHeight: 60.0,
                        child: Material(
                          elevation: 0,
                          color: Colors.white,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(16),
                              bottomRight: Radius.circular(16),
                            ),
                          ),
                          child: Container(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, bottom: 20),
                            child: GestureDetector(
                              onTap: () =>
                                  AppNavigator.push(context, SearchPage()),
                              child: SearchBox(),
                            ),
                          ),
                        ),
                      ),
                      pinned: true,
                    ),
                    const SliverToBoxAdapter(
                      child: CategorySection(),
                    ),
                    const SliverToBoxAdapter(
                      child: SuggestionSection(),
                    ),
                    const SliverToBoxAdapter(
                      child: SuggestionSection(),
                    ),
                    const SliverToBoxAdapter(
                      child: SuggestionSection(),
                    ),
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: _bottomsize + 82,
                      ),
                    )
                  ],
                ),
              ),
              const FavoritePage(),
              const ProfilePage(),
            ],
          ),
          // Positioned(
          //   left: 20,
          //   right: 20,
          //   bottom: 40, // ปรับตำแหน่งลอยขึ้น
          //   child: Stack(
          //     children: [
          //       ClipRect(
          //         child: BackdropFilter(
          //           filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          //           child: Container(
          //             padding: const EdgeInsets.symmetric(horizontal: 16),
          //             height: _bottomsize,
          //             decoration: BoxDecoration(
          //               color: _isBottomNavSolid
          //                   ? AppColors.white
          //                   : AppColors.white.withOpacity(0.7),
          //               borderRadius: BorderRadius.circular(16),
          //             ),
          //             child: Row(
          //               mainAxisAlignment: MainAxisAlignment.spaceAround,
          //               children: [
          //                 IconButton(
          //                     icon: SvgPicture.asset(
          //                       SvgAssets.navigatorHome,
          //                       color: _currentPage == 0
          //                           ? AppColors.black
          //                           : AppColors.darkGrey,
          //                     ),
          //                     onPressed: () {
          //                       if (_currentPage != 0) {
          //                         _pageController!.jumpToPage(0);
          //                         setState(() => _currentPage = 0);
          //                       }
          //                       _pageChange();
          //                     }),
          //                 IconButton(
          //                   icon: SvgPicture.asset(
          //                     SvgAssets.navigatorRoutine,
          //                     color: AppColors.darkGrey,
          //                   ),
          //                   onPressed: () {
          //                     AppNavigator.push(context, RoutinePage());
          //                   },
          //                 ),
          //                 SizedBox.shrink(),
          //                 // FloatingActionButton(
          //                 //   elevation: 0,
          //                 //   onPressed: () {},
          //                 //   backgroundColor: Colors.black,
          //                 //   child: SvgPicture.asset(
          //                 //     SvgAssets.navigatorScan,
          //                 //   ),
          //                 // ),
          //                 IconButton(
          //                     icon: SvgPicture.asset(
          //                       SvgAssets.navigatorFav,
          //                       color: _currentPage == 1
          //                           ? AppColors.black
          //                           : AppColors.darkGrey,
          //                     ),
          //                     onPressed: () {
          //                       _pageController!.jumpToPage(1);
          //                       setState(() {
          //                         _currentPage = 1;
          //                       });
          //                       _pageChange();
          //                     }),
          //                 IconButton(
          //                   icon: SvgPicture.asset(
          //                     SvgAssets.navigatorProfile,
          //                     color: _currentPage == 2
          //                         ? AppColors.black
          //                         : AppColors.darkGrey,
          //                   ),
          //                   onPressed: () {
          //                     _pageController!.jumpToPage(2);
          //                     setState(() {
          //                       _currentPage = 2;
          //                     });
          //                     _pageChange();
          //                   },
          //                 ),
          //               ],
          //             ),
          //           ),
          //         ),
          //       ),
          //       Positioned(
          //         left: MediaQuery.of(context).size.width / 2 - 45,
          //         bottom: 30,
          //         child: FloatingActionButton(
          //           elevation: 0,
          //           onPressed: () {},
          //           backgroundColor: Colors.black,
          //           child: SvgPicture.asset(
          //             SvgAssets.navigatorScan,
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
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
