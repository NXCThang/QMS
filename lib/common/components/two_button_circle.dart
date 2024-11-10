import 'package:flutter/material.dart';

class CustomButtonCircleRow extends StatelessWidget {
  final VoidCallback? onApprove;
  final VoidCallback? onReject;

  const CustomButtonCircleRow({
    Key? key,
    this.onApprove,
    this.onReject,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(Icons.check_circle_outline, color: Colors.blue),
          onPressed: onApprove,
        ),
        IconButton(
          icon: Icon(Icons.cancel_outlined, color: Colors.blue),
          onPressed: onReject,
        ),
      ],
    );
  }
}
