import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:qms_app/common/color.dart';
import 'package:qms_app/common/sidebar/controller/sidebar_c.dart';

class TitleWidget extends StatefulWidget {
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
  State<TitleWidget> createState() => _TitleWidgetState();
}

class _TitleWidgetState extends State<TitleWidget> {
  int selectedIndex = 0;
  var controller = Get.find<SideBarController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, top: 14, bottom: 14, right: 12),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              (widget.items.isNotEmpty)
                  ? controller.changePage(widget.items[0])
                  : controller.changePage(widget.title);
              widget.onTap();
            },
            child: Row(
              children: [
                SvgPicture.asset(
                  widget.icon,
                  width: 24,
                  height: 24,
                  color: widget.isSelected ? QMSColor.mainorange : Colors.black,
                ),
                const SizedBox(width: 14),
                Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color:
                        widget.isSelected ? QMSColor.mainorange : Colors.black,
                  ),
                ),
                const Spacer(),
                Icon(
                  widget.isSelected ? Icons.expand_less : Icons.expand_more,
                  color: widget.isSelected ? QMSColor.mainorange : Colors.black,
                ),
                const SizedBox(width: 16),
              ],
            ),
          ),
          Divider(
            color: widget.isSelected ? QMSColor.mainorange : Colors.transparent,
            thickness: 1,
          ),
          Visibility(
            visible: widget.isSelected,
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.items.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                  child: GestureDetector(
                    onTap: () {
                      controller.changePage(widget.items[index]);
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    behavior: HitTestBehavior.translucent,
                    child: Container(
                      decoration: BoxDecoration(
                          color: selectedIndex == index
                              ? QMSColor.mainorange
                              : Colors.transparent,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10))),
                      padding:
                          const EdgeInsets.only(left: 38, top: 10, bottom: 10),
                      child: Text(
                        widget.items[index],
                        style: TextStyle(
                          color: selectedIndex == index
                              ? Colors.white
                              : Colors.black,
                          fontSize: 16,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
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
