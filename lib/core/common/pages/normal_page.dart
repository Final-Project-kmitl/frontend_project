import 'package:flutter/material.dart';
import 'package:project/core/config/assets/svg_assets.dart';
import 'package:project/core/config/theme/app_theme.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NormalPage extends StatelessWidget {
  const NormalPage({super.key});

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
              "ผิวปกติ",
              style: TextThemes.headline1.copyWith(fontSize: 40),
            ),
            const SizedBox(
              height: 48,
            ),
            SvgPicture.asset(SvgAssets.normal_skin),
            const SizedBox(
              height: 24,
            ),
            const Text(
              "เป็นผิวที่มีความสมดุล ไม่แห้งและไม่มันจนเกินไป มีผิวเรียบเนียน รูขุมขนเล็กละเอียด ไม่ค่อยมีปัญหาผิว",
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
                    "วิธีการดูแลผิวปกติ",
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
                          "สามารถใช้ผลิตภัณฑ์ได้ทุกรูปแบบ ทั้งเนื้อหนัก และเนื้อบางเบา ขึ้นอยู่สภาพอากาศ",
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
                          "หมั่นดูแลผิวหน้าอย่างสม่ำเสมอ เพื่อคงความสมดุลของผิว",
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
                          "ทาครีมกันแดดเป็นประจำทุกวัน ป้องกันการเกิดปัญหาผิวที่มีผลมาจากแสงแดด",
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
