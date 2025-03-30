import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/core/config/theme/app_theme.dart';
import 'package:project/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:project/features/auth/presentation/pages/form_page.dart';
import 'package:project/features/camera/presentation/bloc/camera_bloc.dart';
import 'package:project/features/favorite/presentation/bloc/favorite_bloc.dart';
import 'package:project/features/home/presentation/bloc/home_bloc.dart';
import 'package:project/features/home/presentation/pages/home_page.dart';
import 'package:project/features/product/presentation/bloc/product_bloc.dart';
import 'package:project/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:project/features/profile/presentation/pages/profile_page.dart';
import 'package:project/features/routine/presentation/bloc/routine_bloc.dart';
import 'package:project/features/routine/presentation/pages/routine_page.dart';
import 'package:project/features/search/presentation/bloc/search_bloc.dart';
import 'package:project/features/search/presentation/pages/search_page.dart';
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
      ),
      BlocProvider<HomeBloc>(
        create: (context) => sl<HomeBloc>(),
      ),
      BlocProvider<ProductBloc>(
        create: (context) => sl<ProductBloc>(),
      ),
      BlocProvider<ProfileBloc>(
        create: (context) => sl<ProfileBloc>(),
      ),
      BlocProvider(
        create: (context) => sl<SearchBloc>(),
      ),
      BlocProvider(
        create: (context) => sl<AuthBloc>(),
      ),
      BlocProvider(
        create: (context) => sl<CameraBloc>(),
      ),
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
