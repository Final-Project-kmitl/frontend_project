import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:project/core/common/helper/navigation/app_navigation.dart';
import 'package:project/core/config/assets/svg_assets.dart';
import 'package:project/core/config/theme/app_color.dart';
import 'package:project/core/config/theme/app_theme.dart';
import 'package:project/features/camera/presentation/pages/camera_direction.dart';
import 'package:project/features/favorite/presentation/bloc/favorite_bloc.dart';
import 'package:project/features/favorite/presentation/pages/favorite_page.dart';
import 'package:project/features/home/domain/entities/product_entity.dart';
import 'package:project/features/home/presentation/bloc/home_bloc.dart';
import 'package:project/features/home/presentation/widgets/category_section.dart';
import 'package:project/features/home/presentation/widgets/search_box.dart';
import 'package:project/features/home/presentation/widgets/suggestion_loading.dart';
import 'package:project/features/home/presentation/widgets/suggestion_section.dart';
import 'package:project/features/profile/presentation/pages/profile_page.dart';
import 'package:project/features/routine/presentation/pages/routine_page.dart';
import 'package:project/features/search/presentation/pages/search_page.dart';
import 'package:project/service_locator.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController? _pageController;
  int _currentPage = 0;
  double _bottomsize = 62;

  @override
  void initState() {
    super.initState();
    // sl<HomeBloc>().add(HomeDataRequestedEvent());
    _pageController = PageController(initialPage: 0);
    context.read<HomeBloc>().add(LoadRecommendedEvent());
    context.read<HomeBloc>().add(LoadPopularEvent());
    context.read<HomeBloc>().add(LoadRecentEvent());
    context.read<HomeBloc>().add(LoadFavoriteEvent());
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
                        if (context.read<FavoriteBloc>().state
                            is FavoriteLoaded) {
                          sl<FavoriteBloc>().add(SubmitUnfavoriteEvent());
                        } else {
                          print(
                              "❌ ไม่สามารถ unfavorite ได้ เพราะ state ยังไม่พร้อม");
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
              child: GestureDetector(
                onTap: () {
                  AppNavigator.push(context, CameraDirection());
                },
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
                ),
              ))
        ],
      ),
      body: Stack(
        children: [
          PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _pageController,
            onPageChanged: (index) {
              if (_currentPage == 1 && index != 1) {
                final bloc = sl<FavoriteBloc>();
                if (bloc.state is FavoriteLoaded) {
                  print("ออกจาก Favorite Page → ส่งรายการ unfav");
                  bloc.add(SubmitUnfavoriteEvent());
                } else {
                  print("State ยังไม่พร้อม ไม่ส่ง event");
                }
              } else if (_currentPage != 1 && index == 1) {
                sl<FavoriteBloc>().add(LoadFavoritesEvent());
              }

              _currentPage = index;
            },
            children: [
              SafeArea(
                bottom: false,
                child: RefreshIndicator(
                  onRefresh: () async {
                    context.read<HomeBloc>().add(LoadRecommendedEvent());
                    context.read<HomeBloc>().add(LoadPopularEvent());
                    context.read<HomeBloc>().add(LoadRecentEvent());
                    context.read<HomeBloc>().add(LoadFavoriteEvent());
                  },
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
                      SliverToBoxAdapter(
                        child: CategorySection(),
                      ),
                      BlocBuilder<HomeBloc, HomeState>(
                        builder: (context, state) {
                          if (state is HomeLoaded) {
                            // ✅ เช็คว่าข้อมูลทั้งหมดโหลดเสร็จแล้ว
                            if (state.isRecommendedLoaded) {
                              print("REC TRUE");
                              return SliverToBoxAdapter(
                                child: _buildSection(
                                    title: "แนะนำสำหรับคุณ",
                                    isLoad: state.isRecommendedLoaded,
                                    data: state.recommended,
                                    fav: state.favorite),
                              );
                            }
                            print("REC FALSE");
                            // if (state.isRecommendedLoaded &&
                            //     state.isPopularLoaded &&
                            //     state.isRecentLoaded) {
                            //   return SliverList(
                            //     delegate: SliverChildListDelegate([
                            //       _buildSection(
                            //           title: "แนะนำสำหรับคุณ",
                            //           isLoad: state.isRecommendedLoaded,
                            //           data: state.recommended,
                            //           fav: state.favorite),
                            //       _buildSection(
                            //           title: "สินค้ายอดนิยม",
                            //           isLoad: state.isPopularLoaded,
                            //           data: state.popular,
                            //           fav: state.favorite),
                            //       _buildSection(
                            //           title: "สินค้าที่ดูล่าสุด",
                            //           isLoad: state.isRecentLoaded,
                            //           data: state.recent,
                            //           fav: state.favorite),
                            //     ]),
                            //   );
                            // }
                          }
                          // ✅ ถ้ายังโหลดไม่เสร็จให้แสดง Loading
                          return SliverToBoxAdapter(
                            child: Center(child: CircularProgressIndicator()),
                          );
                        },
                      ),
                      SliverToBoxAdapter(
                        child: SizedBox(
                          height: _bottomsize + 82,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const FavoritePage(),
              const ProfilePage(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required bool isLoad,
    required List<ProductEntity> data,
    required List<int> fav,
  }) {
    if (!isLoad) {
      return SuggestionLoading(title: title); // ✅ คืน Widget ปกติ
    }
    if (data.isEmpty) {
      return Text("$title: ไม่มีข้อมูล"); // ✅ คืน Widget ปกติ
    }
    return SuggestionSection(title: title, product: data, favProduct: fav);
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
