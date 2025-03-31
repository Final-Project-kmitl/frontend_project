import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:project/core/common/helper/navigation/app_navigation.dart';
import 'package:project/core/common/widgets/center_loading.dart';
import 'package:project/core/common/widgets/reload_button.dart';
import 'package:project/core/config/theme/app_color.dart';
import 'package:project/core/config/theme/app_theme.dart';
import 'package:project/features/home/domain/entities/product_entity.dart';
import 'package:project/features/home/presentation/bloc/home_bloc.dart';
import 'package:project/features/product/presentation/pages/product_page.dart';
import 'package:shimmer/shimmer.dart';

class ShowBenefit extends StatefulWidget {
  final int benefitId;
  final String benefit;
  const ShowBenefit({
    super.key,
    required this.benefitId,
    required this.benefit,
  });

  @override
  State<ShowBenefit> createState() => _ShowBenefitState();
}

class _ShowBenefitState extends State<ShowBenefit> {
  String selectSort = "ค่าเริ่มต้น";
  List<ProductEntity> originalProducts = [];
  final ScrollController _scrollController = ScrollController();
  bool _isLoadingMore = false;
  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
    context
        .read<HomeBloc>()
        .add(LoadByBenefitEvent(benefitId: widget.benefitId));

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent &&
          !_isLoadingMore) {
        print("📌 Scrolled to bottom, calling _loadMoreData");
        _loadMoreData();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _loadMoreData() {
    print("LOADING");
    if (_isLoadingMore) return;

    setState(() {
      _isLoadingMore = true;
    });

    _currentPage++;

    context.read<HomeBloc>().add(LoadMoreByBenefitEvent(
          benefitId: widget.benefitId,
          page: _currentPage,
        ));

    Future.delayed(Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _isLoadingMore = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        surfaceTintColor: AppColors.white,
        backgroundColor: AppColors.white,
        // actions: [Icon(Icons.tune), SizedBox(width: 20)],
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
              context.read<HomeBloc>().add(RestoreHomeEvent());
            },
            child: Icon(Icons.chevron_left_outlined)),
        title: Text(
          widget.benefit,
          style: TextThemes.headline2,
        ),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.message),
                  SizedBox(height: 16),
                  ReloadButton(fn: () {
                    context
                        .read<HomeBloc>()
                        .add(LoadByBenefitEvent(benefitId: widget.benefitId));
                  })
                ],
              ),
            );
          } else if (state is HomeLoading) {
            return CenterLoading();
          } else if (state is HomeBenefitLoaded) {
            void _applySorting(String sortOption) {
              originalProducts = state.allProducts;

              if (sortOption == "คะแนนความเหมาะสม") {
                state.allProducts.sort((a, b) =>
                    double.parse(b.rating).compareTo(double.parse(a.rating)));
              } else if (sortOption == 'ราคาสูงไปต่ำ') {
                state.allProducts.sort((a, b) => double.parse(b.price.min)
                    .compareTo(double.parse(a.price.min)));
              } else if (sortOption == "ราคาต่ำไปสูง") {
                state.allProducts.sort((a, b) => double.parse(a.price.min)
                    .compareTo(double.parse(b.price.min)));
              }
            }

            Future<void> _showSortOptions(BuildContext context) async {
              String? result = await showModalBottomSheet<String>(
                    backgroundColor: AppColors.white,
                    context: context,
                    builder: (context) {
                      String sortOption = selectSort; // ใช้ค่าเริ่มต้น
                      return StatefulBuilder(builder: (context, setState) {
                        return Wrap(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 36),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("เรียงตาม",
                                      style: TextThemes.bodyBold
                                          .copyWith(fontSize: 18)),
                                  RadioListTile<String>(
                                    title: Text("ค่าเริ่มต้น",
                                        style: TextThemes.body),
                                    value: "ค่าเริ่มต้น",
                                    groupValue: sortOption,
                                    activeColor: AppColors.black,
                                    onChanged: (value) {
                                      setState(() => sortOption = value!);
                                      Navigator.pop(context, value);
                                    },
                                    contentPadding: EdgeInsets.zero,
                                    dense: true,
                                  ),
                                  RadioListTile<String>(
                                    title: Text("คะแนนความเหมาะสม",
                                        style: TextThemes.body),
                                    value: "คะแนนความเหมาะสม",
                                    groupValue: sortOption,
                                    activeColor: AppColors.black,
                                    onChanged: (value) {
                                      setState(() => sortOption = value!);
                                      Navigator.pop(context, value);
                                    },
                                    contentPadding: EdgeInsets.zero,
                                    dense: true,
                                  ),
                                  RadioListTile<String>(
                                    title: Text("ราคาสูงไปต่ำ",
                                        style: TextThemes.body),
                                    value: "ราคาสูงไปต่ำ",
                                    groupValue: sortOption,
                                    activeColor: AppColors.black,
                                    onChanged: (value) {
                                      setState(() => sortOption = value!);
                                      Navigator.pop(context, value);
                                    },
                                    contentPadding: EdgeInsets.zero,
                                    dense: true,
                                  ),
                                  RadioListTile<String>(
                                    title: Text("ราคาต่ำไปสูง",
                                        style: TextThemes.body),
                                    value: "ราคาต่ำไปสูง",
                                    groupValue: sortOption,
                                    activeColor: AppColors.black,
                                    onChanged: (value) {
                                      setState(() => sortOption = value!);
                                      Navigator.pop(context, value);
                                    },
                                    contentPadding: EdgeInsets.zero,
                                    dense: true,
                                  ),
                                ],
                              ),
                            )
                          ],
                        );
                      });
                    },
                  ) ??
                  "ค่าเริ่มต้น";

              setState(() {
                selectSort = result;
              });
              _applySorting(selectSort);
            }

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 16, bottom: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "แสดงผลลัพธ์ ${state.allProducts.length} รายการ",
                          style: TextThemes.desc,
                        ),
                        GestureDetector(
                          onTap: () => _showSortOptions(context),
                          child: Row(
                            children: [
                              SvgPicture.asset("assets/arrow-up-down.svg"),
                              Text(
                                "เรียงตาม${selectSort}",
                                style: TextThemes.desc,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  // Wrap GridView inside an Expanded widget
                  Expanded(
                    child: GridView.builder(
                      controller: _scrollController,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 168.5 / 262,
                      ),
                      itemCount: state.allProducts.length +
                          (state.isLoadingMore ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index == state.allProducts.length) {
                          return Shimmer.fromColors(
                            baseColor: AppColors.paleBlue,
                            highlightColor: AppColors.white,
                            child: Container(
                              width: 140,
                              margin: EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                color: Color(0xffE9F2FB),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment
                                      .start, // Align children to the left
                                  children: [
                                    Container(
                                        width: double.infinity,
                                        height: 100,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Container()),
                                    const SizedBox(height: 6),
                                    const Spacer(),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }
                        return GestureDetector(
                          onTap: () {
                            AppNavigator.push(
                                context,
                                ProductPage(
                                    productId: state.allProducts[index].id));
                          },
                          child: Container(
                            width: 140,
                            margin: EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                              color: Color(0xffE9F2FB),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(12),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: AppColors.white),
                                    height: 144,
                                    width: double.infinity,
                                    child: Stack(
                                      children: [
                                        Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(12),
                                            child: Image.network(
                                              state.allProducts[index]
                                                      .imageUrl ??
                                                  "",
                                              fit: BoxFit.contain,
                                              errorBuilder:
                                                  (context, error, stackTrace) {
                                                return Image.asset(
                                                    "assets/test_img.png");
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          state.allProducts[index].name,
                                          style: TextThemes.bodyBold,
                                          maxLines: 2,
                                        ),
                                        Spacer(),
                                        Text(
                                          state.allProducts[index].brand,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextThemes.desc.copyWith(
                                              color: AppColors.darkGrey),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "${(state.allProducts[index].price.min != '0') ? state.allProducts[index].price.min : '-'} บาท",
                                              style: TextThemes.bodyBold,
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 14,
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }

          return CenterLoading();
        },
      ),
    );
  }
}
