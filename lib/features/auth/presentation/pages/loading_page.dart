import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:project/core/common/helper/navigation/app_navigation.dart';
import 'package:project/core/config/theme/app_theme.dart';
import 'package:project/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:project/features/home/presentation/pages/home_page.dart';
import 'package:uuid/uuid.dart';

class LoadingPage extends StatefulWidget {
  final String skinType;
  final List<int> allergicListId;
  final List<int> benefitListId;
  const LoadingPage(
      {super.key,
      required this.skinType,
      required this.allergicListId,
      required this.benefitListId});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  int generateUserId() {
    var uuid = Uuid();
    final userId = uuid.hashCode.abs();
    return userId;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<AuthBloc>().add(SendingDataToBackend(
        userId: generateUserId(),
        skinType: widget.skinType,
        allergicListId: widget.allergicListId,
        benefitListId: widget.benefitListId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          print("STATE : ${state}");
          if (state is AuthSuccess) {
            print("SUCCESS : ${state}");
            WidgetsBinding.instance.addPostFrameCallback(
                (_) => AppNavigator.pushAndRemove(context, HomePage()));
          }
          return Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Image.asset(
                      "assets/loadingPage/Skincare img.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                  Text(
                    "เราจะทำให้การเลือกซื้อสกินแคร์ของคุณง่ายขึ้น",
                    textAlign: TextAlign.center,
                    style: TextThemes.headline2.copyWith(
                      fontSize: 36,
                    ),
                  ),
                  SizedBox(
                    height: 100,
                  )
                ],
              ),
              Positioned(
                bottom: -30, // ปรับให้ห่างจากขอบล่าง
                left: 0,
                right: 0,
                child: Center(
                  child: SizedBox(
                    width: 200,
                    height: 200,
                    child: SvgPicture.asset(
                      "assets/loadingPage/Dot.svg",
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              SafeArea(
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: SvgPicture.asset(
                      'assets/Logo.svg',
                      width: 64,
                    ),
                  ),
                ),
              ),
              SafeArea(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: SvgPicture.asset(
                      'assets/loadingPage/Heartstar.svg',
                      width: 130,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
