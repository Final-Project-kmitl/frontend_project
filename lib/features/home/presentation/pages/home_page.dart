import 'package:flutter/material.dart';
import 'package:project/core/config/theme/app_theme.dart';
import 'package:project/features/home/presentation/widgets/category_section.dart';
import 'package:project/features/home/presentation/widgets/suggestion_section.dart';

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

  @override
  void dispose() {
    _checkScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          controller: _checkScrollController,
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.white,
              title: Text(
                "หน้าหลัก",
                style: TextThemes.headline1,
              ),
              floating: false,
              // pinned: true,
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
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                    child: TextField(
                      onTap: () {},
                      readOnly: true,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search),
                          hintText: 'ค้นหาชื่อผลิตภัณฑ์, ยี่ห้อ, ส่วนประกอบ',
                          contentPadding: EdgeInsets.symmetric(horizontal: 20),
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(1000),
                            borderSide: BorderSide(color: Color(0xffE1D7CE)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(1000),
                            borderSide: BorderSide(color: Color(0xffE1D7CE)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(1000),
                            borderSide:
                                BorderSide(color: Color(0xffE1D7CE), width: 2),
                          )),
                    ),
                  ),
                ),
              ),
              pinned: true,
            ),
            // Add more slivers here for your content
            SliverToBoxAdapter(
              child: CategorySection(),
            ),
            SliverToBoxAdapter(
              child: SuggestionSection(),
            ),
            SliverToBoxAdapter(
              child: SuggestionSection(),
            ),
            SliverToBoxAdapter(
              child: SuggestionSection(),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 130,
              ),
            )
          ],
        ),
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
