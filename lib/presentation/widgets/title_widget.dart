import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TitleWidget extends StatefulWidget {
  final String title;
  final String icon;

  const TitleWidget({super.key, required this.icon, required this.title});

  @override
  State<TitleWidget> createState() => _TitleWidgetState();
}

class _TitleWidgetState extends State<TitleWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, top: 14, bottom: 14),
      child: Row(
        children: [
          SvgPicture.asset(
            color: Colors.red,
            widget.icon,
            width: 24,
            height: 24,
          ),
          const SizedBox(width: 14),
          Text(
            widget.title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.normal,
            ),
          ),
          const Spacer(),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.expand_more,
                color: Colors.red,
              )),
          const SizedBox(width: 16),
        ],
      ),
    );
  }
}
