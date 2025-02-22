import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project/core/config/theme/app_theme.dart';
import 'package:project/features/profile/presentation/pages/profile_page.dart';
import 'package:project/features/home/presentation/home_page.dart';
import 'package:project/service_locator.dart';
import 'package:project/features/favorite/presentation/pages/favorite_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:project/features/favorite/presentation/bloc/favorite_bloc.dart';
import 'package:project/features/profile/presentation/widgets/skin_type_tag.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  //ให้มองเห็นนาฬิกาเพราะ appbar มันสีขาว
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.light,
  ));

  setupServiceLocator();
  runApp(
    ChangeNotifierProvider(
      create: (context) => FavoriteProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Skin',
      theme: AppTheme.appTheme,
      home: ProfilePage(),
    );
  }
}
