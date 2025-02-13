import 'package:flutter/material.dart';
import 'package:project/core/common/helper/navigation/app_navigation.dart';
import 'package:project/features/search/presentation/pages/search_page.dart';

class SearchTextfield extends StatefulWidget {
  const SearchTextfield({super.key});

  @override
  State<SearchTextfield> createState() => _SearchTextfieldState();
}

class _SearchTextfieldState extends State<SearchTextfield> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      onTap: () {
        AppNavigator.push(context, SearchPage());
      },
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search),
          hintText: 'ค้นหาชื่อผลิตภัณฑ์, ยี่ห้อ, ส่วนประกอบ',
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(1000),
            borderSide: const BorderSide(color: Color(0xffE1D7CE)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(1000),
            borderSide: const BorderSide(color: Color(0xffE1D7CE)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(1000),
            borderSide: const BorderSide(color: Color(0xffE1D7CE), width: 2),
          )),
    );
  }
}
