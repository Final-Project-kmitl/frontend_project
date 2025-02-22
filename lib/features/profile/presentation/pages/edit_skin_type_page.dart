import 'package:flutter/material.dart';

class EditSkinTypePage extends StatelessWidget {
  const EditSkinTypePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('หน้าแก้ skin type'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // กลับไปหน้าก่อนหน้า
          },
        ),
      ),
    );
  }
}
