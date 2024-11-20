import 'package:get/get.dart';
import 'package:qms_app/models/oqc_info.dart';
import 'package:qms_app/services/firebase_service.dart';

class OqcInfoController extends GetxController {
  final RxList<OQCInfoModel> oqcInfoList = <OQCInfoModel>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getOqcInfoList();
  }

  Future<void> getOqcInfoList() async {
    isLoading.value = true;
    try {
      oqcInfoList.value = await FirebaseService().getList(
        table: 'oqc_result',
        fromJson: (data) => OQCInfoModel.fromJson(data),
      );
    } finally {
      isLoading.value = false;
    }
  }
}
