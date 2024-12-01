import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final Color? borderColor;
  final VoidCallback onPressed;

  const CustomButton(
      {super.key,
      required this.text,
      required this.textColor,
      required this.borderColor,
      required this.onPressed,
      required this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 42,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(4),
        border: borderColor != null
            ? Border.all(color: borderColor!, width: 1)
            : null,
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
            height: 35 / 18,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
