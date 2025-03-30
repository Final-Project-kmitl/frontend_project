import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:project/core/config/theme/app_color.dart';
import 'package:project/core/config/theme/app_theme.dart';
import 'package:shimmer/shimmer.dart';

class SkinTypeQuiz extends StatefulWidget {
  const SkinTypeQuiz({super.key});

  @override
  State<SkinTypeQuiz> createState() => _SkinTypeQuizState();
}

class _SkinTypeQuizState extends State<SkinTypeQuiz> {
  final PageController _pageController = PageController();
  final PageController _formPageController = PageController();
  int _currentPage = 0;
  List<String> skinTypeQuiz = ["", "", "", "", "", "", ""];
  List<int> skinAnswerCount = [0, 0, 0, 0, 0, 0, 0];

  Map<String, dynamic> _resultQuiz = {
    "title": "",
    "pic": "",
    "des": "",
    "care": []
  };

//material for build page
  List<Widget> _buildPages() {
    return [
      _buildQuestionPage("หลังล้างหน้าด้วยโฟมล้างหน้า\nคุณรู้สึกอย่างไร?", [
        "รู้สึกผิวแห้งและตึง บางครั้งมีอาการคันร่วมด้วย",
        "รู้สึกผิวขาดความชุ่มชื้น แห้งเล็กน้อย ไม่ตึง ผิวจะกลับมาสมดุลได้ในไม่ช้า",
        "รู้สึกสะอาด แต่รู้สึกแห้งในช่วงบริเวณหน้าแก้ม และรอบดวงตา",
        "รู้สึกสะอาดทั่วทั้งใบหน้า อาจเหลือความมันอยู่บนผิวในบางครั้ง"
      ]),
      _buildQuestionPage(
          "หลังจากล้างหน้า 2 ชั่วโมง โดยไม่ทา moisturizer ผิวคุณเป็นอย่างไร?", [
        "ผิวแห้ง ขาดความชุ่มชื้น",
        "ผิวไม่แห้งและไม่มัน",
        "มีความมันบริเวณ T-zone",
        "มีความมันทั่วทั้งใบหน้า"
      ]),
      _buildQuestionPage(
          "ในหน้าหนาว/ห้องแอร์ ถ้าไม่ใช้ moisturizer ผิวของคุณจะเป็นอย่างไร?", [
        "หน้าแห้ง ลอก เป็นขุย อาจมีอาการคันร่วมด้วย",
        "ขาดความชุ่มชื้นทั่วทั้งใบหน้า แต่ไม่ลอกหรือเป็นขุย",
        "บริเวณ T-zone ปกติดี แต่รู้สึกแห้งบริเวณหน้าแก้มและรอบดวงตา",
        "ปกติดี ไม่รู้สึกว่าผิวแห้ง"
      ]),
      _buildQuestionPage("ในรูปถ่ายผิวของคุณมีความมันวาวหรือไม่?", [
        "แทบไม่เคยสังเกตเห็นความมันวาวเลย",
        "มีความมันบ้างนาน ๆ ครั้ง",
        "มีความมันวาวบริเวณ บริเวณ T-zone เป็นประจำ",
        "มีความมันวาวทั่วทั้งใบหน้าเป็นประจำ"
      ]),
      _buildQuestionPage("รูขุมขนของคุณมีลักษณะเป็นอย่างไร?", [
        "สังเกตไม่ค่อยเห็นรูขุมขน",
        "สังเกตเห็นรูขุมขนบ้าง แต่น้อย",
        "สังเกตเห็นรูขุมขนได้ชัดบริเวณ T-zone",
        "สังเกตเห็นรูขุมขนได้ชัดทั่วทั้งใบหน้า"
      ]),
      _buildQuestionPage("คุณเป็นสิวบ่อยแค่ไหน?", [
        "ไม่ค่อยมีปัญหาสิว",
        "นาน ๆ ครั้ง มักจะเกิดในช่วงที่อากาศร้อน หรือฮอร์โมนเปลี่ยนแปลง",
        "เป็นสิวบ่อยที่บริเวณ T-zone",
        "เป็นสิวประจำ และมีสิวบริเวณหน้าแก้มร่วมด้วย"
      ]),
      _buildQuestionPage(
          "สกินแคร์แบบไหนที่ทำให้ผิวของคุณมีความสมดุล ไม่แห้ง ไม่มัน จนเกินไป?",
          [
            "เนื้อออยล์ ครีม หรือบาล์ม ที่มอบความความชุ่มชื้นนุ่มลื่นให้แก่ผิว",
            "เปลี่ยนไปตามสภาพอากาศ สามารถใช้ได้ทั้งสกินแคร์เนื้อหนัก และบางเบา",
            "เนื้อน้ำ เนื้อนม หรือเซรั่ม ที่ให้ความรู้สึกบางเบา แต่ยังคงมอบความชุ่มชื้น นุ่มลื่นให้แก่ผิว",
            "เนื้อน้ำ เนื้อนม หรือเซรั่ม ที่ให้ความรู้สึกบางเบา ไม่มัน แห้งไว"
          ]),
    ];
  }

