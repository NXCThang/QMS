import 'package:get/get.dart';
import 'package:qms_app/models/work_order.dart';
import 'package:qms_app/services/firebase_service.dart';

class WorkOrderController extends GetxController {
  final RxList<WorkOrderModel> workorderList = <WorkOrderModel>[].obs;
  final RxBool isLoading = false.obs;

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
    } finally {
      isLoading.value = false;
    }
  }
}
