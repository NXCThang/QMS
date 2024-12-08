import 'package:get/get.dart';
import 'package:qms_app/common/components/paginated_c.dart';
import 'package:qms_app/models/pqc_first_info.dart';
import 'package:qms_app/models/work_order.dart';
import 'package:qms_app/presentation/controllers/material_c.dart';
import 'package:qms_app/presentation/pqc/controllers/pqc_final_result_c.dart';
import 'package:qms_app/presentation/pqc/controllers/pqc_first_info_c.dart';
import 'package:qms_app/services/firebase_service.dart';

enum PQCType { productOrder, checkQuanlityFirst, checkQuality }

class WorkOrderController extends GetxController {
  final RxList<WorkOrderModel> workorderList = <WorkOrderModel>[].obs;
  final RxBool isLoading = true.obs;

  final PaginatedController<WorkOrderModel> paginatedController =
      PaginatedController<WorkOrderModel>();
  final materialController = Get.find<MaterialController>();
  final pqcFirstInfoController = Get.find<PqcFirstInfoController>();
  final pqcFinalResultController = Get.find<PqcFinalResultController>();

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
      paginatedController.setList(workorderList);
    } finally {
      isLoading.value = false;
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
}
