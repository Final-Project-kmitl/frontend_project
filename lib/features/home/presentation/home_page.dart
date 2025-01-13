import 'package:flutter/material.dart';
import 'package:project/core/config/theme/app_color.dart';
import 'package:project/core/config/theme/app_theme.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(
                  hintText: "Email", hintStyle: TextStyle(fontSize: 18)),
            ),
            ElevatedButton(
                onPressed: () {},
                child: Text("data", style: TextThemes.bodyBold),
                style: ButtonThemes.backwardButton)
          ],
        ),
      ),
    );
  }
}
