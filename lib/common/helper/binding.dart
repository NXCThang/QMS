import 'package:get/get.dart';
import 'package:qms_app/common/sidebar/controller/sidebar_c.dart';
import 'package:qms_app/presentation/category_manage/controllers/aql_c.dart';
import 'package:qms_app/presentation/iqc/controllers/approve_inspection_c.dart';
import 'package:qms_app/presentation/iqc/controllers/iqc_report_c.dart';
import 'package:qms_app/presentation/iqc/controllers/iqc_request_c.dart';
import 'package:qms_app/presentation/category_manage/controllers/iqc_result_c.dart';
import 'package:qms_app/presentation/iqc/controllers/iqc_result_ng_c.dart';
import 'package:qms_app/presentation/controllers/material_c.dart';
import 'package:qms_app/presentation/controllers/oqc_info_c.dart';
import 'package:qms_app/presentation/controllers/oqc_result_c.dart';
import 'package:qms_app/presentation/controllers/pqc_final_result_c.dart';
import 'package:qms_app/presentation/controllers/pqc_first_info_c.dart';
import 'package:qms_app/presentation/controllers/pqc_first_problem_c.dart';
import 'package:qms_app/presentation/controllers/pqc_first_result_c.dart';
import 'package:qms_app/presentation/controllers/product_c.dart';
import 'package:qms_app/presentation/controllers/sell_order_c.dart';
import 'package:qms_app/presentation/category_manage/controllers/template_c.dart';
import 'package:qms_app/presentation/controllers/ware_house_c.dart';
import 'package:qms_app/presentation/pqc/controllers/work_order_c.dart';
import 'package:qms_app/presentation/report/controllers/report_ng_ok_c.dart';

class Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SideBarController());
    Get.lazyPut(() => AQLController());
    Get.lazyPut(() => IqcReportController());
    Get.lazyPut(() => IqcRequestController());
    Get.lazyPut(() => IqcResultController());
    Get.lazyPut(() => IqcResultNgController());
    Get.lazyPut(() => MaterialController());
    Get.lazyPut(() => OqcInfoController());
    Get.lazyPut(() => OqcResultController());
    Get.lazyPut(() => PqcFinalResultController());
    Get.lazyPut(() => PqcFirstInfoController());
    Get.lazyPut(() => PqcFirstProblemController());
    Get.lazyPut(() => PqcFirstResultController());
    Get.lazyPut(() => ProductController());
    Get.lazyPut(() => SellOrderController());
    Get.lazyPut(() => TemplateController());
    Get.lazyPut(() => WareHouseController());
    Get.lazyPut(() => WorkOrderController());
    Get.lazyPut(() => ReportNgOkController());
    Get.lazyPut(() => ApproveInspectionController());
  }
}
