import 'package:flutter/material.dart';
//import 'package:insta_clone/utils/colors.dart';

class TextInputField extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool isPass;
  final String hintText;
  final TextInputType textInputType;

  const TextInputField({
    super.key,
    required this.textEditingController,
    required this.isPass,
    required this.hintText,
    required this.textInputType,
  });

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderSide: Divider.createBorderSide(context),
    );

    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle:
              const TextStyle(color: Colors.black), // Set hint text color
          border: inputBorder,
          focusedBorder: inputBorder,
          enabledBorder: inputBorder,
          filled: true,
          contentPadding: const EdgeInsets.all(8),
          fillColor: Colors.white),
      style: const TextStyle(color: Colors.black), // Set input text color
      keyboardType: textInputType,
      obscureText: isPass,
    );
  }
}
