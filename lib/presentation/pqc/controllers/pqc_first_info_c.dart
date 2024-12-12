import 'package:get/get.dart';
import 'package:qms_app/models/pqc_first_info.dart';
import 'package:qms_app/services/firebase_service.dart';

class PqcFirstInfoController extends GetxController {
  final RxList<PQCFirstInfoModel> pqcFirstInfoList = <PQCFirstInfoModel>[].obs;
  final RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    getPQCFirstInfoList();
  }

  Future<void> getPQCFirstInfoList() async {
    try {
      isLoading.value = true;
      pqcFirstInfoList.value = await FirebaseService().getList(
        table: 'pqc_first_info',
        fromJson: (data) => PQCFirstInfoModel.fromJson(data),
      );
      pqcFirstInfoList.sort((a, b) => (a.id ?? 0).compareTo(b.id ?? 0));
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addPQCFirstInfo(PQCFirstInfoModel info) async {
    await FirebaseService().addItem(
        table: 'pqc_first_info',
        documentId: (pqcFirstInfoList.length + 1).toString(),
        data: info.toJson());
    getPQCFirstInfoList();
  }

  Future<void> updatePQCFirstInfo(PQCFirstInfoModel pqcFirstInfo) async {
    try {
      isLoading.value = true;
      // await FirebaseService().update(
      //   table: 'pqc_first_info',
      //   id: pqcFirstInfo.id,
      //   data: pqcFirstInfo.toJson(),
      // );
      await getPQCFirstInfoList();
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
      await getPQCFirstInfoList();
    } finally {
      isLoading.value = false;
    }
  }
}
