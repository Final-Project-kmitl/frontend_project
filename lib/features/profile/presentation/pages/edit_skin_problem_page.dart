import 'package:flutter/material.dart';

class EditSkinProblemPage extends StatelessWidget {
  const EditSkinProblemPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('หน้าแก้ skin problem'),
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
