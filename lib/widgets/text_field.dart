import 'package:bst_visualizer/consts/my_colors.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  TextEditingController controller;
  CustomTextField({required this.controller});
  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: MyColors.primary,
      controller: controller,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: MyColors.primary, width: 2.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: MyColors.primary, width: 2.0),
        ),
      ),
    );
  }
}
