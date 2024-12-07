import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class TextFieldCustom extends StatelessWidget {
  TextFieldCustom({
    super.key,
    required this.label,
    this.width = 560,
    this.hintText = '',
    required this.textcontroller,
    this.isNumber = false,
    this.enabled = true,
  });
  final String label;
  final double width;
  final String hintText;
  final TextEditingController textcontroller;
  bool? isNumber;
  bool? enabled;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: Colors.black.withOpacity(0.7),
              ),
            ),
          ],
        ),
        SizedBox(
          width: width,
          child: TextField(
            keyboardType:
                isNumber == true ? TextInputType.number : TextInputType.text,
            inputFormatters: [
              if (isNumber == true) FilteringTextInputFormatter.digitsOnly,
            ],
            controller: textcontroller,
            decoration: InputDecoration(
              enabled: enabled ?? true,
              isDense: true,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
              hintText: hintText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4.0),
                borderSide: BorderSide(
                  color: Colors.black.withOpacity(0.2),
                  width: 1.0,
                ),
              ),
            ),
          ),
        ),
      ],
    ).paddingOnly(right: 20);
  }
}
