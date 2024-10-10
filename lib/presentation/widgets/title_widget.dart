import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qms_app/common/color.dart';

class TitleWidget extends StatelessWidget {
  final String title;
  final String icon;
  final bool isSelected;
  final VoidCallback onTap;
  final List<String> items;

  const TitleWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.isSelected,
    required this.onTap,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, top: 14, bottom: 14, right: 12),
      child: Column(
        children: [
          Row(
            children: [
              SvgPicture.asset(
                icon,
                width: 24,
                height: 24,
                color: isSelected ? QMSColor.main_orange : Colors.black,
              ),
              const SizedBox(width: 14),
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                  color: isSelected ? QMSColor.main_orange : Colors.black,
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: onTap,
                icon: Icon(
                  isSelected ? Icons.expand_less : Icons.expand_more,
                  color: isSelected ? QMSColor.main_orange : Colors.black,
                ),
              ),
              const SizedBox(width: 16),
            ],
          ),
          Divider(
            color: isSelected ? QMSColor.main_orange : Colors.transparent,
            thickness: 1,
          ),
          Container(
            padding: const EdgeInsets.only(top: 8.0),
            height: items.length * 40.0, // Chiều cao dựa trên số lượng item
            child: ListView.builder(
              physics:
                  const NeverScrollableScrollPhysics(), // Ngăn không cho cuộn
              itemCount: items.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Text(
                    items[index],
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
