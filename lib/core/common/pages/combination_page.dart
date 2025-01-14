import 'package:flutter/material.dart';
import 'package:project/core/config/assets/svg_assets.dart';
import 'package:project/core/config/theme/app_theme.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CombinationPage extends StatelessWidget {
  const CombinationPage({super.key});

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
              "ผิวผสม",
              style: TextThemes.headline1.copyWith(fontSize: 40),
            ),
            const SizedBox(
              height: 48,
            ),
            SvgPicture.asset(SvgAssets.combination_skin),
            const SizedBox(
              height: 24,
            ),
            const Text(
              "เป็นลักษณะของ ผิวมัน + ผิวแห้ง/ผิวธรรมดา บริเวณ T-Zone มีความมันวาว  รูขุมขนกว้าง เห็นได้ชัดเจน มักมีสิวขึ้นในบริเวณนี้ ส่วนบริเวณหน้าแก้มและรอบดวงตา จะมีลักษณะคล้ายผิวแห้งหรือผิวธรรมดา",
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
                    "วิธีการดูแลผิวผสม",
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
                          "เลือกใช้ผลิตภัณฑ์เนื้อบางเบาในรูปแบบเนื้อน้ำนม เซรั่ม และเจลตอนกลางวัน เพื่อไม่ให้เกิดความมันส่วนเกิน",
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
                          "เลือกใช้ผลิตภัณฑ์เนื้อหนักในรูปแบบออยล์ และครีมตอนกลางคืน เพื่อบำรุงบริเวณที่ขาดความชุ่มชื้น",
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
