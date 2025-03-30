import 'package:flutter/material.dart';

class SimilarProduct extends StatefulWidget {
  const SimilarProduct({super.key});

  @override
  State<SimilarProduct> createState() => _SimilarProductState();
}

class _SimilarProductState extends State<SimilarProduct> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
          padding: EdgeInsets.only(left: 20),
          child: Text("ผลิตภัณฑ์ที่คล้ายกัน")),
      SizedBox(
        height: 210,
        child: ListView.builder(itemBuilder: (context, index) {
          return Container();
        }),
      )
    ]);
  }
}
