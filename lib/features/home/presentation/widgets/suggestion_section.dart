import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/core/common/helper/navigation/app_navigation.dart';
import 'package:project/core/config/theme/app_color.dart';
import 'package:project/core/config/theme/app_theme.dart';
import 'package:project/features/home/domain/entities/product_entity.dart';
import 'package:project/features/home/presentation/bloc/home_bloc.dart';
import 'package:project/features/home/presentation/widgets/show_suggestion.dart';
import 'package:project/features/product/presentation/pages/product_page.dart';

class SuggestionSection extends StatelessWidget {
  final String title;
  final List<ProductEntity> product;
  final List<int> favProduct;
  const SuggestionSection({
    super.key,
    required this.title,
    required this.product,
    required this.favProduct,
  });

  //สร้าง set ของ fav easy to check
  @override
  Widget build(BuildContext context) {
    IconData getFavIcon(int productId) {
      bool isFav = favProduct.any((fav) => fav == productId);
      return isFav ? Icons.favorite : Icons.favorite_border;
    }

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextThemes.headline2,
              ),
              GestureDetector(
                onTap: () {
                  AppNavigator.push(
                      context,
                      ShowSuggestion(
                        title: title,
                        favProduct: favProduct,
                        product: product,
                      ));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "ดูเพิ่มเติม",
                      style:
                          TextThemes.body.copyWith(color: AppColors.darkGrey),
                    ),
                    Icon(
                      Icons.chevron_right_sharp,
                      size: 20,
                      color: AppColors.darkGrey,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 210,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: product.length + 2,
                  itemBuilder: (context, index) {
                    if (index == 0 || product.length + 1 == index) {
                      return Container(
                        width: 10,
                      );
                    }
                    return GestureDetector(
                      onTap: () {
                        AppNavigator.push(context,
                            ProductPage(productId: product[index - 1].id));
                      },
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
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Image.network(
                                    product[index - 1].imageUrl.toString(),
                                    fit: BoxFit.contain,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Image.asset(
                                        "assets/test_img.png",
                                        fit: BoxFit.contain,
                                      );
                                    },
                                  )),
                              const SizedBox(height: 6),
                              Text(
                                product[index - 1].name,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w800,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                textAlign:
                                    TextAlign.left, // Align text to the left
                              ),
                              const Spacer(),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      product[index - 1].brand,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextThemes.desc
                                          .copyWith(color: AppColors.darkGrey),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      bool isFav = favProduct.any((fav) =>
                                          fav == product[index - 1].id);
                                      context.read<HomeBloc>().add(
                                            ToggleFavoriteEvent(
                                              isFavorite: isFav,
                                              productId: product[index - 1].id,
                                            ),
                                          );
                                    },
                                    child:
                                        Icon(getFavIcon(product[index - 1].id)),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
