import 'package:get/get.dart';
import 'package:qms_app/models/iqc_result_ng.dart';
import 'package:qms_app/services/firebase_service.dart';

class IqcResultNgController extends GetxController {
  final RxList<IQCResultNgModel> iqcResultNgList = <IQCResultNgModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxList<IQCResultNgModel> newList = <IQCResultNgModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getIqcResultNgList();
  }

  Future<void> getIqcResultNgList() async {
    isLoading.value = true;
    try {
      iqcResultNgList.value = await FirebaseService().getList(
        table: 'iqc_result_ng',
        fromJson: (data) => IQCResultNgModel.fromJson(data),
      );
      iqcResultNgList.sort((a, b) => (a.id ?? 0).compareTo(b.id ?? 0));
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addIqcResultNg(IQCResultNgModel resultNg) async {
    await FirebaseService().addItem(
        table: 'iqc_result_ng',
        documentId: (iqcResultNgList.length + 1).toString(),
        data: resultNg.toJson());
    getIqcResultNgList();
  }

  Future<void> addTemporary(IQCResultNgModel resultNg) async {
    newList.add(resultNg);
  }
}
