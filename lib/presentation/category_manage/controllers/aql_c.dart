import 'package:get/get.dart';
import 'package:qms_app/models/aql.dart';
import 'package:qms_app/services/firebase_service.dart';

class AQLController extends GetxController {
  final RxList<AQLModel> aqlList = <AQLModel>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getAQLList();
  }

  Future<void> getAQLList() async {
    isLoading.value = true;
    try {
      aqlList.value = await FirebaseService().getList(
        table: 'aql',
        fromJson: (data) => AQLModel.fromJson(data),
      );
    } finally {
      isLoading.value = false;
    }
  }
}
