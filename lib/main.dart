import 'package:flutter/material.dart';
import 'package:project/core/config/theme/app_theme.dart';
import 'package:project/features/home/presentation/home_page.dart';
import 'package:project/service_locator.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  setupServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Skin',
      theme: AppTheme.appTheme,
      home: const HomePage(),
    );
  }
}
