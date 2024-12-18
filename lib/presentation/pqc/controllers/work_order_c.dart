import 'package:get/get.dart';
import 'package:qms_app/common/components/paginated_c.dart';
import 'package:qms_app/models/pqc_first_info.dart';
import 'package:qms_app/models/work_order.dart';
import 'package:qms_app/presentation/controllers/material_c.dart';
import 'package:qms_app/presentation/oqc/controllers/oqc_info_c.dart';
import 'package:qms_app/presentation/pqc/controllers/pqc_final_result_c.dart';
import 'package:qms_app/presentation/pqc/controllers/pqc_first_info_c.dart';
import 'package:qms_app/services/firebase_service.dart';

enum WorkOrderType { productOrder, checkQuanlityFirst, checkQuality, checkOQC }

class WorkOrderController extends GetxController {
  final RxList<WorkOrderModel> workorderList = <WorkOrderModel>[].obs;
  final RxBool isLoading = true.obs;

  final PaginatedController<WorkOrderModel> paginatedController =
      PaginatedController<WorkOrderModel>();
  final materialController = Get.find<MaterialController>();
  final pqcFirstInfoController = Get.find<PqcFirstInfoController>();
  final pqcFinalResultController = Get.find<PqcFinalResultController>();
  final oqcInfoController = Get.find<OqcInfoController>();

  @override
  void onInit() {
    super.onInit();
    getWorkOrderList();
  }

  Future<void> getWorkOrderList() async {
    try {
      isLoading.value = true;
      workorderList.value = await FirebaseService().getList(
        table: 'work_order',
        fromJson: (data) => WorkOrderModel.fromJson(data),
      );
      workorderList.sort((a, b) => (a.id ?? 0).compareTo(b.id ?? 0));
      await searchMaterial();
      await searchPQCFirstInfo();
      await searchPQCFinalResult();
      await searchOQCInfo();
      paginatedController.setList(workorderList);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> searchWorkOrder(String key) async {
    if (key.isEmpty) {
      // Reset workorderList to the full list
      await getWorkOrderList();
    } else {
      // Filter workorderList based on the key
      final filteredList = workorderList.where((workOrder) {
        return (workOrder.workOrderCode?.contains(key) ?? false) ||
            (workOrder.productName?.contains(key) ?? false) ||
            (workOrder.productId?.toString().contains(key) ??
                false); // Assuming productId is an integer
      }).toList();

      paginatedController.setList(filteredList);
    }
  }

  Future<void> searchMaterial() async {
    await materialController.getMaterialList();
    for (var workOrder in workorderList) {
      workOrder.materials = materialController.materialList
          .where((element) =>
              element.productId.toString() == workOrder.productId.toString())
          .toList();
      print('workorder ${workOrder.id} has ${workOrder.materials?.length}');
    }
  }

  Future<void> searchPQCFirstInfo() async {
    await pqcFirstInfoController.getPQCFirstInfoList();
    for (var workOrder in workorderList) {
      workOrder.pqcFirstInfos = pqcFirstInfoController.pqcFirstInfoList
          .where((element) => element.workOrderId == workOrder.id)
          .toList();
      print(
          'workorder ${workOrder.id} has pqcFirstInfo ${workOrder.pqcFirstInfos?.length}');
    }
  }

  Future<void> searchPQCFinalResult() async {
    await pqcFinalResultController.getpqcFinalResultList();
    for (var workOrder in workorderList) {
      workOrder.pqcFinalResults = pqcFinalResultController.pqcFinalResultList
          .where((element) => element.workOrderId == workOrder.id)
          .toList();
      print(
          'workorder ${workOrder.id} has pqcFinalResult ${workOrder.pqcFinalResults?.length}');
    }
  }

  Future<void> searchOQCInfo() async {
    await oqcInfoController.getOqcInfoList();
    for (var workOrder in workorderList) {
      workOrder.oqcInfos = oqcInfoController.oqcInfoList
          .where((element) => element.workOrderId == workOrder.id)
          .toList();
      print(
          'workorder ${workOrder.id} has oqcInfo ${workOrder.pqcFinalResults?.length}');
    }
  }

  Future<String> getWorkOrderCode(int id) async {
    for (var workOrder in workorderList) {
      if (workOrder.id == id) return workOrder.workOrderCode.toString();
    }
    return ''; // or throw an exception if appropriate
  }
}
