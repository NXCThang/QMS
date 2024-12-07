import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qms_app/common/sidebar/controller/sidebar_c.dart';
import 'package:qms_app/models/iqc_report.dart';
import 'package:qms_app/models/work_order.dart';
import 'package:qms_app/presentation/category_manage/pages/aql.dart';
import 'package:qms_app/presentation/category_manage/pages/template.dart';
import 'package:qms_app/presentation/category_manage/widgets/iqc_result_list.dart';
import 'package:qms_app/presentation/category_manage/widgets/material_list.dart';
import 'package:qms_app/presentation/databoard/pages/dashboard_page.dart';
import 'package:qms_app/presentation/iqc/pages/approve_inspection_records.dart';
import 'package:qms_app/presentation/iqc/pages/iqc_request.dart';
import 'package:qms_app/presentation/iqc/widgets/material_report_list.dart';
import 'package:qms_app/presentation/oqc/approval_stock.dart';
import 'package:qms_app/presentation/oqc/check_oqc.dart';
import 'package:qms_app/presentation/pqc/pages/check_quality.dart';
import 'package:qms_app/presentation/pqc/pages/check_quality_first.dart';
import 'package:qms_app/presentation/pqc/pages/list_product_order.dart';
import 'package:qms_app/presentation/pqc/widgets/product_order_detail.dart';
import 'package:qms_app/presentation/report/pages/order_completion_rate_report.dart';
import 'package:qms_app/presentation/report/pages/production_complete_rate_report.dart';
import 'package:qms_app/presentation/report/pages/rate_product_quantity.dart';

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
        case SideBarOption.iqcResult:
          return IqcResultList();
        case SideBarOption.detailProductionOrder:
          final arguments = sidebarController.arguments ?? {};

          // Get the WorkOrderModel Map from arguments
          final workOrderModelJson = arguments['WorkOrderModel'];

          // Convert Map<String, dynamic> to WorkOrderModel
          final workOrderModel = workOrderModelJson != null
              ? WorkOrderModel.fromJson(
                  Map<String, dynamic>.from(workOrderModelJson)) // Deserialize
              : WorkOrderModel(); // Fallback to a default WorkOrderModel if null

          // Return the ProductOrderDetail widget with the deserialized model
          return ProductOrderDetail(workOrderModel: workOrderModel);

        case SideBarOption.materialReport:
          final arguments = sidebarController.arguments ?? {};
          final iqcReportModelJson = arguments['IqcReportModel'];

          // Convert the map back to IQCReportModel using fromJson
          final iqcReportModel = iqcReportModelJson != null
              ? IQCReportModel.fromJson(
                  Map<String, dynamic>.from(iqcReportModelJson))
              : IQCReportModel(); // Provide a default value if the argument is null

          return MaterialReportList(
            iqcReportModel: iqcReportModel,
          );
        default:
          return DashboardPages();
        // return DashboardPages();
      }
    });
  }
}
