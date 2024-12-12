import 'package:get/get.dart';
import 'package:qms_app/common/components/paginated_c.dart';
import 'package:qms_app/models/pqc_first_result.dart';
import 'package:qms_app/services/firebase_service.dart';

class PqcFirstResultController extends GetxController {
  final RxList<PQCFirstResultModel> pqcFirstResultList =
      <PQCFirstResultModel>[].obs;
  final PaginatedController<PQCFirstResultModel> paginatedController =
      PaginatedController<PQCFirstResultModel>();
  final RxBool isLoading = true.obs;
  final RxList<PQCFirstResultModel> evaluateItems = <PQCFirstResultModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getPQCFirstResultList();
  }

  Future<void> getPQCFirstResultList() async {
    try {
      isLoading.value = true;
      pqcFirstResultList.value = await FirebaseService().getList(
        table: 'pqc_first_result',
        fromJson: (data) => PQCFirstResultModel.fromJson(data),
      );
      pqcFirstResultList.sort((a, b) => (a.id ?? 0).compareTo(b.id ?? 0));
      paginatedController.setList(pqcFirstResultList);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addPQCFirstResult(PQCFirstResultModel result) async {
    try {
      isLoading.value = true;
      await FirebaseService().addItem(
          table: 'pqc_first_result',
          documentId: (pqcFirstResultList.length + 1).toString(),
          data: result.toJson());
      await getPQCFirstResultList();
    } finally {
      isLoading.value = false;
    }
  }
}
