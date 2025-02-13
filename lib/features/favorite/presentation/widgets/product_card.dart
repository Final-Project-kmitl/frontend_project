import 'package:flutter/material.dart';
import 'package:project/core/config/theme/app_color.dart';
import 'package:project/core/config/theme/app_theme.dart';
import 'package:provider/provider.dart';
import '../bloc/favorite_bloc.dart';

var name = 'OOTD Dark Spot Vitamin C Serum';
var brand = 'OOTD';

class ProductFavCard extends StatelessWidget {
  const ProductFavCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0), //ขอบจอ 20
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 24), //เว้นข้างบน 24
            const Text('การกดถูกใจ', style: TextThemes.headline1),
            const SizedBox(height: 24), //เว้นระยะก่อนแสดง grid 24
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16, //ระยะห่างระหว่าง 2 card
                  childAspectRatio: 0.626,
                ),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      Card(
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
                                child: Image.asset(
                                  'assets/product/Frame171.png',
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(name,
                                  maxLines: 2, style: TextThemes.bodyBold),
                              const SizedBox(height: 6),
                              Text(
                                brand,
                                style: TextThemes.desc
                                    .copyWith(color: AppColors.darkGrey),
                              ),
                              Text(
                                '400 บาท',
                                style: TextThemes.bodyBold,
                              ),
                            ],
                          ),
                        ),
                      ),

                      // ปุ่ม Favorite
                      Positioned(
                        top: 16,
                        right: 16,
                        child: FavoriteButton(index: index),
                      ),

                      // Score Tag ที่มุมล่างขวา
                      Positioned(
                        bottom:
                            24, //อันนี้ไม่รู้ว่าทำไมต้องเป็น 24 แค่ลองแล้วระยะมันได้;-;
                        right: 12,
                        child: ScoreTag(index: index),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ปุ่ม Favorite
class FavoriteButton extends StatelessWidget {
  final int index;
  const FavoriteButton({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoriteProvider>(context);

    return IconButton(
      icon: Icon(
        favoriteProvider.isFavorite(index)
            ? Icons.favorite
            : Icons.favorite_border,
        color: favoriteProvider.isFavorite(index)
            ? Colors.red
            : AppColors.black, //ลองหัวใจสีแดงละสวยกว่า
      ),
      onPressed: () {
        favoriteProvider.toggleFavorite(index);
      },
    );
  }
}

// Score Tag (Mock-up Score)
class ScoreTag extends StatelessWidget {
  final int index;
  const ScoreTag({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final score = 75; // Mock-up คะแนน (สามารถเปลี่ยนให้ dynamic ได้ภายหลัง)

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.quality_good_match,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        '$score/100', // แสดงคะแนน mock-up
        style: TextThemes.descBold.copyWith(color: AppColors.white),
      ),
    );
  }
}
