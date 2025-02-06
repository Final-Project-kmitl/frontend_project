import 'package:flutter/material.dart';
import 'package:project/features/routine/presentation/widgets/rontine_app_bar.dart';

class EmptyAllPage extends StatelessWidget {
  const EmptyAllPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RoutineAppBar(
        isEmpty: true,
      ),
      body: Container(),
    );
  }
}
