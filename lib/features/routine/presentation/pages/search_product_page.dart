import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/core/common/helper/navigation/app_navigation.dart';
import 'package:project/core/common/widgets/center_loading.dart';
import 'package:project/core/config/theme/app_color.dart';
import 'package:project/core/config/theme/app_theme.dart';
import 'package:project/features/product/presentation/pages/product_page.dart';
import 'package:project/features/routine/presentation/bloc/routine_bloc.dart';
import 'package:project/features/search/presentation/widgets/custom_text_form_field.dart';
import 'package:shimmer/shimmer.dart';

class SearchProductPage extends StatefulWidget {
  const SearchProductPage({super.key});

  @override
  State<SearchProductPage> createState() => _SearchProductPageState();
}

class _SearchProductPageState extends State<SearchProductPage> {
  TextEditingController _textEditingController = TextEditingController();
  FocusNode _focusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();
  bool _isLoadingMore = false;
  int _currentPage = 1;
  String _query = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent &&
          !_isLoadingMore) {
        print("📌 Scrolled to bottom, calling _loadMoreData");
        _loadMoreData();
      }
    });
  }

  void _loadMoreData() {
    print("load more");
    if (_isLoadingMore) return;

    setState(() {
      _isLoadingMore = true;
    });

    _currentPage++;

    context
        .read<RoutineBloc>()
        .add(OnRoutineQueryLoadMoreEvent(query: _query, page: _currentPage));

    Future.delayed(Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _isLoadingMore = false;
        });
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: AppColors.white,
        backgroundColor: AppColors.white,
        leading: GestureDetector(
          onTap: () {
            context.read<RoutineBloc>().add(LoadRoutineEvent());
            Navigator.pop(context);
          },
          child: Icon(
            Icons.chevron_left,
            size: 24,
          ),
        ),
        title: CustomTextFormField(
            onChange: (p0) {
              setState(() {
                _query = p0;
                _currentPage = 1;
              });
              context.read<RoutineBloc>().add(OnRoutineQueryEvent(p0));
            },
            controller: _textEditingController,
            hintText: "ค้นหาชื่อผลิตภัณฑ์, ยี่ห้อ",
            focusNode: _focusNode,
            fn: (value) {},
            ondelete: () {
              _textEditingController.clear();
            }),
        actions: [
          Icon(
            Icons.camera_alt,
            color: AppColors.black,
          ),
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: BlocBuilder<RoutineBloc, RoutineState>(
        builder: (context, state) {
          if (state is RoutineQueryLoading) {
            return CenterLoading();
          }
          if (state is RoutineQueryLoaded) {
            print("🔄 UI Updated: ${state.products.length} products");
            return ListView.builder(
                controller: _scrollController,
                itemCount: state.products.length + (state.isLoadMore ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == state.products.length) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Shimmer.fromColors(
                        baseColor: AppColors.paleBlue,
                        highlightColor: AppColors.white,
                        child: ListTile(
                          trailing: Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: AppColors.paleBlue,
                              shape: BoxShape.circle,
                            ),
                          ),
                          leading: SizedBox(
                            width: 40,
                            height: 40,
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.paleBlue,
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 80,
                                height: 12,
                                decoration: BoxDecoration(
                                  color: AppColors.paleBlue,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              SizedBox(height: 4),
                              Container(
                                width: 120,
                                height: 16,
                                decoration: BoxDecoration(
                                  color: AppColors.paleBlue,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: GestureDetector(
                      onTap: () {
                        print(state.products[index].id);
                      },
                      child: ListTile(
                        onTap: () {
                          AppNavigator.push(context,
                              ProductPage(productId: state.products[index].id));
                        },
                        trailing: state.products[index].isRoutine!
                            ? IntrinsicWidth(
                                child: Container(
                                  child: Text(
                                    "เพิ่มลงรูทีนแล้ว",
                                    style: TextThemes.descBold
                                        .copyWith(color: AppColors.darkGrey),
                                  ),
                                ),
                              )
                            : GestureDetector(
                                onTap: () {
                                  if (state.count < 10) {
                                    context.read<RoutineBloc>().add(
                                        AddRoutineEvent(
                                            productId:
                                                state.products[index].id));
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: AppColors.black,
                                        content: Container(
                                          padding: EdgeInsets.all(8),
                                          child: Text(
                                            "ไม่สามารถเพิ่มสินค้าได้เกิน 10 ตัว",
                                            style: TextThemes.bodyBold.copyWith(
                                                color: AppColors.white),
                                          ),
                                        ),
                                        behavior: SnackBarBehavior.floating,
                                      ),
                                    );
                                  }
                                },
                                child: Icon(Icons.add_circle_rounded),
                              ),
                        leading: SizedBox(
                          width: 40,
                          height: 40,
                          child: Image.network(
                            state.products[index].img,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset("assets/test_img.png");
                            },
                          ),
                        ),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.products[index].brand,
                              style: TextThemes.desc
                                  .copyWith(color: AppColors.darkGrey),
                            ),
                            Text(
                              state.products[index].product,
                              style: TextThemes.bodyBold,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                });
          }
          return Container();
        },
      ),
    );
  }
}
