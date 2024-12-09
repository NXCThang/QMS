import 'package:get/get.dart';
import 'package:qms_app/models/pqc_first_result.dart';
import 'package:qms_app/services/firebase_service.dart';

class PqcFirstResultController extends GetxController {
  final RxList<PQCFirstResultModel> pqcFirstResultList =
      <PQCFirstResultModel>[].obs;
  final RxBool isLoading = true.obs;

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
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updatePQCFirstInfo(PQCFirstResultModel pqcFirstResult) async {
    try {
      isLoading.value = true;
      // await FirebaseService().update(
      //   table: 'pqc_first_info',
      //   id: pqcFirstInfo.id,
      //   data: pqcFirstInfo.toJson(),
      // );
      await getPQCFirstResultList();
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
      await getPQCFirstResultList();
    } finally {
      isLoading.value = false;
    }
  }
}
