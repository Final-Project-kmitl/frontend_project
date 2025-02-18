import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:project/core/common/helper/navigation/app_navigation.dart';
import 'package:project/core/config/assets/svg_assets.dart';
import 'package:project/core/config/theme/app_color.dart';
import 'package:project/core/config/theme/app_theme.dart';
import 'package:project/features/home/presentation/pages/home_page.dart';
import 'package:project/features/routine/presentation/pages/routine_page.dart';
import 'package:project/features/splash/presentation/bloc/splash_bloc.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    // TODO: implement initState
    // sl<SplashBloc>();

    context.read<SplashBloc>().add(CheckUserEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      body: BlocListener<SplashBloc, SplashState>(
          listener: (context, state) {
            if (state is SplashSuccess) {
              return AppNavigator.pushAndRemove(context, HomePage());
            } else if (state is SplashFailure) {
              print(state.message);
              return AppNavigator.pushAndRemove(context, HomePage());
            }
          },
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: SvgPicture.asset(SvgAssets.logoPath),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 32),
                child: Column(
                  children: [
                    Text(
                      "Sourced by",
                      style: TextThemes.descBold
                          .copyWith(color: AppColors.darkGrey),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/f306.png")

                        // SizedBox(
                        //   width: 40,
                        //   child: SvgPicture.asset(SvgAssets.source2),
                        // ),
                        // SizedBox(
                        //   width: 40,
                        //   child: SvgPicture.asset(SvgAssets.source3),
                        // ),
                        // SizedBox(
                        //   width: 40,
                        //   child: SvgPicture.asset(SvgAssets.navigatorFav),
                        // ),
                        // SizedBox(
                        //   width: 40,
                        //   child: SvgPicture.asset(SvgAssets.logoPath),
                        // ),
                        // SizedBox(
                        //     width: 40,
                        //     child: SvgPicture.asset(SvgAssets.source_by_3)),
                        // SizedBox(
                        //     width: 40,
                        //     child: SvgPicture.asset(SvgAssets.source_by_4)),
                      ],
                    )
                  ],
                ),
              )
            ],
          )),
    );
  }
}
