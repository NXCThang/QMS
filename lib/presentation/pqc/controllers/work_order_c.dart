import 'package:get/get.dart';
import 'package:qms_app/common/components/paginated_c.dart';
import 'package:qms_app/models/work_order.dart';
import 'package:qms_app/presentation/controllers/material_c.dart';
import 'package:qms_app/services/firebase_service.dart';

class WorkOrderController extends GetxController {
  final RxList<WorkOrderModel> workorderList = <WorkOrderModel>[].obs;
  final RxBool isLoading = true.obs;

  final PaginatedController<WorkOrderModel> paginatedController =
      PaginatedController<WorkOrderModel>();
  final materialController = Get.find<MaterialController>();

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
      paginatedController.setList(workorderList);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> searchMaterial() async {
    for (var workOrder in workorderList) {
      workOrder.materials = materialController.materialList
          .where(
              (element) => element.productId == workOrder.productId.toString())
          .toList();
    }
  }
}
