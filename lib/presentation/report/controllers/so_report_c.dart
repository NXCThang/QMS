import 'package:get/get.dart';
import 'package:qms_app/common/components/paginated_c.dart';
import 'package:qms_app/models/oqc_info.dart';
import 'package:qms_app/models/oqc_result.dart';
import 'package:qms_app/presentation/oqc/controllers/oqc_info_c.dart';
import 'package:qms_app/presentation/oqc/controllers/oqc_result_c.dart';
import 'package:qms_app/presentation/pqc/controllers/work_order_c.dart';
import 'package:qms_app/presentation/report/model/so_report.dart';

class SOReportController extends GetxController {
  final isLoading = true.obs;
  final workOrderController = Get.find<WorkOrderController>();
  final oqcInfoController = Get.find<OqcInfoController>();
  final oqcResultController = Get.find<OqcResultController>();
  final PaginatedController<SoReportModel> paginatedController =
      PaginatedController<SoReportModel>();

  RxList<SoReportModel> reportList = <SoReportModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadLists();
  }

  Future<void> loadLists() async {
    await workOrderController.getWorkOrderList();
    await oqcInfoController.getOqcInfoList();
    await oqcResultController.getOqcResultList();
    print(workOrderController.workorderList.length);
    print(oqcInfoController.oqcInfoList.length);
    print(oqcResultController.oqcResultList.length);
    initSOReportList();
  }

  Future<void> initSOReportList() async {
    List<SoReportModel> tempList = [];
    try {
      isLoading.value = true;
      for (var workOrder in workOrderController.workorderList) {
        int planQuantity = 0;
        int totalQuantity = 0;
        for (OQCInfoModel info in workOrder.oqcInfos ?? []) {
          planQuantity += info.quantity ?? 0;
          for (OQCResultModel result in info.oqcResults ?? []) {
            totalQuantity += result.totalQuantity ?? 0;
          }
        }
        tempList.add(SoReportModel(
            workOrderModel: workOrder,
            planQquantity: planQuantity,
            totalQuantity: totalQuantity));
      }
      reportList.value = tempList;
      paginatedController.setList(reportList);
      print(reportList.length);
    } finally {
      isLoading.value = false;
    }
  }
}
