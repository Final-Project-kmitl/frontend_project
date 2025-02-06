import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:project/core/config/theme/app_theme.dart';

class CategorySection extends StatelessWidget {
  const CategorySection({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> categoryProduct = <String>[
      "รักษาสิว",
      "ลดเลือนริ้วรอย",
      "ลดจุดด่างดำ",
      "กระชับรูขุมขน",
      "ควบคุมความมัน",
      "ปรับสีผิวให้สม่ำเสมอ",
      "ชุ่มชื้น/ปลอบประโลมผิว",
      "ทำให้ผิวเรียบเนียน"
    ];

    final List<String> categoryProductImg = <String>[
      "assets/home/Acne.svg",
      "assets/home/Wrinkle.svg",
      "assets/home/Dark spot.svg",
      "assets/home/Pore.svg",
      "assets/home/Oil control.svg",
      "assets/home/Evens skin tone.svg",
      "assets/home/Soothing skin.svg",
      "assets/home/Skin smoothen.svg"
    ];

    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start, // Align the content to the start
      children: [
        Container(
          padding: const EdgeInsets.only(top: 0),
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              "หมวดหมู่ผลิตภัณฑ์",
              style: TextThemes.headline2,
            ),
          ),
        ),
        LayoutBuilder(builder: (context, constraints) {
          double itemWidth = (constraints.maxWidth) / 4;
          double itemHeight = itemWidth + 8;
          double aspectRatio = itemWidth / itemHeight;

          return Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 20.0), // Adjust vertical padding if needed
            child: GridView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: categoryProduct.length,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: aspectRatio,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    print(index);
                  },
                  child: Column(
                    children: [
                      Container(
                        width: 65,
                        height: 65,
                        decoration: BoxDecoration(
                          border:
                              Border.all(width: 0.5, color: Color(0xffE1D7CE)),
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                            colors: [
                              Color(0xffE9F2FB),
                              Color(0xffEFE8FA),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                        child: SvgPicture.asset(categoryProductImg[index]),
                      ),
                      const SizedBox(height: 4),
                      Flexible(
                        child: Container(
                          width: 78,
                          child: Text(
                            categoryProduct[index],
                            style: TextThemes.desc,
                            textAlign: TextAlign.center,
                            softWrap: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        })
      ],
    );
  }
}
