import 'package:get/get.dart';
import 'package:qms_app/models/iqc_request.dart';
import 'package:qms_app/services/firebase_service.dart';

class IqcRequestController extends GetxController {
  final RxList<IqcRequestModel> IqcRequestList = <IqcRequestModel>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getIQCRequestList();
  }

  Future<void> getIQCRequestList() async {
    IqcRequestList.value = await FirebaseService().getList(
      table: 'iqc_request',
      fromJson: (data) => IqcRequestModel.fromJson(data),
    );
    print(IqcRequestList.length);
  }
}
