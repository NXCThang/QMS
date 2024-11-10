import 'package:get/get.dart';
import 'package:qms_app/models/iqc_result.dart';
import 'package:qms_app/services/firebase_service.dart';

class IqcResultController extends GetxController {
  final RxList<IQCResultModel> iqcResultList = <IQCResultModel>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getIqcResultList();
  }

  Future<void> getIqcResultList() async {
    isLoading.value = true;
    try {
      iqcResultList.value = await FirebaseService().getList(
        table: 'iqc_result',
        fromJson: (data) => IQCResultModel.fromJson(data),
      );
    } finally {
      isLoading.value = false;
    }
  }
}
