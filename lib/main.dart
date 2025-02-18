import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/core/config/theme/app_theme.dart';
import 'package:project/features/favorite/presentation/bloc/favorite_bloc.dart';
import 'package:project/features/home/presentation/pages/home_page.dart';
import 'package:project/features/routine/presentation/bloc/routine_bloc.dart';
import 'package:project/features/splash/presentation/bloc/splash_bloc.dart';
import 'package:project/features/splash/presentation/pages/splash_page.dart';
import 'package:project/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //ให้มองเห็นนาฬิกาเพราะ appbar มันสีขาว
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.light,
  ));

  await setupServiceLocator();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<RoutineBloc>(
        create: (context) => sl<RoutineBloc>(),
      ),
      BlocProvider<FavoriteBloc>(
        create: (context) => sl<FavoriteBloc>(),
      ),
      BlocProvider<SplashBloc>(
        create: (context) => sl<SplashBloc>(),
      )
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Skin',
      theme: AppTheme.appTheme,
      home: const SplashPage(),
    );
  }
}
