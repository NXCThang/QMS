import 'package:get/get.dart';
import 'package:qms_app/models/template.dart';
import 'package:qms_app/services/firebase_service.dart';

class TemplateController extends GetxController {
  final RxList<TemplateModel> templateList = <TemplateModel>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getTemplateList();
  }

  Future<void> getTemplateList() async {
    isLoading.value = true;
    try {
      templateList.value = await FirebaseService().getList(
        table: 'template',
        fromJson: (data) => TemplateModel.fromJson(data),
      );
    } finally {
      isLoading.value = false;
    }
  }
}
