import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:project/core/common/helper/navigation/app_navigation.dart';
import 'package:project/core/config/theme/app_theme.dart';
import 'package:project/features/home/presentation/bloc/home_bloc.dart';
import 'package:project/features/home/presentation/pages/show_benefit.dart';
import 'package:project/features/home/presentation/pages/show_test.dart';
import 'package:project/features/routine/presentation/pages/routine_page.dart';
import 'package:project/features/search/presentation/pages/search_page.dart';

class CategorySection extends StatefulWidget {
  const CategorySection({
    super.key,
  });

  @override
  State<CategorySection> createState() => _CategorySectionState();
}

class _CategorySectionState extends State<CategorySection> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> categoryProduct = [
      {"id": 6, "benefit": "รักษาสิว"},
      {"id": 8, "benefit": "ลดเลือนริ้วรอย"},
      {"id": 7, "benefit": "ลดจุดด่างดำ"},
      {"id": 1, "benefit": "กระชับรูขุมขน"},
      {"id": 2, "benefit": "ควบคุมความมัน"},
      {"id": 5, "benefit": "ปรับสีผิวให้สม่ำเสมอ"},
      {"id": 3, "benefit": "ชุ่มชื้น/ปลอบประโลมผิว"},
      {"id": 4, "benefit": "ทำให้ผิวเรียบเนียน"},
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
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize:
          MainAxisSize.min, // ให้ Column มีขนาดเล็กที่สุดเท่าที่จำเป็น
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
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: LayoutBuilder(
            builder: (context, constraints) {
              double width = constraints.maxWidth;
              // คำนวณความสูงอัตโนมัติตามจำนวนแถวที่จะแสดง
              double itemWidth = width / 4;
              double itemHeight = itemWidth + 30; // ปรับตามความสูงที่ต้องการ
              int rows = (categoryProduct.length / 4).ceil();
              double totalHeight = rows * itemHeight;

              return SizedBox(
                height: totalHeight,
                child: GridView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(), // สำคัญมาก
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: itemWidth / itemHeight,
                  ),
                  itemCount: categoryProduct.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        context.read<HomeBloc>();
                        AppNavigator.push(
                            context,
                            BlocProvider.value(
                              value: context.read<HomeBloc>(),
                              child: ShowBenefit(
                                  benefitId: categoryProduct[index]['id'],
                                  benefit: categoryProduct[index]['benefit']),
                            ));
                      },
                      child: Column(
                        children: [
                          Container(
                            width: 65,
                            height: 65,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 0.5, color: Color(0xffE1D7CE)),
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
                                categoryProduct[index]['benefit'],
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
            },
          ),
        )
      ],
    );
  }
}
