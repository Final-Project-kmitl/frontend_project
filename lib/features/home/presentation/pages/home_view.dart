import 'package:flutter/material.dart';
import 'package:project/core/config/theme/app_theme.dart';
import 'package:project/features/home/presentation/widgets/category_section.dart';
import 'package:project/features/home/presentation/widgets/suggestion_section.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  ScrollController _checkScrollController = ScrollController();
  bool _isBottomNavSolid = false;
  int _currentPage = 0;
  double _bottomsize = 62;

  @override
  void dispose() {
    _checkScrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_checkScrollController.position.pixels >=
        _checkScrollController.position.maxScrollExtent - 100) {
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
    _checkScrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                    child: TextField(
                      onTap: () {},
                      readOnly: true,
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.search),
                          hintText: 'ค้นหาชื่อผลิตภัณฑ์, ยี่ห้อ, ส่วนประกอบ',
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 20),
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(1000),
                            borderSide:
                                const BorderSide(color: Color(0xffE1D7CE)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(1000),
                            borderSide:
                                const BorderSide(color: Color(0xffE1D7CE)),
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
