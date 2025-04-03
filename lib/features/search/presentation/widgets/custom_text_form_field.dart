import 'package:flutter/material.dart';
import 'package:project/core/config/theme/app_color.dart';
import 'package:project/core/config/theme/app_theme.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final void Function(String) fn;
  final void Function(String) onChange;
  final FocusNode? focusNode;
  final Function() ondelete;
  const CustomTextFormField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.fn,
      required this.ondelete,
      required this.onChange,
      this.focusNode});

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.controller.addListener(_onTextChange);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    widget.controller.dispose();
    super.dispose();
  }

  void _onTextChange() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: AppColors.black,
      onFieldSubmitted: (value) {
        widget.fn(value);
      },
      onChanged: (value) {
        print(value);
        if (value.isNotEmpty) {
          widget.onChange(value);
        }
      },
      focusNode: widget.focusNode,
      cursorWidth: 1,
      controller: widget.controller,
      onTapOutside: (event) {
        widget.focusNode?.unfocus();
      },
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 8),
        prefixIcon: const Padding(
          padding: EdgeInsets.only(left: 12, right: 5),
          child: Icon(
            Icons.search_rounded,
            color: AppColors.black,
          ),
        ),
        prefixIconConstraints: const BoxConstraints(
          minWidth: 0,
          minHeight: 0,
        ),
        suffixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
        suffixIcon: widget.controller.text.isNotEmpty
            ? GestureDetector(
                onTap: () {
                  widget.controller.clear();
                  widget.ondelete();
                },
                child: const Padding(
                  padding: EdgeInsets.only(right: 12),
                  child: Icon(Icons.clear),
                ),
              )
            : null,
        isDense: true,
        hintText: widget.hintText,
        hintStyle: TextThemes.body.copyWith(color: AppColors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(1000),
          borderSide: BorderSide.none, // No visible border by default
        ),
        // Border when enabled (but not focused)
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(1000),
          borderSide: const BorderSide(
            color: AppColors.beige, // Optional visible border color
            width: 1,
          ),
        ),
        // Border when focused
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(1000),
          borderSide: const BorderSide(
            color: AppColors.beige, // Customize focus color
            width: 2,
          ),
        ),
        // Border when disabled
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(1000),
          borderSide: BorderSide(
            color: Colors.grey.shade200, // Optional disabled border color
            width: 1,
          ),
        ),
      ),
    );
  }
}
