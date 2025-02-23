import 'package:flutter/material.dart';

class EditSkinAllergiesPage extends StatelessWidget {
  const EditSkinAllergiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('หน้าแก้ skin allergies'),
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
