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
      oqcResultList.sort((a, b) => (a.id ?? 0).compareTo(b.id ?? 0));
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addOQCResult(OQCResultModel result) async {
    try {
      isLoading.value = true;
      await FirebaseService().addItem(
          table: 'oqc_result',
          documentId: (oqcResultList.length + 1).toString(),
          data: result.toJson());
      await getOqcResultList();
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
