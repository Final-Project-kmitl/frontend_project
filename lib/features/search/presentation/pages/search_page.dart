import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/core/common/helper/navigation/app_navigation.dart';
import 'package:project/core/common/widgets/center_loading.dart';
import 'package:project/core/common/widgets/reload_button.dart';
import 'package:project/core/config/theme/app_color.dart';
import 'package:project/core/config/theme/app_theme.dart';
import 'package:project/core/constants/share_pref.dart';
import 'package:project/features/product/presentation/pages/product_page.dart';
import 'package:project/features/search/presentation/bloc/search_bloc.dart';
import 'package:project/features/search/presentation/widgets/custom_text_form_field.dart';
import 'package:project/service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

void printSubmit(String value) {
  print(value);
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _textEditingController = TextEditingController();
  FocusNode _focusNode = FocusNode();
  TextEditingController _minPrice = TextEditingController();
  TextEditingController _maxPrice = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isLoadMore = false;
  int _currentPage = 1;
  bool isOpen = false;
  late List<int> skinType = [];
  late List<int> productType = [];
  Set<String> brands = {};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
      context
          .read<SearchBloc>()
          .add(OnEmptyEvent()); // ✅ ใช้ OnEmptyEvent() แทน
    });
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent &&
          !_isLoadMore) {
        print("📌 Scrolled to bottom, calling _loadMoreData");
        _loadMoreData();
      }
    });
  }

  void _loadMoreData() {
    if (_isLoadMore) return;

    setState(() {
      _isLoadMore = true;
    });

    _currentPage++;

    int? minPrice =
        _minPrice.text.isNotEmpty ? int.tryParse(_minPrice.text) : null;
    int? maxPrice =
        _maxPrice.text.isNotEmpty ? int.tryParse(_maxPrice.text) : null;

    context.read<SearchBloc>().add(OnLoadMoreEvent(
        query: _textEditingController.value.text,
        page: _currentPage,
        minPrice: minPrice,
        maxPrice: maxPrice,
        skinTypeIds: skinType,
        productTypeIds: productType,
        brands: brands.toList()));

    Future.delayed(Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _isLoadMore = false;
        });
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose

    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: isOpen
          ? Container(
              decoration: BoxDecoration(color: AppColors.white, boxShadow: [
                BoxShadow(
                    blurRadius: 10,
                    color: AppColors.black.withOpacity(0.1),
                    offset: Offset(0, -4))
              ]),
              padding:
                  EdgeInsets.only(left: 20, right: 20, top: 16, bottom: 45),
              child: SizedBox(
                height: 50,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                        child: ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        "ล้าง",
                        style: TextThemes.bodyBold,
                      ),
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: AppColors.white,
                          side: BorderSide(color: AppColors.black, width: 1),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16))),
                    )),
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(
                        child: ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        "เสร็จสิ้น",
                        style: TextThemes.bodyBold
                            .copyWith(color: AppColors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: AppColors.black,
                          side: BorderSide(color: AppColors.black, width: 1),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16))),
                    )),
                  ],
                ),
              ))
          : null,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 0),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _textEditingController.clear();
                    },
                    icon: Icon(
                      Icons.arrow_back_ios_new_outlined,
                      color: AppColors.black,
                    ),
                  ),
                  Expanded(
                    child: CustomTextFormField(
                      onChange: (value) {
                        context
                            .read<SearchBloc>()
                            .add(OnSearchQueryChanged(params: value));
                      },
                      controller: _textEditingController,
                      hintText: "ค้นหาชื่อผลิตภัณฑ์, ยี่ห้อ",
                      fn: (value) {
                        // ใช้ _onSearchSubmit แทน _onSubmit
                        context.read<SearchBloc>().add(OnSearchQueryChanged(
                            params: _textEditingController.text));
                        context.read<SearchBloc>().add(OnSubmitEvent(
                              query: _textEditingController.text,
                              minPrice: _minPrice.text.isNotEmpty
                                  ? int.tryParse(_minPrice.text)
                                  : null,
                              maxPrice: _maxPrice.text.isNotEmpty
                                  ? int.tryParse(_maxPrice.text)
                                  : null,
                              skinProblemIds: skinType,
                              benefitIds: [],
                              productTypeIds: productType,
                              brands: brands.toList(),
                            ));
                      },
                      ondelete: () {
                        context.read<SearchBloc>().add(OnEmptyEvent());
                      },
                      focusNode: _focusNode,
                    ),
                  ),
                  BlocBuilder<SearchBloc, SearchState>(
                    builder: (context, state) {
                      if (state is SubmitLoaded) {
                        return IconButton(
                            icon: Icon(
                              Icons.tune_outlined,
                              color: AppColors.black,
                            ),
                            onPressed: () {
                              showModalBottomSheet(
                                backgroundColor:
                                    Colors.transparent, // ทำให้พื้นหลังโปร่งใส
                                context: context,
                                isScrollControlled:
                                    true, // ให้สามารถเลื่อนแบบเต็มจอได้
                                builder: (context) {
                                  return StatefulBuilder(
                                      builder: (context, setState) {
                                    return DraggableScrollableSheet(
                                      initialChildSize:
                                          0.5, // เริ่มต้นที่ 50% ของหน้าจอ
                                      minChildSize: 0.3, // ต่ำสุดที่ 30%
                                      maxChildSize: 0.8, // สูงสุดไม่เกิน 80%
                                      expand: false, // ไม่บังคับให้เต็มจอ
                                      builder: (context, scrollController) {
                                        return Container(
                                          decoration: BoxDecoration(
                                            color: AppColors.white,
                                            borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(20),
                                            ),
                                          ),
                                          child: Stack(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 20,
                                                    vertical: 36),
                                                child: SingleChildScrollView(
                                                  controller:
                                                      scrollController, // ให้เลื่อนข้อมูลได้
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "ช่วงราคา",
                                                        style:
                                                            TextThemes.bodyBold,
                                                      ),
                                                      SizedBox(height: 12),
                                                      SizedBox(
                                                        height: 40,
                                                        child: Row(
                                                          children: [
                                                            Expanded(
                                                              child: TextField(
                                                                controller:
                                                                    _minPrice,
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                decoration:
                                                                    InputDecoration(
                                                                        hintText:
                                                                            "ใส่ราคาต่ำสุด"),
                                                              ),
                                                            ),
                                                            SizedBox(width: 10),
                                                            Text("-",
                                                                style: TextThemes
                                                                    .bodyBold),
                                                            SizedBox(width: 10),
                                                            Expanded(
                                                              child: TextField(
                                                                controller:
                                                                    _maxPrice,
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                decoration:
                                                                    InputDecoration(
                                                                        hintText:
                                                                            "ใส่ราคาสูงสุด"),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(height: 16),
                                                      Text("สภาพผิว",
                                                          style: TextThemes
                                                              .bodyBold),
                                                      Wrap(
                                                        spacing: 16,
                                                        children:
                                                            state
                                                                .submitReturn
                                                                .countFilter
                                                                .skinTypes
                                                                .map((e) =>
                                                                    ChoiceChip(
                                                                      key: ValueKey(
                                                                          e.id),
                                                                      side: BorderSide(
                                                                          color: skinType.contains(e.id)
                                                                              ? AppColors.black
                                                                              : AppColors.grey),
                                                                      showCheckmark:
                                                                          false,
                                                                      selectedColor:
                                                                          AppColors
                                                                              .white,
                                                                      selected:
                                                                          skinType
                                                                              .contains(e.id),
                                                                      onSelected:
                                                                          (value) {
                                                                        setState(
                                                                            () {
                                                                          if (skinType
                                                                              .contains(e.id)) {
                                                                            skinType.removeWhere((item) =>
                                                                                item ==
                                                                                e.id);
                                                                          } else {
                                                                            skinType.add(e.id);
                                                                          }
                                                                        });
                                                                      },
                                                                      label:
                                                                          Text(
                                                                        "${e.name} (${e.count})",
                                                                        style: TextThemes
                                                                            .body,
                                                                      ),
                                                                      backgroundColor:
                                                                          AppColors
                                                                              .white,
                                                                      shape: RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(12)),
                                                                    ))
                                                                .toList(),
                                                      ),
                                                      SizedBox(height: 16),
                                                      Text("ประเภทผลิตภัณฑ์",
                                                          style: TextThemes
                                                              .bodyBold),
                                                      Wrap(
                                                        spacing: 16,
                                                        children:
                                                            state
                                                                .submitReturn
                                                                .countFilter
                                                                .productTypes
                                                                .map((e) =>
                                                                    ChoiceChip(
                                                                      key: ValueKey(
                                                                          e.id),
                                                                      side: BorderSide(
                                                                          color: productType.contains(e.id)
                                                                              ? AppColors.black
                                                                              : AppColors.grey),
                                                                      showCheckmark:
                                                                          false,
                                                                      selectedColor:
                                                                          AppColors
                                                                              .white,
                                                                      selected:
                                                                          productType
                                                                              .contains(e.id),
                                                                      onSelected:
                                                                          (value) {
                                                                        setState(
                                                                            () {
                                                                          if (productType
                                                                              .contains(e.id)) {
                                                                            productType.removeWhere((item) =>
                                                                                item ==
                                                                                e.id);
                                                                          } else {
                                                                            productType.add(e.id);
                                                                          }
                                                                        });
                                                                      },
                                                                      label:
                                                                          Text(
                                                                        "${e.name} (${e.count})",
                                                                        style: TextThemes
                                                                            .body,
                                                                      ),
                                                                      backgroundColor:
                                                                          AppColors
                                                                              .white,
                                                                      shape: RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(12)),
                                                                    ))
                                                                .toList(),
                                                      ),
                                                      SizedBox(height: 16),
                                                      Text("แบรนด์",
                                                          style: TextThemes
                                                              .bodyBold),
                                                      Wrap(
                                                        spacing: 16,
                                                        children: state
                                                            .submitReturn
                                                            .countFilter
                                                            .brands
                                                            .map((e) => e
                                                                        .count >
                                                                    10
                                                                ? ChoiceChip(
                                                                    key: ValueKey(
                                                                        e.name),
                                                                    side: BorderSide(
                                                                        color: brands.contains(e.name)
                                                                            ? AppColors.black
                                                                            : AppColors.grey),
                                                                    showCheckmark:
                                                                        false,
                                                                    selectedColor:
                                                                        AppColors
                                                                            .white,
                                                                    selected: brands
                                                                        .contains(
                                                                            e.name),
                                                                    onSelected:
                                                                        (value) {
                                                                      setState(
                                                                          () {
                                                                        if (brands
                                                                            .contains(e.name)) {
                                                                          brands.removeWhere((item) =>
                                                                              item ==
                                                                              e.name);
                                                                        } else {
                                                                          brands
                                                                              .add(e.name);
                                                                        }
                                                                      });
                                                                    },
                                                                    label: Text(
                                                                      "${e.name} (${e.count})",
                                                                      style: TextThemes
                                                                          .body,
                                                                    ),
                                                                    backgroundColor:
                                                                        AppColors
                                                                            .white,
                                                                    shape: RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(12)),
                                                                  )
                                                                : Container())
                                                            .toList(),
                                                      ),
                                                      SizedBox(
                                                          height:
                                                              80), // เว้นที่สำหรับปุ่ม
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                  bottom: 0,
                                                  left: 0,
                                                  right: 0,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      boxShadow: [
                                                        BoxShadow(
                                                            color: AppColors
                                                                .black
                                                                .withOpacity(
                                                                    0.1),
                                                            blurRadius: 10,
                                                            offset:
                                                                Offset(0, -4))
                                                      ],
                                                      color: AppColors.white,
                                                    ),
                                                    padding: EdgeInsets.only(
                                                        bottom: 52, top: 16),
                                                    child: Container(
                                                      width: double.infinity,
                                                      height: 52,
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 20),
                                                      decoration: BoxDecoration(
                                                          color:
                                                              AppColors.white),
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                              child:
                                                                  GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                skinType
                                                                    .clear();
                                                                productType
                                                                    .clear();
                                                                brands.clear();
                                                                _minPrice
                                                                    .clear();
                                                                _maxPrice
                                                                    .clear();
                                                              });
                                                            },
                                                            child: Container(
                                                              decoration: BoxDecoration(
                                                                  border: Border.all(
                                                                      color: AppColors
                                                                          .black),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              16)),
                                                              child: Center(
                                                                child: Text(
                                                                  "ล้าง",
                                                                  style: TextThemes
                                                                      .bodyBold,
                                                                ),
                                                              ),
                                                            ),
                                                          )),
                                                          SizedBox(
                                                            width: 16,
                                                          ),
                                                          Expanded(
                                                              child:
                                                                  GestureDetector(
                                                            onTap: () {
                                                              context.read<SearchBloc>().add(SearchLoadBybenefitEvent(
                                                                  query:
                                                                      _textEditingController
                                                                          .text,
                                                                  page: 1,
                                                                  skinTypeIds:
                                                                      skinType,
                                                                  productTypeIds:
                                                                      productType,
                                                                  brands: brands
                                                                      .toList()));
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: Container(
                                                              decoration: BoxDecoration(
                                                                  color:
                                                                      AppColors
                                                                          .black,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              12)),
                                                              child: Center(
                                                                child: Text(
                                                                  "เสร็จสิ้น",
                                                                  style: TextThemes
                                                                      .bodyBold
                                                                      .copyWith(
                                                                          color:
                                                                              AppColors.white),
                                                                ),
                                                              ),
                                                            ),
                                                          )),
                                                        ],
                                                      ),
                                                    ),
                                                  )),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  });
                                },
                              );
                            });
                      }
                      return SizedBox(
                        width: 20,
                      );
                    },
                  )
                ],
              ),
            ),
            Expanded(
              child: BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  if (state is SearchLoading) {
                    return CenterLoading();
                  } else if (state is SearchError) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              state.message,
                              style: TextThemes.bodyBold,
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            ReloadButton(fn: () {
                              context.read<SearchBloc>().add(OnSubmitEvent(
                                  query: _textEditingController.text));
                            }),
                          ],
                        ),
                      ),
                    );
                  } else if (state is SearchOnEmpty) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 24,
                          ),
                          Text(
                            "การค้นหายอดนิยม",
                            style: TextThemes.descBold,
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Wrap(
                              spacing: 12,
                              children: sl<SharedPreferences>()
                                      .getStringList(shared_pref.topSearch)!
                                      .map((e) => GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                _textEditingController.text = e;
                                              });

                                              context.read<SearchBloc>().add(
                                                  OnSubmitEvent(
                                                      query:
                                                          _textEditingController
                                                              .text));
                                            },
                                            child: Chip(
                                              backgroundColor: AppColors.purple,
                                              label: Text(
                                                e,
                                                style: TextThemes.desc,
                                              ),
                                              side: BorderSide.none,
                                              shape: StadiumBorder(),
                                            ),
                                          ))
                                      .toList() ??
                                  [],
                            ),
                          )
                        ],
                      ),
                    );
                  } else if (state is SubmitLoaded) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: GridView.builder(
                        controller: _scrollController,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 168.5 / 262,
                        ),
                        itemCount: state.submitReturn.products.length,
                        itemBuilder: (context, index) {
                          print(state.submitReturn.products.length);
                          return GestureDetector(
                            onTap: () {
                              AppNavigator.push(
                                  context,
                                  ProductPage(
                                      productId: state
                                          .submitReturn.products[index].id));
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
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: AppColors.white),
                                      height: 144,
                                      width: double.infinity,
                                      child: Stack(
                                        children: [
                                          Center(
                                            child: Padding(
                                              padding: const EdgeInsets.all(12),
                                              child: Image.network(
                                                state
                                                        .submitReturn
                                                        .products[index]
                                                        .imageUrl ??
                                                    "",
                                                fit: BoxFit.contain,
                                                errorBuilder: (context, error,
                                                    stackTrace) {
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
                                            state.submitReturn.products[index]
                                                .name,
                                            style: TextThemes.bodyBold,
                                            maxLines: 2,
                                          ),
                                          Spacer(),
                                          Text(
                                            state.submitReturn.products[index]
                                                .brand,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextThemes.desc.copyWith(
                                                color: AppColors.darkGrey),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "${(state.submitReturn.products[index].maxPrice != 0) ? state.submitReturn.products[index].minPrice : '-'} บาท",
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
                    );
                  } else if (state is SearchLoaded) {
                    Map<String, List<String>> groupedProducts = {};

                    for (var product in state.products) {
                      String brand = product.brand;
                      String name = product.name;

                      if (!groupedProducts.containsKey(brand)) {
                        groupedProducts[brand] = [
                          brand
                        ]; // ใส่ชื่อ brand เป็นตัวแรกของกลุ่ม
                      }
                      groupedProducts[brand]!.add("${name}");
                    }

                    final List<String> result =
                        groupedProducts.values.expand((list) => list).toList();

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ListView.separated(
                        separatorBuilder: (context, index) {
                          if (index == 0) {
                            return SizedBox();
                          } else {
                            return Divider();
                          }
                        },
                        itemCount: result.length + 1,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return SizedBox(height: 12);
                          }
                          final product = result[index - 1];

                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _textEditingController.text = product;
                              });
                              context.read<SearchBloc>().add(OnSubmitEvent(
                                  query: _textEditingController.text));
                            },
                            child: Container(
                              height: 32,
                              width: double.infinity,
                              child: Row(
                                children: [
                                  Text.rich(
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text: product,
                                          style: TextThemes.desc
                                              .copyWith(color: AppColors.black),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: 200,
                    itemBuilder: (context, index) {
                      return Text("${index}");
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
