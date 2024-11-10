import 'package:get/get.dart';
import 'package:qms_app/models/material.dart';
import 'package:qms_app/services/firebase_service.dart';

class MaterialController extends GetxController {
  final RxList<MaterialModel> materialList = <MaterialModel>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getMaterialList();
  }

  Future<void> getMaterialList() async {
    isLoading.value = true;
    try {
      materialList.value = await FirebaseService().getList(
        table: 'material',
        fromJson: (data) => MaterialModel.fromJson(data),
      );
    } finally {
      isLoading.value = false;
    }
  }
}
