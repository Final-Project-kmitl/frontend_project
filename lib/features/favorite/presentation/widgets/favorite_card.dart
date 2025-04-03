import 'package:flutter/material.dart';
import 'package:project/core/common/helper/navigation/app_navigation.dart';
import 'package:project/core/config/theme/app_color.dart';
import 'package:project/core/config/theme/app_theme.dart';
import 'package:project/features/favorite/domain/entities/fav_product.dart';
import 'package:project/features/product/presentation/pages/product_page.dart';

var testMoock = [
  {
    "imgUrl":
        "https://medias.watsons.co.th/publishing/WTCTH-255543-front-KIPZvQs5-zoom.png?version=1735151487",
    "Product": "OOTD Dark Spot Vitamin C Serum",
    "Brand": "OOTD",
    "price": "400",
    "rating": "60",
  },
  {
    "imgUrl":
        "https://medias.watsons.co.th/publishing/WTCTH-255543-front-KIPZvQs5-zoom.png?version=1735151487",
    "Product": "OOTD Dark Spot Vitamin C Serum",
    "Brand": "OOTD",
    "price": "400",
    "rating": "60",
  }
];

var rating = 75;

class FavoriteCard extends StatelessWidget {
  final FavProductEntities product;
  final bool isUnFav;
  final VoidCallback onToggleFavorite;
  const FavoriteCard(
      {super.key,
      required this.isUnFav,
      required this.onToggleFavorite,
      required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppNavigator.push(context, ProductPage(productId: product.id));
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        color: AppColors.paleBlue,
        margin: EdgeInsets.zero,
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Stack(
                  children: [
                    SizedBox(
                      height: 140,
                      width: double.infinity,
                      child: Container(
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(color: AppColors.white),
                        child: Image.network(
                          product.img ?? "",
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            } else {
                              return Center(
                                child: Text(
                                  "Loading...",
                                  style: TextThemes.desc
                                      .copyWith(color: AppColors.grey),
                                ),
                              ); // ถ้ายังโหลดอยู่ ให้แสดง progress bar
                            }
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              "assets/test_img.png",
                              fit: BoxFit.contain,
                            );
                          },
                          fit: BoxFit
                              .contain, // ปรับให้ภาพเต็มพื้นที่ โดยอาจตัดบางส่วนออก
                        ),
                      ),
                    ),
                    Positioned(
                      right: 3,
                      top: 3,
                      child: IconButton(
                        onPressed: onToggleFavorite,
                        icon: Icon(
                          isUnFav ? Icons.favorite_border : Icons.favorite,
                          size: 30,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 6),
              Text(
                product.product,
                maxLines: 2,
                style: TextThemes.bodyBold
                    .copyWith(overflow: TextOverflow.ellipsis),
              ),
              Spacer(),
              Text(
                product.brand,
                style: TextThemes.desc.copyWith(color: AppColors.darkGrey),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    product.maxPrice == product.minPrice
                        ? "- บาท"
                        : "${product.maxPrice} - ${product.minPrice} บาท",
                    style: TextThemes.bodyBold,
                  ),
                  // Container(
                  //   decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(4),
                  //       color: product.rating.length > 70
                  //           ? AppColors.quality_good_match
                  //           : rating > 35
                  //               ? AppColors.quality_medium_match
                  //               : rating > 0
                  //                   ? AppColors.quality_poor_match
                  //                   : AppColors.quality_not_math),
                  //   padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                  //   child: Text(
                  //     "${product.rating}/100",
                  //     style: TextThemes.descBold.copyWith(color: AppColors.white),
                  //   ),
                  // )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
