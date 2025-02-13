import 'package:flutter/material.dart';
import 'package:project/core/config/theme/app_color.dart';
import 'package:project/features/search/presentation/widgets/custom_text_form_field.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

void printSubmit(String value) {
  print(value);
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _textEditingController = TextEditingController();
  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose

    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 0),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _textEditingController.clear();
                    },
                    icon: Icon(
                      Icons.arrow_back_ios_new_outlined,
                      color: AppColors.black,
                    ),
                  ),
                  Expanded(
                    child: CustomTextFormField(
                      controller: _textEditingController,
                      hintText: "ค้นหาชื่อผลิตภัณฑ์, ยี่ห้อ",
                      fn: printSubmit,
                      focusNode: _focusNode,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.tune_outlined,
                      color: AppColors.black,
                    ),
                    onPressed: () {},
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 200,
                itemBuilder: (context, index) {
                  return Text("${index}");
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
