import 'package:get/get.dart';
import 'package:qms_app/common/components/paginated_c.dart';
import 'package:qms_app/models/iqc_result.dart';
import 'package:qms_app/services/firebase_service.dart';

class IqcResultController extends GetxController {
  final RxList<IQCResultModel> iqcResultList = <IQCResultModel>[].obs;
  final RxBool isLoading = false.obs;
  final PaginatedController<IQCResultModel> paginatedController =
      PaginatedController<IQCResultModel>();

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
      iqcResultList.sort((a, b) => (a.id ?? 0).compareTo(b.id ?? 0));
      paginatedController.setList(iqcResultList);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addIqcResult(IQCResultModel result) async {
    await FirebaseService().addItem(
        table: 'iqc_result',
        documentId: (iqcResultList.length + 1).toString(),
        data: result.toJson());
    getIqcResultList();
  }

  Future<void> deleteIqcResult(String id) async {
    await FirebaseService()
        .deleteItem(table: 'iqc_result', field: 'id', documentId: id);
    getIqcResultList();
  }

  Future<void> updateIqcResult(IQCResultModel result) async {
    await FirebaseService().updateItem(
        table: 'iqc_result',
        field: 'id',
        documentId: result.id.toString(),
        data: result.toJson());
    getIqcResultList();
  }
}
