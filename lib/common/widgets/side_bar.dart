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
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var appLocalizations = AppLocalizations.of(context);

    return Container(
      width: 330,
      decoration: const BoxDecoration(
        color: QMSColor.maingrey,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleWidget(
            icon: IconPath.dashboard,
            title: appLocalizations?.categoryManage.toUpperCase() ?? '',
            isSelected: selectedIndex == 0,
            onTap: () {
              selectedIndex == 0 ? selectedIndex = -1 : selectedIndex = 0;
              setState(() {});
            },
            items: [
              appLocalizations?.inspectionReportSample ?? '',
              appLocalizations?.expenseManagement ?? '',
            ],
          ),
          TitleWidget(
            icon: IconPath.dashboard,
            title: appLocalizations?.testIQC.toUpperCase() ?? '',
            isSelected: selectedIndex == 1,
            onTap: () {
              selectedIndex == 1 ? selectedIndex = -1 : selectedIndex = 1;
              setState(() {});
            },
            items: [
              appLocalizations?.approveInspectionRecords ?? '',
              appLocalizations?.listofIQCRequirements ?? ''
            ],
          ),
          TitleWidget(
            icon: IconPath.dashboard,
            title: appLocalizations?.testPQC.toUpperCase() ?? '',
            isSelected: selectedIndex == 2,
            onTap: () {
              selectedIndex == 2 ? selectedIndex = -1 : selectedIndex = 2;
              setState(() {});
            },
            items: [
              appLocalizations?.listofProductionOrders ?? '',
              appLocalizations?.checkProductQualityFirst ?? '',
              appLocalizations?.checkProductQuality ?? ''
            ],
          ),
          TitleWidget(
            icon: IconPath.dashboard,
            title: appLocalizations?.testOQC.toUpperCase() ?? '',
            isSelected: selectedIndex == 3,
            onTap: () {
              selectedIndex == 3 ? selectedIndex = -1 : selectedIndex = 3;
              setState(() {});
            },
            items: [
              appLocalizations?.checkOQC ?? '',
              appLocalizations?.approvalForWarehouseEntry ?? ''
            ],
          ),
          TitleWidget(
            icon: IconPath.dashboard,
            title: appLocalizations?.report.toUpperCase() ?? '',
            isSelected: selectedIndex == 4,
            onTap: () {
              selectedIndex == 4 ? selectedIndex = -1 : selectedIndex = 4;
              setState(() {});
            },
            items: [
              appLocalizations?.report_NG_OK_ratio ?? '',
              appLocalizations?.order_completion_rate_report ?? '',
              appLocalizations?.production_order_completion_rate_report ?? '',
            ],
          ),
        ],
      ),
    );
  }
}
