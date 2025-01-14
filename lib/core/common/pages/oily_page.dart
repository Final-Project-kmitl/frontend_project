import 'package:flutter/material.dart';
import 'package:project/core/config/assets/svg_assets.dart';
import 'package:project/core/config/theme/app_theme.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OilyPage extends StatelessWidget {
  const OilyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: Navigator.of(context).pop,
          icon: const Icon(
            Icons.chevron_left_sharp,
            size: 30,
            color: Colors.black,
          ),
        ),
        title: const Text(
          "สภาพผิวหน้าของคุณคือ",
          style: TextThemes.headline2,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "ผิวมัน",
              style: TextThemes.headline1.copyWith(fontSize: 40),
            ),
            const SizedBox(
              height: 48,
            ),
            SvgPicture.asset(SvgAssets.oily_skin),
            const SizedBox(
              height: 24,
            ),
            const Text(
              "ผิวมีความเงา มันวาว สะท้อนแสงได้ทั่วทั้งใบหน้า มีรูขุมขนกว้างทั่วทั้งใบหน้า สามารถมองเห็นได้ชัดเจน โดยผิวชนิดนี้มีแนวโน้มจะเป็นสิวได้ง่ายกว่าผิวชนิดอื่น",
              style: TextThemes.body,
            ),
            const SizedBox(
              height: 24,
            ),
            Container(
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "วิธีการดูแลผิวมัน",
                    style: TextThemes.bodyBold,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Baseline(
                        baseline: 20,
                        baselineType: TextBaseline.alphabetic,
                        child: Text(
                          "\u2022",
                          style: TextThemes.headline1,
                        ),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: Text(
                          "เลือกใช้ผลิตภัณฑ์เนื้อบางเบา ในรูปแบบเนื้อน้ำ นม เซรั่ม และเจล",
                          style: TextThemes.body,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Baseline(
                        baseline: 20,
                        baselineType: TextBaseline.alphabetic,
                        child: Text(
                          "\u2022",
                          style: TextThemes.headline1,
                        ),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: Text(
                          "เลือกใช้ผลิตภัณฑ์ที่มีส่วนช่วยในการควบคุมความมัน",
                          style: TextThemes.body,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Baseline(
                        baseline: 20,
                        baselineType: TextBaseline.alphabetic,
                        child: Text(
                          "\u2022",
                          style: TextThemes.headline1,
                        ),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: Text(
                          "ทำความสะอาดผิวหน้าให้สะอาดหมดจด เพื่อลดการเกิดปัญหาสิว",
                          style: TextThemes.body,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
