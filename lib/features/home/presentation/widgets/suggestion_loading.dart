import 'package:flutter/material.dart';
import 'package:project/core/config/theme/app_color.dart';
import 'package:project/core/config/theme/app_theme.dart';
import 'package:shimmer/shimmer.dart';

class SuggestionLoading extends StatelessWidget {
  final String title;
  const SuggestionLoading({
    super.key,
    required this.title,
  });

  //สร้าง set ของ fav easy to check
  @override
  Widget build(BuildContext context) {
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
                onTap: () {},
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
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    if (index == 0 || 10 + 1 == index) {
                      return Container(
                        width: 10,
                      );
                    }
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
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Container()),
                              const SizedBox(height: 6),
                              const Spacer(),
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
