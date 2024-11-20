import 'package:get/get.dart';
import 'package:qms_app/models/oqc_result.dart';
import 'package:qms_app/services/firebase_service.dart';

class OqcResultController extends GetxController {
  final RxList<OQCResultModel> oqcResultList = <OQCResultModel>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getOqcResultList();
  }

  Future<void> getOqcResultList() async {
    isLoading.value = true;
    try {
      oqcResultList.value = await FirebaseService().getList(
        table: 'oqc_result',
        fromJson: (data) => OQCResultModel.fromJson(data),
      );
    } finally {
      isLoading.value = false;
    }
  }

  num getTotalNGQuantity() {
    return oqcResultList.fold(0, (sum, item) => sum + (item.nGQuantity ?? 0));
  }

  num getTotalQuantity() {
    return oqcResultList.fold(
        0, (sum, item) => sum + (item.totalQuantity ?? 0));
  }
}
