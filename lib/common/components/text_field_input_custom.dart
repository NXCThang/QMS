import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldInputCustom extends StatelessWidget {
  final TextEditingController controller;
  final Function(String)? onChanged;
  bool? enable;
  final String hintText;
  bool? isNumber;

  TextFieldInputCustom({
    Key? key,
    required this.controller,
    this.onChanged,
    this.hintText = '',
    this.enable = true,
    this.isNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType:
          isNumber == true ? TextInputType.number : TextInputType.text,
      inputFormatters: [
        if (isNumber == true) FilteringTextInputFormatter.digitsOnly,
      ],
      controller: controller,
      maxLines: 2,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        border: InputBorder.none, // Xóa underline
        hintText: hintText,
      ),
      enabled: enable,
      onChanged: onChanged,
    );
  }
}
