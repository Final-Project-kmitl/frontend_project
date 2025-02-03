import 'package:flutter/material.dart';
import 'package:project/core/config/theme/app_color.dart';
import 'package:project/core/config/theme/app_theme.dart';

class SuggestionSection extends StatefulWidget {
  const SuggestionSection({super.key});

  @override
  State<SuggestionSection> createState() => _SuggestionSectionState();
}

class _SuggestionSectionState extends State<SuggestionSection> {
  final List<String> mockProduct = <String>[
    "AAAA   aaaaaaaaaaaaAAAGSDFGRT",
    "BBBB",
    "ADSFAF",
    "arewfefAFE",
    "qwihjqoriweqmr",
    "afmoejeiowmr",
    "asmfeoewmsof"
  ];
  List<String> mockSelectProuct = [];

  void onSelected(String input) {
    setState(() {
      if (mockSelectProuct.contains(input)) {
        mockSelectProuct.remove(input);
      } else {
        mockSelectProuct.add(input);
      }
    });
  }

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
                "แนะนำสำหรับคุณ",
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
                  itemCount: 7,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Container(
                        width: 10,
                      );
                    }
                    return Container(
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
                              child: Image.asset(
                                "assets/test_img.png",
                                fit: BoxFit.contain,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              mockProduct[index],
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
                                const Text(
                                  "OOTD",
                                  style: TextStyle(fontSize: 12),
                                ),
                                const Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    onSelected(mockProduct[index]);
                                  },
                                  child: mockSelectProuct
                                          .contains(mockProduct[index])
                                      ? const Icon(
                                          Icons.favorite,
                                        )
                                      : const Icon(Icons.favorite_border),
                                )
                              ],
                            ),
                          ],
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
