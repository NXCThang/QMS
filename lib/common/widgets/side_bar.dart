import 'package:flutter/material.dart';
import 'package:qms_app/common/color.dart';
import 'package:qms_app/common/icon_path.dart';
import 'package:qms_app/presentation/widgets/title_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SideBarWidget extends StatefulWidget {
  const SideBarWidget({super.key});

  @override
  _SideBarWidgetState createState() => _SideBarWidgetState();
}

class _SideBarWidgetState extends State<SideBarWidget> {
  int selectedIndex = 0; // Track the index of the selected widget

  @override
  Widget build(BuildContext context) {
    var appLocalizations = AppLocalizations.of(context);

    return Container(
      width: 330,
      decoration: const BoxDecoration(
        color: QMSColor.main_grey,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleWidget(
            icon: IconPath.dashboard,
            title: appLocalizations?.categoryManage.toUpperCase() ?? '',
            isSelected: selectedIndex == 0, // Check if this widget is selected
            onTap: () {
              setState(() {
                selectedIndex = 0; // Set selected index
              });
            },
            items: ['Danh mục lỗi/ nhóm lỗi'],
          ),
          TitleWidget(
            icon: IconPath.dashboard,
            title: appLocalizations?.testIQC.toUpperCase() ?? '',
            isSelected: selectedIndex == 1,
            onTap: () {
              setState(() {
                selectedIndex = 1;
              });
            },
            items: [],
          ),
          TitleWidget(
            icon: IconPath.dashboard,
            title: appLocalizations?.testPQC.toUpperCase() ?? '',
            isSelected: selectedIndex == 2,
            onTap: () {
              setState(() {
                selectedIndex = 2;
              });
            },
            items: [],
          ),
          TitleWidget(
            icon: IconPath.dashboard,
            title: appLocalizations?.testOQC.toUpperCase() ?? '',
            isSelected: selectedIndex == 3,
            onTap: () {
              setState(() {
                selectedIndex = 3;
              });
            },
            items: [],
          ),
          TitleWidget(
            icon: IconPath.dashboard,
            title: appLocalizations?.report.toUpperCase() ?? '',
            isSelected: selectedIndex == 4,
            onTap: () {
              setState(() {
                selectedIndex = 4;
              });
            },
            items: [],
          ),
        ],
      ),
    );
  }
}
