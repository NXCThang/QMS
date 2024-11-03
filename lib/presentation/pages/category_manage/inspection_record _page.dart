import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:qms_app/common/color.dart';
import 'package:qms_app/common/icon_path.dart';
import 'package:qms_app/common/sidebar/controller/sidebar_c.dart';
import 'package:qms_app/common/sidebar/widgets/side_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:qms_app/presentation/pages/category_manage/expense_page.dart';
import 'package:qms_app/presentation/pages/dashboard/dashboard_page.dart';
import 'package:qms_app/presentation/pages/iqc/approve_inspection_records.dart';
import 'package:qms_app/presentation/pages/iqc/list_iqc.dart';
import 'package:qms_app/presentation/pages/oqc/approval_stock.dart';
import 'package:qms_app/presentation/pages/oqc/check_oqc.dart';
import 'package:qms_app/presentation/pages/pqc/check_quality.dart';
import 'package:qms_app/presentation/pages/pqc/check_quality_first.dart';
import 'package:qms_app/presentation/pages/pqc/list_product_order.dart';
import 'package:qms_app/presentation/pages/report/order_completion_rate_report.dart';
import 'package:qms_app/presentation/pages/report/production_complete_rate_report.dart';
import 'package:qms_app/presentation/pages/report/rate_product_quantity.dart';
import 'package:qms_app/presentation/widgets/add_error.dart';
import 'package:qms_app/presentation/widgets/table_custom.dart';

class MinutesPage extends StatefulWidget {
  const MinutesPage({super.key});

  @override
  State<MinutesPage> createState() => _MinutesPageState();
}

class _MinutesPageState extends State<MinutesPage> {
  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    return SafeArea(
        child: Scaffold(
            appBar: _appbar(context),
            body: Row(
              children: [const SideBarWidget(), Expanded(child: MainPage())],
            )));
  }
}

class MainPage extends StatelessWidget {
  MainPage({super.key});
  var sidebarController = Get.find<SideBarController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      switch (sidebarController.currentPage.value) {
        case SideBarOption.inspectionReportSample:
          return InspectionRecordPage();
        case SideBarOption.expenseManagement:
          return ExpensePage();
        case SideBarOption.approveInspectionRecords:
          return ApproveInspectionRecords();
        case SideBarOption.listofIQCRequirements:
          return ListIQC();
        case SideBarOption.approvalForWarehouseEntry:
          return ApprovalStock();
        case SideBarOption.checkOQC:
          return CheckOQC();
        case SideBarOption.checkProductQualityFirst:
          return CheckQualityFirst();
        case SideBarOption.checkProductQuality:
          return CheckQuality();
        case SideBarOption.listofProductionOrders:
          return ListProductOrder();
        case SideBarOption.reportNGOKRatio:
          return const RateProductQuantity();
        case SideBarOption.orderCompletionRateReport:
          return const OrderCompletionRateReport();
        case SideBarOption.productionOrderCompletionRateReport:
          return const ProductionCompleteRateReport();
        default:
          return DashboardPages();
      }
    });
  }
}

class InspectionRecordPage extends StatelessWidget {
  const InspectionRecordPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black.withOpacity(0.1), width: 1),
      ),
      margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              appLocalizations?.inspectionReportSample ?? '',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24),
            )
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextFieldCustom(
              label: appLocalizations?.minutesTemplateName ?? '',
              width: 300,
              hintText: appLocalizations?.minutesTemplateName ?? '',
            ),
            TextFieldCustom(
              label: appLocalizations?.minutesTemplateType ?? '',
              width: 300,
            ),
            TextFieldCustom(
              label: appLocalizations?.minutesTemplateCode ?? '',
              width: 300,
              hintText: appLocalizations?.minutesTemplateCode ?? '',
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Danh sách yêu cầu IQC(10)',
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
            ),
            const Spacer(),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.all(0),
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (_) => const AddError(
                              error: 'Thêm mới',
                            ));
                  },
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        IconPath.addNew,
                        width: 18,
                        height: 18,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      const Text(
                        'Thêm mới',
                        style: TextStyle(
                            color: QMSColor.mainorange,
                            fontSize: 18,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 0,
        ),
        const TableCustom(
          title: {
            'Tên mẫu biên bản': 4,
            'Mã biên bản': 2,
            'Trạng thái': 2,
            'Loại biên bản': 2,
            'Ngày tạo': 2,
            'Tùy chọn': 2
          },
        ),
      ]),
    );
  }
}

@override
PreferredSizeWidget _appbar(BuildContext context) {
  return AppBar(
    backgroundColor: QMSColor.blueheader,
    title: Row(
      children: [
        SizedBox(
          width: 330,
          child: GestureDetector(onTap: () {}, child: const Text('Facenet')),
        ),
        SvgPicture.asset(
          IconPath.menu,
          width: 22,
          height: 18,
        ),
        const SizedBox(width: 19),
        const Text(
          'Quality Management System',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        )
      ],
    ),
    actions: [
      const Icon(
        Icons.person_pin,
        weight: 40,
      ),
      const SizedBox(
        width: 7,
      ),
      const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Xin chào',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w400),
            ),
            Text(
              'Lô Quỳnh Như',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 16),
            )
          ]),
      const SizedBox(width: 24),
      GestureDetector(
          onTap: () {},
          child: SvgPicture.asset(
            IconPath.fullscreen,
            width: 24,
            height: 24,
          )),
      const SizedBox(
        width: 24,
      ),
      GestureDetector(
          onTap: () {},
          child: SvgPicture.asset(
            IconPath.notification,
            width: 24,
            height: 24,
          )),
      const SizedBox(
        width: 24,
      ),
      GestureDetector(
          onTap: () {},
          child: SvgPicture.asset(
            IconPath.logout,
            width: 24,
            height: 24,
          )),
      const SizedBox(
        width: 40,
      )
    ],
  );
}

class ItemSearch extends StatelessWidget {
  const ItemSearch({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Image.asset(
              IconPath.search,
              width: 16,
              height: 16,
              fit: BoxFit.scaleDown,
            ),
          ),
        ],
      ),
    );
  }
}
