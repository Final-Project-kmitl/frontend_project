import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:project/core/config/theme/app_color.dart';
import 'package:project/core/config/theme/app_theme.dart';
import 'package:project/features/camera/presentation/pages/barcode_awesome.dart';
import 'package:project/features/camera/presentation/pages/camera_awesome.dart';
import 'package:project/features/camera/presentation/widgets/toggle_button.dart';
import 'package:project/service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CameraDirection extends StatefulWidget {
  const CameraDirection({super.key});

  @override
  State<CameraDirection> createState() => _CameraDirectionState();
}

class _CameraDirectionState extends State<CameraDirection> {
  late PageController _pageController;

  int currentPage = 0;
  bool? doNotShowAgain = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController(initialPage: 0);
    _loadShowAgainPreference();
  }

  Future<void> _loadShowAgainPreference() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      doNotShowAgain = prefs.getBool("doNotShowAgain") ?? false;
    });
    if (!(prefs.getBool("doNotShowAgain") ?? false)) {
      _showAdviceDialog();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _pageController.dispose();
    super.dispose();
  }

  void _showAdviceDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return Material(
          color: AppColors.white,
          type: MaterialType.transparency,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                title: Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          "คำแนะนำสำหรับการถ่ายรูป",
                          style: TextThemes.bodyBold,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(Icons.close),
                    ),
                  ],
                ),
                content: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "1.ถ่ายรูปในที่ที่มีแสงสว่างเพียงพอ",
                      style: TextThemes.body,
                    ),
                    Text("2.ถ่ายให้รายการส่วนผสมทั้งหมดอยู่ในกรอบ",
                        style: TextThemes.body),
                    Text("3.ในรูปควรมีแสงสะท้อนน้อยที่สุด",
                        style: TextThemes.body),
                    Text(
                        "4.หากบรรจุภัณฑ์มีความโค้ง ควรถ่ายรูป\nมากกว่า 1 รูปเพื่อให้เห็นส่วนผสมครบทุกตัว",
                        style: TextThemes.body),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Checkbox(
                      checkColor: AppColors.black,
                      side: BorderSide(color: Colors.white),
                      activeColor: AppColors.white,
                      value: sl<SharedPreferences>().getBool("doNotShowAgain"),
                      onChanged: (value) async {
                        Navigator.pop(context);

                        // ถ้า value เป็น true ก็เก็บค่าลง SharedPreferences

                        await sl<SharedPreferences>()
                            .setBool("doNotShowAgain", value!);
                      },
                    ),
                    Flexible(
                      child: Text(
                        "ไม่ต้องแสดงอีก",
                        style: TextThemes.desc.copyWith(color: AppColors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void toggleFn() {
    if (currentPage == 0) {
      _pageController.animateToPage(1,
          duration: Duration(milliseconds: 300), curve: Curves.easeIn);
      setState(() {
        currentPage = 1;
      });
    } else {
      _pageController.animateToPage(0,
          duration: Duration(milliseconds: 300), curve: Curves.easeIn);
      setState(() {
        currentPage = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            PageView(
              controller: _pageController,
              physics: NeverScrollableScrollPhysics(),
              children: [
                BarcodeAwesome(),
                CameraAwesome(),
              ],
            ),
            SafeArea(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: EdgeInsets.only(left: 5),
                          height: 42,
                          width: 42,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black54,
                          ),
                          child: Center(
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _showAdviceDialog();
                        },
                        child: Container(
                          padding: EdgeInsets.only(left: 5),
                          height: 42,
                          width: 42,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black54,
                          ),
                          child: Center(
                            child: Icon(
                              Icons.book_rounded,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  ToggleButton(
                    fn: toggleFn,
                  )
                ],
              ),
            )),
          ],
        ));
  }
}
