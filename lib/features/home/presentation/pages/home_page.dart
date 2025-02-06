import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:project/core/common/helper/navigation/app_navigation.dart';
import 'package:project/core/config/assets/svg_assets.dart';
import 'package:project/core/config/theme/app_color.dart';
import 'package:project/core/config/theme/app_theme.dart';
import 'package:project/features/favorite/presentation/pages/favorite_page.dart';
import 'package:project/features/home/presentation/widgets/category_section.dart';
import 'package:project/features/home/presentation/widgets/suggestion_section.dart';
import 'package:project/features/profile/presentation/pages/profile_page.dart';
import 'package:project/features/routine/presentation/pages/routine_page.dart';

// bottomNavigationBar: Stack(
//   clipBehavior: Clip.none,
//   children: [
//     BottomNavigationBar(
//       backgroundColor: Colors.white,
//       type: BottomNavigationBarType.fixed,
//       showSelectedLabels: false,
//       showUnselectedLabels: false,
//       currentIndex: _currentPage,
//       onTap: _onItemTapped,
//       items: [
//         BottomNavigationBarItem(
//           icon: Padding(
//             padding: const EdgeInsets.all(0),
//             child: SvgPicture.asset(
//               "assets/bottomNavigation/home.svg",
//               color: _currentPage == 0 ? Colors.black : Color(0xff7E7E7E),
//             ),
//           ),
//           label: "home",
//         ),
//         BottomNavigationBarItem(
//           icon: Padding(
//             padding: const EdgeInsets.all(0),
//             child: SvgPicture.asset(
//               "assets/bottomNavigation/routine.svg",
//               color: _currentPage == 1 ? Colors.black : Color(0xff7E7E7E),
//             ),
//           ),
//           label: "home",
//         ),
//         BottomNavigationBarItem(
//           icon: SizedBox.shrink(), // Empty space for scan button
//           label: '',
//         ),
//         BottomNavigationBarItem(
//           icon: Padding(
//             padding: const EdgeInsets.all(0),
//             child: SvgPicture.asset(
//               "assets/bottomNavigation/favorite.svg",
//               color: _currentPage == 3 ? Colors.black : Color(0xff7E7E7E),
//             ),
//           ),
//           label: "home",
//         ),
//         BottomNavigationBarItem(
//           icon: Padding(
//             padding: const EdgeInsets.all(0),
//             child: SvgPicture.asset(
//               "assets/bottomNavigation/profile.svg",
//               color: _currentPage == 4 ? Colors.black : Color(0xff7E7E7E),
//             ),
//           ),
//           label: "home",
//         ),
//       ],
//     ),
//     Positioned(
//       top:
//           -20, // Adjusts how much the button floats above the BottomNavigationBar
//       left: MediaQuery.of(context).size.width / 2 -
//           35, // Centers the button
//       child: Container(
//         width: 70, // Width of the button
//         height: 70, // Height of the button
//         decoration: BoxDecoration(
//           shape: BoxShape.circle, // Ensure it is circular
//         ),
//         child: Container(
//           padding: EdgeInsets.all(16),
//           decoration:
//               BoxDecoration(color: Colors.black, shape: BoxShape.circle),
//           child: SvgPicture.asset(
//             "assets/bottomNavigation/scan.svg",
//             width: 30,
//             height: 30,
//           ),
//         ),
//       ),
//     ),
//   ],
// ),
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController _checkScrollController = ScrollController();
  bool _isBottomNavSolid = false;
  bool _blocBottomNavSolid = false;
  PageController? _pageController;
  int _currentPage = 0;
  double _bottomsize = 62;

  @override
  void dispose() {
    _checkScrollController.dispose();
    super.dispose();
  }

  void _pageChange() {
    if (_currentPage == 0) {
      setState(() {
        _blocBottomNavSolid = _isBottomNavSolid;
        _isBottomNavSolid = false;
      });
    } else {
      setState(() {
        _isBottomNavSolid = _blocBottomNavSolid;
      });
    }
  }

  void _onScroll() {
    if (_checkScrollController.position.pixels >=
        _checkScrollController.position.maxScrollExtent - _bottomsize - 20) {
      if (!_isBottomNavSolid) {
        setState(() {
          _isBottomNavSolid = true;
        });
      }
    } else {
      if (_isBottomNavSolid) {
        setState(() {
          _isBottomNavSolid = false;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _checkScrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            physics: NeverScrollableScrollPhysics(),
            controller: _pageController,
            children: [
              SafeArea(
                bottom: false,
                child: NotificationListener<ScrollNotification>(
                  onNotification: (ScrollNotification scrollInfo) {
                    _onScroll();
                    return false;
                  },
                  child: CustomScrollView(
                    controller: _checkScrollController,
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
                              child: TextField(
                                onTap: () {},
                                readOnly: true,
                                decoration: InputDecoration(
                                    prefixIcon: const Icon(Icons.search),
                                    hintText:
                                        'ค้นหาชื่อผลิตภัณฑ์, ยี่ห้อ, ส่วนประกอบ',
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    fillColor: Colors.white,
                                    filled: true,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(1000),
                                      borderSide: const BorderSide(
                                          color: Color(0xffE1D7CE)),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(1000),
                                      borderSide: const BorderSide(
                                          color: Color(0xffE1D7CE)),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(1000),
                                      borderSide: const BorderSide(
                                          color: Color(0xffE1D7CE), width: 2),
                                    )),
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
                          height: _bottomsize + 30,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              FavoritePage(),
              ProfilePage(),
            ],
          ),
          Positioned(
            left: 20,
            right: 20,
            bottom: 20, // ปรับตำแหน่งลอยขึ้น
            child: AnimatedContainer(
              margin: EdgeInsets.only(bottom: _isBottomNavSolid ? 0 : 20),
              duration: const Duration(milliseconds: 300),
              child: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    height: _bottomsize,
                    decoration: BoxDecoration(
                      color: _isBottomNavSolid
                          ? AppColors.white
                          : AppColors.white.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                            icon: SvgPicture.asset(
                              SvgAssets.navigatorHome,
                              color: _currentPage == 0
                                  ? AppColors.black
                                  : AppColors.darkGrey,
                            ),
                            onPressed: () {
                              if (_currentPage != 0) {
                                _pageController!.jumpToPage(0);
                                setState(() => _currentPage = 0);
                              }
                              _pageChange();
                            }),
                        IconButton(
                          icon: SvgPicture.asset(
                            SvgAssets.navigatorRoutine,
                            color: AppColors.darkGrey,
                          ),
                          onPressed: () {
                            AppNavigator.push(context, RoutinePage());
                          },
                        ),
                        FloatingActionButton(
                          elevation: 0,
                          onPressed: () {},
                          backgroundColor: Colors.black,
                          child: SvgPicture.asset(
                            SvgAssets.navigatorScan,
                          ),
                        ),
                        IconButton(
                            icon: SvgPicture.asset(
                              SvgAssets.navigatorFav,
                              color: _currentPage == 1
                                  ? AppColors.black
                                  : AppColors.darkGrey,
                            ),
                            onPressed: () {
                              _pageController!.jumpToPage(1);
                              setState(() {
                                _currentPage = 1;
                              });
                              _pageChange();
                            }),
                        IconButton(
                          icon: SvgPicture.asset(
                            SvgAssets.navigatorProfile,
                            color: _currentPage == 2
                                ? AppColors.black
                                : AppColors.darkGrey,
                          ),
                          onPressed: () {
                            _pageController!.jumpToPage(2);
                            setState(() {
                              _currentPage = 2;
                            });
                            _pageChange();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
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
