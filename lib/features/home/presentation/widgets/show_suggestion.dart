import 'package:flutter/material.dart';
import 'package:project/core/config/theme/app_color.dart';
import 'package:project/core/config/theme/app_theme.dart';
import 'package:project/features/home/domain/entities/product_entity.dart';

class ShowSuggestion extends StatelessWidget {
  final String title;
  final List<ProductEntity> product;
  final List<FavoriteProductEntity> favProduct;
  const ShowSuggestion({
    super.key,
    required this.title,
    required this.favProduct,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    print("ASDFASDFASDFASDF : ${product}");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: Text(
          title,
          style: TextThemes.headline2,
        ),
        centerTitle: true,
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 168.5 / 262,
              ),
              itemCount: product.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {},
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
                                Image.network(
                                  product[index].imageUrl,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Image.asset("assets/test_img.png");
                                  },
                                ),
                                Positioned(
                                    top: 6,
                                    right: 6,
                                    child: GestureDetector(
                                      onTap: () {},
                                      child: Icon(
                                        Icons.favorite,
                                        size: 24,
                                      ),
                                    ))
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product[index].name,
                                style: TextThemes.bodyBold,
                                maxLines: 2,
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Text(
                                product[index].brand,
                                style: TextThemes.desc
                                    .copyWith(color: AppColors.darkGrey),
                              ),
                              Row(
                                children: [
                                  Text("${product[index].price.min ?? '-'} บาท")
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              })),
    );
  }
}
