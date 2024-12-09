import 'package:get/get.dart';
import 'package:qms_app/common/sidebar/controller/sidebar_c.dart';
import 'package:qms_app/presentation/auth/controller/authentication_c.dart';
import 'package:qms_app/presentation/category_manage/controllers/aql_c.dart';
import 'package:qms_app/presentation/iqc/controllers/approve_inspection_c.dart';
import 'package:qms_app/presentation/iqc/controllers/iqc_report_c.dart';
import 'package:qms_app/presentation/iqc/controllers/iqc_request_c.dart';
import 'package:qms_app/presentation/category_manage/controllers/iqc_result_c.dart';
import 'package:qms_app/presentation/iqc/controllers/iqc_result_ng_c.dart';
import 'package:qms_app/presentation/controllers/material_c.dart';
import 'package:qms_app/presentation/controllers/oqc_info_c.dart';
import 'package:qms_app/presentation/controllers/oqc_result_c.dart';
import 'package:qms_app/presentation/pqc/controllers/pqc_final_result_c.dart';
import 'package:qms_app/presentation/controllers/pqc_first_problem_c.dart';
import 'package:qms_app/presentation/pqc/controllers/pqc_first_result_c.dart';
import 'package:qms_app/presentation/controllers/product_c.dart';
import 'package:qms_app/presentation/controllers/sell_order_c.dart';
import 'package:qms_app/presentation/category_manage/controllers/template_c.dart';
import 'package:qms_app/presentation/controllers/ware_house_c.dart';
import 'package:qms_app/presentation/pqc/controllers/pqc_first_info_c.dart';
import 'package:qms_app/presentation/pqc/controllers/work_order_c.dart';
import 'package:qms_app/presentation/report/controllers/report_ng_ok_c.dart';

class Binding extends Bindings {
  @override
  void dependencies() {
    Get.put(SideBarController(), permanent: true);
    Get.put(AQLController(), permanent: true);
    Get.put(IqcReportController(), permanent: true);
    Get.put(IqcRequestController(), permanent: true);
    Get.put(IqcResultNgController(), permanent: true);
    Get.put(MaterialController(), permanent: true);
    Get.put(IqcResultController(), permanent: true);
    Get.put(OqcInfoController(), permanent: true);
    Get.put(OqcResultController(), permanent: true);
    Get.put(PqcFinalResultController(), permanent: true);
    Get.put(PqcFirstInfoController(), permanent: true);
    Get.put(PqcFirstProblemController(), permanent: true);
    Get.put(PqcFirstResultController(), permanent: true);
    Get.put(ProductController(), permanent: true);
    Get.put(SellOrderController(), permanent: true);
    Get.put(TemplateController(), permanent: true);
    Get.put(WareHouseController(), permanent: true);
    Get.put(WorkOrderController(), permanent: true);
    Get.put(ReportNgOkController(), permanent: true);
    Get.put(ApproveInspectionController(), permanent: true);
    Get.put(AuthenticationController(), permanent: true);
  }
}
