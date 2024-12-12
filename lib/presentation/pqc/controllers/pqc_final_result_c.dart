import 'package:get/get.dart';
import 'package:qms_app/models/pqc_final_result.dart';
import 'package:qms_app/services/firebase_service.dart';

class PqcFinalResultController extends GetxController {
  final RxList<PQCFinalResultModel> pqcFinalResultList =
      <PQCFinalResultModel>[].obs;
  final RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    getpqcFinalResultList();
  }

  Future<void> getpqcFinalResultList() async {
    try {
      isLoading.value = true;
      pqcFinalResultList.value = await FirebaseService().getList(
        table: 'pqc_final_result',
        fromJson: (data) => PQCFinalResultModel.fromJson(data),
      );
      pqcFinalResultList.sort((a, b) => (a.id ?? 0).compareTo(b.id ?? 0));
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updatePQCFirstInfo(PQCFinalResultModel pqcFirstInfo) async {
    try {
      isLoading.value = true;
      // await FirebaseService().update(
      //   table: 'pqc_first_info',
      //   id: pqcFirstInfo.id,
      //   data: pqcFirstInfo.toJson(),
      // );
      await getpqcFinalResultList();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addPQCFinalResult(PQCFinalResultModel result) async {
    try {
      isLoading.value = true;
      await FirebaseService().addItem(
          table: 'pqc_final_result',
          documentId: (pqcFinalResultList.length + 1).toString(),
          data: result.toJson());
      await getpqcFinalResultList();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deletePQCFirstInfo(int id) async {
    try {
      isLoading.value = true;
      // await FirebaseService().delete(
      //   table: 'pqc_first_info',
      //   id: id,
      // );
      await getpqcFinalResultList();
    } finally {
      isLoading.value = false;
    }
  }
}