  void _sendForm() {
    _calculateSkinType(skinAnswerCount);

    _formPageController.jumpToPage(2);

    if (_resultQuiz["title"] != "") {
      print(_resultQuiz["title"]);
      Future.delayed(const Duration(seconds: 1), () {
        _formPageController.animateToPage(3,
            duration: Duration(milliseconds: 300), curve: Curves.easeOut);
      });
    }
  }

  void _nextPage() {
    setState(() {
      if (_currentPage < 6) {
        _currentPage += 1;
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void _previousPage() {
    setState(() {
      if (_currentPage > 0) {
        _currentPage -= 1;
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: PageView(
        controller: _formPageController,
        children: [
          _buildStartFormPage(),
          _buildForm(),
          _loadPage(),
          _resultPage(_resultQuiz)
        ],
      )),
    );
  }

  Widget _buildStartFormPage() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back_ios)),
              const Icon(
                Icons.info_outline_rounded,
                size: 30,
              )
            ],
          ),
          const SizedBox(
            height: 24,
          ),
          Text(
            "Skin Type Quiz",
            style: TextThemes.headline1
                .copyWith(fontSize: 40, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 16,
          ),
          Text("สภาพผิวหน้าเราเป็นแบบไหนกันนะ?", style: TextThemes.headline2),
          Text(
            textAlign: TextAlign.center,
            "แบบทดสอบ 7 ข้อง่าย ๆ เพื่อทำความเข้าใจผิวหน้าของคุณ",
            style: TextThemes.body,
          ),
          const SizedBox(
            height: 48,
          ),
          SvgPicture.asset("assets/illustration skintype.svg"),
          Spacer(),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    padding: EdgeInsets.symmetric(vertical: 16)),
                onPressed: () {
                  setState(() {
                    _formPageController.animateToPage(1,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeOut);
                  });
                },
                child: Text(
                  "เริ่มทำแบบทดสอบ",
                  style: TextThemes.bodyBold.copyWith(color: AppColors.white),
                )),
          )
        ],
      ),
    );
  }

  Widget _buildForm() {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Progress Bar
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "แบบทดสอบสภาพผิว",
                        style: TextThemes.bodyBold,
                      ),
                      Text(
                        "${_currentPage + 1}/7",
                        style: TextThemes.bodyBold,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  LinearProgressIndicator(
                    minHeight: 6,
                    borderRadius: BorderRadius.circular(16),
                    value: (_currentPage + 1) / 7,
                    backgroundColor: Colors.grey[300],
                    color: Colors.black,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(), // Disable swipe
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                children: _buildPages(),
              ),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (_currentPage > 0 && _currentPage < 7)
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white, elevation: 0),
                        onPressed: _previousPage,
                        child: Text(
                          'ย้อนหลัง',
                          style: TextThemes.bodyBold,
                        ),
                      ),
                    ),
                  const SizedBox(
                    width: 16,
                  ),
                  if (_currentPage < 7)
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16))),
                        onPressed: skinTypeQuiz[_currentPage] == ""
                            ? null
                            : _currentPage == 6
                                ? _sendForm
                                : _nextPage,
                        child: Text(
                          _currentPage <= 5 ? 'ต่อไป' : "ดูผลลัพธ์",
                          style: TextThemes.bodyBold
                              .copyWith(color: AppColors.white),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestionPage(String question, List<String> answer) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(question, style: TextThemes.headline1),
          const SizedBox(
            height: 32,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: answer.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      skinTypeQuiz[_currentPage] = answer[index];
                      skinAnswerCount[_currentPage] = index;
                    });
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 400),
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: skinTypeQuiz.contains(answer[index])
                            ? Colors.black
                            : const Color(0xffd0d0d0),
                        width: 1,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 16),
                    height: 80, // Set a fixed height to ensure equal heights
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment
                          .center, // Center elements vertically
                      children: [
                        Center(
                          child: Icon(
                            skinTypeQuiz.contains(answer[index])
                                ? Icons.radio_button_checked_outlined
                                : Icons.radio_button_off_outlined,
                            size: 22,
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Expanded(
                          child: Text(
                            answer[index],
                            style: TextThemes.bodyBold,
                            textAlign:
                                TextAlign.start, // Center text horizontally
                            overflow: TextOverflow.visible,
                            softWrap: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _resultPage(Map<String, dynamic> _resultQuiz) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 24),
            Text(
              "สภาพผิวหน้าของคุณคือ",
              style: TextThemes.headline2,
            ),
            const SizedBox(height: 16),
            Text(
              _resultQuiz["title"],
              style: TextThemes.body
                  .copyWith(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 24),
            Container(
              width: 240,
              height: 240,
              child: SvgPicture.asset(
                _resultQuiz["pic"],
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              _resultQuiz["des"],
              style: TextThemes.body,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: Text(
                "วิธีการดูแลผิวปกติ",
                style: TextThemes.bodyBold,
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: _resultQuiz["care"].length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "•  ",
                          style: TextStyle(fontSize: 20),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 3),
                            child: Text(
                              _resultQuiz["care"][index],
                              style: TextThemes.body,
                              softWrap: true,
                              overflow: TextOverflow.visible,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            GestureDetector(
              onTap: () {
                print(skinAnswerCount);
                Navigator.pop(context, _resultQuiz["title"]);
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 16),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  "บันทึกและกลับสู่หน้าแบบสอบถาม",
                  textAlign: TextAlign.center,
                  style: TextThemes.bodyBold.copyWith(color: AppColors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _loadPage() {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.white,
            child: Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 24,
                  ),
                  Container(
                    width: 250,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16)),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    width: 350,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16)),
                  ),
                  const SizedBox(
                    height: 48,
                  ),
                  Container(
                    width: 228,
                    height: 240,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16)),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Container(
                    height: 60,
                    width: 350,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.white),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Container(
                    width: 350,
                    height: 20,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.white),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Container(
                    width: 350,
                    height: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  void _calculateSkinType(List<int> answers) {
    int countA = 0;
    int countB = 0;
    int countC = 0;
    int countD = 0;

    for (int answer in answers) {
      if (answer == 0) {
        countA++;
      } else if (answer == 1) {
        countB++;
      } else if (answer == 2) {
        countC++;
      } else {
        countD++;
      }
    }

    if (countA > countB && countA > countC && countA > countD) {
      setState(() {
        _resultQuiz["title"] = "ผิวแห้ง";
        _resultQuiz["pic"] = "assets/skintypequiz/dry_skin.svg";
        _resultQuiz["des"] =
            "ผิวมีความแห้งกร้าน มีความยืดหยุ่นน้อย หากมีรอยแตก ริ้วรอย ร่องลึก จะสามารถมองเห็นได้ชัดเจน อาจมีอาการผิวลอก เป็นขุย และอาการคันร่วมด้วย โดยผิวชนิดนี้มีโอกาสเกิดการระคายเคืองมากกว่าผิวชนิดอื่น";
        _resultQuiz["care"] = [
          "เลือกใช้ผลิตภัณฑ์เนื้อออยล์ และเนื้อครีมเป็นหลัก",
          "เลือกใช้ผลิตภัณฑ์ที่อ่อนโยนต่อผิว ไม่ก่อให้เกิดการระคายเคือง",
          "หลีกเลี่ยงผลิตภัณฑ์ที่ส่วนผสมของแอลกอฮอล์"
        ];
      });
    } else if (countB > countA && countB > countC && countB > countD) {
      setState(() {
        _resultQuiz["title"] = "ผิวปกติ";
        _resultQuiz["pic"] = "assets/skintypequiz/normal_skin.svg";
        _resultQuiz["des"] =
            "เป็นผิวที่มีความสมดุล ไม่แห้งและไม่มันจนเกินไป มีผิวเรียบเนียน รูขุมขนเล็กละเอียด ไม่ค่อยมีปัญหาผิว";
        _resultQuiz["care"] = [
          "สามารถใช้ผลิตภัณฑ์ได้ทุกรูปแบบ ทั้งเนื้อหนัก และเนื้อบางเบา ขึ้นอยู่สภาพอากาศ",
          "หมั่นดูแลผิวหน้าอย่างสม่ำเสมอ เพื่อคงความสมดุลของผิว",
          "ทาครีมกันแดดเป็นประจำทุกวัน ป้องกันการเกิดปัญหาผิวที่มีผลมาจากแสงแดด"
        ];
      });
    } else if (countC > countA && countC > countB && countC > countD) {
      setState(() {
        _resultQuiz["title"] = "ผิวผสม";
        _resultQuiz["pic"] = "assets/skintypequiz/combination_skin.svg";
        _resultQuiz["des"] =
            "เป็นลักษณะของ ผิวมัน + ผิวแห้ง/ผิวธรรมดา บริเวณ T-Zone มีความมันวาว  รูขุมขนกว้าง เห็นได้ชัดเจน มักมีสิวขึ้นในบริเวณนี้ ส่วนบริเวณหน้าแก้มและรอบดวงตา จะมีลักษณะคล้ายผิวแห้งหรือผิวธรรมดา";
        _resultQuiz["care"] = [
          "เลือกใช้ผลิตภัณฑ์เนื้อบางเบาในรูปแบบเนื้อน้ำนม เซรั่ม และเจลตอนกลางวัน เพื่อไม่ให้เกิดความมันส่วนเกิน",
          "เลือกใช้ผลิตภัณฑ์เนื้อหนักในรูปแบบออยล์ และครีมตอนกลางคืน เพื่อบำรุงบริเวณที่ขาดความชุ่มชื้น"
        ];
      });
    } else if (countD > countA && countD > countB && countD > countC) {
      setState(() {
        _resultQuiz["title"] = "ผิวมัน";
        _resultQuiz["pic"] = "assets/skintypequiz/oily_skin.svg";
        _resultQuiz["des"] =
            "ผิวมีความเงา มันวาว สะท้อนแสงได้ทั่วทั้งใบหน้า มีรูขุมขนกว้างทั่วทั้งใบหน้า สามารถมองเห็นได้ชัดเจน โดยผิวชนิดนี้มีแนวโน้มจะเป็นสิวได้ง่ายกว่าผิวชนิดอื่น";
        _resultQuiz["care"] = [
          "เลือกใช้ผลิตภัณฑ์เนื้อบางเบา ในรูปแบบเนื้อน้ำ นม เซรั่ม และเจล",
          "เลือกใช้ผลิตภัณฑ์ที่มีส่วนช่วยในการควบคุมความมัน",
          "ทำความสะอาดผิวหน้าให้สะอาดหมดจด เพื่อลดการเกิดปัญหาสิว"
        ];
      });
    } else if (countA == countC || countB == countC) {
      setState(() {
        _resultQuiz["title"] = "ผิวผสม";
        _resultQuiz["pic"] = "assets/skintypequiz/combination_skin.svg";
        _resultQuiz["des"] =
            "เป็นลักษณะของ ผิวมัน + ผิวแห้ง/ผิวธรรมดา บริเวณ T-Zone มีความมันวาว  รูขุมขนกว้าง เห็นได้ชัดเจน มักมีสิวขึ้นในบริเวณนี้ ส่วนบริเวณหน้าแก้มและรอบดวงตา จะมีลักษณะคล้ายผิวแห้งหรือผิวธรรมดา";
        _resultQuiz["care"] = [
          "เลือกใช้ผลิตภัณฑ์เนื้อบางเบาในรูปแบบเนื้อน้ำนม เซรั่ม และเจลตอนกลางวัน เพื่อไม่ให้เกิดความมันส่วนเกิน",
          "เลือกใช้ผลิตภัณฑ์เนื้อหนักในรูปแบบออยล์ และครีมตอนกลางคืน เพื่อบำรุงบริเวณที่ขาดความชุ่มชื้น"
        ];
      });
    } else if (countA == countD || countB == countD) {
      setState(() {
        _resultQuiz["title"] = "ผิวผสม";
        _resultQuiz["pic"] = "assets/skintypequiz/combination_skin.svg";
        _resultQuiz["des"] =
            "เป็นลักษณะของ ผิวมัน + ผิวแห้ง/ผิวธรรมดา บริเวณ T-Zone มีความมันวาว  รูขุมขนกว้าง เห็นได้ชัดเจน มักมีสิวขึ้นในบริเวณนี้ ส่วนบริเวณหน้าแก้มและรอบดวงตา จะมีลักษณะคล้ายผิวแห้งหรือผิวธรรมดา";
        _resultQuiz["care"] = [
          "เลือกใช้ผลิตภัณฑ์เนื้อบางเบาในรูปแบบเนื้อน้ำนม เซรั่ม และเจลตอนกลางวัน เพื่อไม่ให้เกิดความมันส่วนเกิน",
          "เลือกใช้ผลิตภัณฑ์เนื้อหนักในรูปแบบออยล์ และครีมตอนกลางคืน เพื่อบำรุงบริเวณที่ขาดความชุ่มชื้น"
        ];
      });
    }
    print(_resultQuiz);
  }
}
