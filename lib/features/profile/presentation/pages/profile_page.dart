import 'package:flutter/material.dart';
import 'package:project/core/common/helper/navigation/app_navigation.dart';
import 'package:project/core/config/theme/app_color.dart';
import 'package:project/core/config/theme/app_theme.dart';
import 'package:project/features/favorite/presentation/pages/favorite_page.dart';
import 'package:project/features/profile/presentation/pages/edit_skin_allergies_page.dart';
import 'package:project/features/profile/presentation/pages/edit_skin_problem_page.dart';
import 'package:project/features/profile/presentation/pages/edit_skin_type_page.dart';
import 'package:project/features/profile/presentation/widgets/skin_type_tag.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    // 🔹 Mock Data ของผู้ใช้
    String skinType = "ผิวมัน"; // Skin Type
    List<String> skinConcerns = [
      "เป็นสิว",
      "มีริ้วรอย",
      "ผิวไม่เรียบเนียน",
      "หน้ามัน"
    ]; // ปัญหาผิว
    List<String> skinAllergies = ["AHA", "Alcohol", "Silicone"];

    // รวมปัญหาผิวทั้งหมดเป็นข้อความเดียว
    String concernsText = skinConcerns.join(', ');
    String allergiesText = skinAllergies.join(', ');

    return Scaffold(
        body: SafeArea(
      top: true,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 24),
              const Text('เกี่ยวกับฉัน', style: TextThemes.headline1),
              const SizedBox(height: 16),
              Wrap(
                alignment: WrapAlignment.center,
                children: [
                  SkinTypeTag(text: skinType, color: AppColors.beige),
                  ...skinConcerns
                      .map((concern) =>
                          SkinTypeTag(text: concern, color: AppColors.paleBlue))
                      .toList(),
                ],
              ),
              const SizedBox(height: 32),
              // กล่องแรก
              Container(
                decoration: BoxDecoration(
                  color: AppColors.offWhite,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    // สภาพผิว
                    ListTile(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 12),
                      title: const Text('สภาพผิว', style: TextThemes.bodyBold),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(skinType,
                              style: TextThemes.body
                                  .copyWith(color: AppColors.darkGrey)),
                          const SizedBox(width: 8),
                          const Icon(
                            Icons.chevron_right,
                            size: 24,
                            color: AppColors.black,
                          ),
                        ],
                      ),
                      onTap: () {
                        AppNavigator.push(context, EditSkinTypePage());
                      },
                    ),
                    const Divider(
                      color: AppColors.grey,
                      indent: 12,
                      endIndent: 12,
                      height: 0,
                    ),
                    // ปัญหาผิว
                    ListTile(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 12),
                      title: const Text('ปัญหาผิว',
                          style: TextThemes.bodyBold, maxLines: 1),
                      trailing: SizedBox(
                        width: 200,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              child: Text(
                                concernsText,
                                style: TextThemes.body
                                    .copyWith(color: AppColors.darkGrey),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Icon(
                              Icons.chevron_right,
                              size: 24,
                              color: AppColors.black,
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        AppNavigator.push(context, EditSkinProblemPage());
                      },
                    ),
                    const Divider(
                      color: AppColors.grey,
                      indent: 12,
                      endIndent: 12,
                      height: 0,
                    ),
                    ListTile(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 12),
                      title: const Text('สารที่แพ้',
                          style: TextThemes.bodyBold, maxLines: 1),
                      trailing: SizedBox(
                        width: 200,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              child: Text(
                                allergiesText,
                                style: TextThemes.body
                                    .copyWith(color: AppColors.darkGrey),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Icon(
                              Icons.chevron_right,
                              size: 24,
                              color: AppColors.black,
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        AppNavigator.push(context, EditSkinAllergiesPage());
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 64), // ระยะห่างระหว่างกล่อง
              // กล่องที่สอง
              Container(
                decoration: BoxDecoration(
                  color: AppColors.offWhite,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    ListTile(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 12),
                      title: const Text('รายงานข้อผิดพลาด',
                          style: TextThemes.bodyBold),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.chevron_right,
                            size: 24,
                            color: AppColors.black,
                          ),
                        ],
                      ),
                      onTap: () {
                        AppNavigator.push(context, FavoritePage());
                      },
                    ),
                    const Divider(
                      color: AppColors.grey,
                      indent: 12,
                      endIndent: 12,
                      height: 0,
                    ),
                    ListTile(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 12),
                      title: Text(
                        'ลบบัญชี',
                        style: TextThemes.bodyBold
                            .copyWith(color: Colors.red), // เปลี่ยนสีเป็นสีแดง
                      ),
                      onTap: () {
                        // แสดง Dialog ยืนยันการลบเมื่อกด
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                              backgroundColor: AppColors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 16.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: double.infinity,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'ลบบัญชี?',
                                            style: TextThemes.bodyBold.copyWith(
                                                color: AppColors.black),
                                          ),
                                          GestureDetector(
                                            onTap: () => Navigator.pop(context),
                                            behavior: HitTestBehavior.opaque,
                                            child: Icon(
                                              Icons.close,
                                              color: AppColors.black,
                                              size: 24, // กำหนดขนาดไอคอน
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 24),
                                    Text(
                                      'เมื่อลบบัญชีจะไม่สามารถกู้คืนข้อมูลของคุณได้\nคุณยืนยันที่จะลบบัญชีหรือไม่?',
                                      style: TextThemes.desc
                                          .copyWith(color: AppColors.black),
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        ElevatedButton(
                                          style: ButtonThemes.backwardButton,
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: Text("ยกเลิก",
                                              style: TextThemes.descBold
                                                  .copyWith(
                                                      color: AppColors.black)),
                                        ),
                                        const SizedBox(
                                            width:
                                                16), // เพิ่มระยะห่างระหว่างปุ่ม
                                        SizedBox(
                                          width: 90,
                                          child: FilledButton(
                                            style: ButtonThemes.denialButton,
                                            onPressed: () {/* Logic ลบบัญชี */},
                                            child: Text('ลบ',
                                                style: TextThemes.descBold
                                                    .copyWith(
                                                        color: Colors.red)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
