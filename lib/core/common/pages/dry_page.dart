import 'package:flutter/material.dart';
import 'package:project/core/config/assets/svg_assets.dart';
import 'package:project/core/config/theme/app_theme.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DryPage extends StatelessWidget {
  const DryPage({super.key});

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
              "ผิวแห้ง",
              style: TextThemes.headline1.copyWith(fontSize: 40),
            ),
            const SizedBox(
              height: 48,
            ),
            SvgPicture.asset(SvgAssets.dry_skin),
            const SizedBox(
              height: 24,
            ),
            const Text(
              "ผิวมีความแห้งกร้าน มีความยืดหยุ่นน้อย หากมีรอยแตก ริ้วรอย ร่องลึก จะสามารถมองเห็นได้ชัดเจน อาจมีอาการผิวลอก เป็นขุย และอาการคันร่วมด้วย โดยผิวชนิดนี้มีโอกาสเกิดการระคายเคืองมากกว่าผิวชนิดอื่น",
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
                    "วิธีการดูแลผิวแห้ง",
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
                          "เลือกใช้ผลิตภัณฑ์เนื้อออยล์ และเนื้อครีมเป็นหลัก",
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
                          "เลือกใช้ผลิตภัณฑ์ที่อ่อนโยนต่อผิว ไม่ก่อให้เกิดการระคายเคือง",
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
                          "หลีกเลี่ยงผลิตภัณฑ์ที่ส่วนผสมของแอลกอฮอล์",
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
