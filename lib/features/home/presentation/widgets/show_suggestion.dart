import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/core/common/helper/navigation/app_navigation.dart';
import 'package:project/core/config/theme/app_color.dart';
import 'package:project/core/config/theme/app_theme.dart';
import 'package:project/features/home/domain/entities/product_entity.dart';
import 'package:project/features/home/presentation/bloc/home_bloc.dart';
import 'package:project/features/product/presentation/pages/product_page.dart';

class ShowSuggestion extends StatelessWidget {
  final String title;
  final List<ProductEntity> product;
  final List<int> favProduct;
  const ShowSuggestion({
    super.key,
    required this.title,
    required this.favProduct,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        shadowColor: AppColors.transparent,
        surfaceTintColor: Colors.transparent,
        backgroundColor: AppColors.white.withOpacity(0),
        title: Text(
          title,
          style: TextThemes.headline2,
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoaded) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 168.5 / 262,
                ),
                itemCount: product.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      AppNavigator.push(
                          context, ProductPage(productId: product[index].id));
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
                                        product[index].imageUrl ?? "",
                                        fit: BoxFit.contain,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Image.asset(
                                              "assets/test_img.png");
                                        },
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 6,
                                    right: 6,
                                    child: state.favorite.any(
                                            (fav) => fav == product[index].id)
                                        ? Container()
                                        : Container(),

                                    // Icon(
                                    //   state.favorite.any(
                                    //           (fav) => fav == product[index].id)
                                    //       ? Icons.favorite
                                    //       : Icons.abc,
                                    //   size: 24,
                                    // ),
                                  )
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product[index].name,
                                    style: TextThemes.bodyBold,
                                    maxLines: 2,
                                  ),
                                  Spacer(),
                                  Text(
                                    product[index].brand,
                                    style: TextThemes.desc
                                        .copyWith(color: AppColors.darkGrey),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "${(product[index].price.min != '0') ? product[index].price.min : '-'} บาท",
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
          } else {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: Text("เกิดข้อผิดพลาด"),
                        content: Text("ไม่สามารถโหลดข้อมูลได้ กรุณาลองใหม่"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context); // ปิด Dialog
                              Navigator.pop(context); // กลับไปหน้าก่อนหน้า
                            },
                            child: Text("ตกลง"),
                          ),
                        ],
                      ));
            });
          }

          return Container();
        },
      ),
    );
  }
}
