import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TitleWidget extends StatefulWidget {
  final String title;

  const TitleWidget({super.key, required this.title});

  @override
  State<TitleWidget> createState() => _TitleWidgetState();
}

class _TitleWidgetState extends State<TitleWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          color: Colors.red,
          'assets/icons/dashboard.svg',
          width: 20,
          height: 20,
        ),
        Text(
          widget.title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.normal,
          ),
        ),
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.expand_more,
              color: Colors.red,
            ))
      ],
    );
  }
}
