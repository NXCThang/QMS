import 'package:get/get.dart';
import 'package:qms_app/models/sell_order.dart';
import 'package:qms_app/services/firebase_service.dart';

class SellOrderController extends GetxController {
  final RxList<SellOrderModel> sellOrderList = <SellOrderModel>[].obs;
  final RxBool isLoading = false.obs;
  @override
  void onInit() {
    super.onInit();
    getSellOrderList();
  }

  Future<void> getSellOrderList() async {
    isLoading.value = true;
    try {
      sellOrderList.value = await FirebaseService().getList(
        table: 'sell_order',
        fromJson: (data) => SellOrderModel.fromJson(data),
      );
      sellOrderList.sort((a, b) => (a.id ?? 0).compareTo(b.id ?? 0));
    } finally {
      isLoading.value = false;
    }
  }
}
