import 'package:flutter/material.dart';
import 'package:project/core/config/theme/app_color.dart';
import 'package:project/core/config/theme/app_theme.dart';

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
  const FavoriteCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
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
                    child: Image.network(
                      'https://medias.watsons.co.th/publishing/WTCTH-255543-front-KIPZvQs5-zoom.png?version=1735151487',
                      fit: BoxFit
                          .contain, // ปรับให้ภาพเต็มพื้นที่ โดยอาจตัดบางส่วนออก
                    ),
                  ),
                  Positioned(
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.favorite),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 6),
            Text(
              "namelkanslgfbnlsdfgn jlnsdflfgn k asdkfjgnlksdjnalkf ;jnklasdnlnfk",
              maxLines: 2,
              style:
                  TextThemes.bodyBold.copyWith(overflow: TextOverflow.ellipsis),
            ),
            const SizedBox(height: 6),
            Text(
              "brand",
              style: TextThemes.desc.copyWith(color: AppColors.darkGrey),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '400 บาท',
                  style: TextThemes.bodyBold,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: rating > 70
                          ? AppColors.quality_good_match
                          : rating > 35
                              ? AppColors.quality_medium_match
                              : rating > 0
                                  ? AppColors.quality_poor_match
                                  : AppColors.quality_not_math),
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                  child: Text(
                    "${rating}/100",
                    style: TextThemes.descBold.copyWith(color: AppColors.white),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
