import 'package:flutter/material.dart';
import 'package:project/core/common/helper/navigation/app_navigation.dart';
import 'package:project/core/config/theme/app_color.dart';
import 'package:project/core/config/theme/app_theme.dart';
import 'package:project/features/product/domain/entities/product_entity.dart';
import 'package:project/features/product/presentation/pages/product_page.dart';
import 'package:project/features/search/domain/entities/count_filter_entity.dart';

class ProductRelateCard extends StatelessWidget {
  final List<ProductRelateEntity> product;
  const ProductRelateCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: product.length == 0 ? 0 : 210,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            if (index == 0 || index == product.length + 1) {
              return SizedBox(
                width: 20 - 12,
              );
            }

            final item = product[index - 1];
            return GestureDetector(
              onTap: () {
                // สร้าง key ใหม่เพื่อบังคับให้ widget สร้างใหม่ทั้งหมด
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ProductPage(
                      key: UniqueKey(), // เพิ่ม unique key
                      productId: item.id,
                    ),
                  ),
                );
              },
              child: Container(
                height: 210,
                width: 124,
                decoration: BoxDecoration(
                    color: AppColors.paleBlue,
                    borderRadius: BorderRadius.circular(12)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(8)),
                      margin: EdgeInsets.all(12),
                      padding: EdgeInsets.all(10),
                      width: 100,
                      height: 100,
                      child: Image.network(
                        item.image_url,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          }
                          return Center(
                            child: Text(
                              "กำลังโหลด",
                              style: TextThemes.desc
                                  .copyWith(color: AppColors.grey),
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            "assets/test_img.png",
                            fit: BoxFit.contain,
                          );
                        },
                      ),
                    ),
                    // SizedBox(
                    //   height: 6,
                    // ),
                    Expanded(
                        child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            child: Text(
                              item.name,
                              style: TextThemes.bodyBold,
                              maxLines: 2,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                            ))),
                    Container(
                      padding: EdgeInsets.all(12),
                      child: Text(
                        item.brand,
                        style:
                            TextThemes.desc.copyWith(color: AppColors.darkGrey),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(
              width: 12,
            );
          },
          itemCount: product.length + 2),
    );
  }
}
