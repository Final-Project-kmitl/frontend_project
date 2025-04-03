import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/core/common/helper/navigation/app_navigation.dart';
import 'package:project/core/config/theme/app_color.dart';
import 'package:project/core/config/theme/app_theme.dart';
import 'package:project/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:project/features/profile/presentation/widgets/card_component.dart';
import 'package:project/features/profile/presentation/widgets/skinTypeQuiz_page.dart';

class EditSkinTypePage extends StatefulWidget {
  final int skinTypeId;
  const EditSkinTypePage({super.key, this.skinTypeId = 5});

  @override
  State<EditSkinTypePage> createState() => _EditSkinTypePageState();
}

class _EditSkinTypePageState extends State<EditSkinTypePage> {
  late int onSelectId;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    onSelectId = widget.skinTypeId;
  }

  @override
  Widget build(BuildContext context) {
    late List<Map<String, dynamic>> skinTypes = [
      {
        "skinTypeId": 1,
        "skinTypeName": "ผิวปกติ",
        "img": "assets/form/normal.svg"
      },
      {
        "skinTypeId": 2,
        "skinTypeName": "ผิวผสม",
        "img": "assets/form/combination.svg"
      },
      {
        "skinTypeId": 3,
        "skinTypeName": "ผิวมัน",
        "img": "assets/form/oily.svg"
      },
      {
        "skinTypeId": 4,
        "skinTypeName": "ผิวแห้ง",
        "img": "assets/form/dry.svg"
      },
      {
        "skinTypeId": 5,
        "skinTypeName": "ไม่ทราบ",
        "img": "assets/form/unknown.svg"
      },
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: const Text(
          'สภาพผิว',
          style: TextThemes.headline2,
        ),
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () {
            Navigator.pop(context); // กลับไปหน้าก่อนหน้า
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(child: LayoutBuilder(builder: (context, constraints) {
            double itemWidth = 60;
            double itemHeight = 170;
            double aspectRatio = itemHeight / itemWidth;
            return GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: aspectRatio,
              ),
              itemCount: skinTypes.length,
              itemBuilder: (context, index) {
                return CardComponent(
                  id: skinTypes[index]['skinTypeId'],
                  title: skinTypes[index]["skinTypeName"],
                  imagePath: skinTypes[index]["img"],
                  onSelect: (type) {
                    setState(() {
                      onSelectId = type;
                    });
                  },
                  isSelected: onSelectId == skinTypes[index]['skinTypeId'],
                );
              },
            );
          })),
          Spacer(),
          BlocListener<ProfileBloc, ProfileState>(
            listener: (context, state) {
              // TODO: implement listener
              if (state is UpdateSkinTypeLoading) {
                showDialog(
                  context: context,
                  barrierDismissible: false, // ❌ ป้องกันการกดออก
                  builder: (context) {
                    return const AlertDialog(
                      backgroundColor: AppColors.white,
                      content: Row(
                        children: [
                          CircularProgressIndicator(
                            color: AppColors.black,
                          ),
                          SizedBox(width: 16),
                          Text("กำลังอัปเดตข้อมูล..."),
                        ],
                      ),
                    );
                  },
                );
              }
              if (state is UpdateSkintTypeSuccess) {
                context.read<ProfileBloc>().add(ProfileLoadEvent());
                Navigator.pop(context);
                Navigator.pop(context);
              }
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: onSelectId == 5
                  ? Row(
                      children: [
                        Expanded(
                          child: makeFormButton(),
                        ),
                        SizedBox(width: 16), // เพิ่มระยะห่าง
                        Expanded(
                            child:
                                submitButton()), // Expanded อยู่ภายใน Row ถูกต้อง
                      ],
                    )
                  : submitButton(),
            ),
          ),
        ],
      ),
    );
  }

  Widget makeFormButton() {
    return GestureDetector(
      onTap: () {
        AppNavigator.pushReplacement(context, SkinTypeQuiz());
      },
      child: Container(
        width: double.infinity, // ใช้ width เต็มแทน Expanded
        margin: EdgeInsets.only(bottom: 52),
        decoration: BoxDecoration(
          color: AppColors.white,
          border: Border.all(color: AppColors.black),
          borderRadius: BorderRadius.circular(16),
        ),
        height: 52,
        child: Center(
          child: Text(
            "ทำแบบทดสอบ",
            style: TextThemes.bodyBold.copyWith(color: AppColors.black),
          ),
        ),
      ),
    );
  }

  Widget submitButton() {
    return GestureDetector(
      onTap: () {
        context.read<ProfileBloc>().add(UpdateSkinTypeEvent(onSelectId));
      },
      child: Container(
        width: double.infinity, // ใช้ width เต็มแทน Expanded
        margin: EdgeInsets.only(bottom: 52),
        decoration: BoxDecoration(
          color: AppColors.black,
          borderRadius: BorderRadius.circular(16),
        ),
        height: 52,
        child: Center(
          child: Text(
            "บันทึก",
            style: TextThemes.bodyBold.copyWith(color: AppColors.white),
          ),
        ),
      ),
    );
  }
}
