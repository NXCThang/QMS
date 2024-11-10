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
    workorderList.value = await FirebaseService().getList(
      table: 'aql',
      fromJson: (data) => WorkOrderModel.fromJson(data),
    );
  }
}
