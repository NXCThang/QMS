import 'package:get/get.dart';
import 'package:qms_app/common/components/paginated_c.dart';
import 'package:qms_app/models/oqc_info.dart';
import 'package:qms_app/presentation/oqc/controllers/oqc_result_c.dart';
import 'package:qms_app/services/firebase_service.dart';

class OqcInfoController extends GetxController {
  final RxList<OQCInfoModel> oqcInfoList = <OQCInfoModel>[].obs;
  final RxList<OQCInfoModel> filteredItems = <OQCInfoModel>[].obs;

  final RxBool isLoading = false.obs;
  final PaginatedController<OQCInfoModel> paginatedController =
      PaginatedController<OQCInfoModel>();
  final oqcResultController = Get.find<OqcResultController>();

  @override
  void onInit() {
    super.onInit();
    getOqcInfoList();
  }

  Future<void> getOqcInfoList() async {
    isLoading.value = true;
    try {
      oqcInfoList.value = await FirebaseService().getList(
        table: 'oqc_info',
        fromJson: (data) => OQCInfoModel.fromJson(data),
      );
      oqcInfoList.sort((a, b) => (a.id ?? 0).compareTo(b.id ?? 0));
      await searchOQCResults();
      for (var info in oqcInfoList) {
        if (info.status != "Bản nháp") {
          print('info ${info.id} has ${info.status}');
          filteredItems.add(info);
        }
      }
      print('filteredItems ${filteredItems.length}');
      paginatedController.setList(filteredItems);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addOqcInfo(OQCInfoModel info) async {
    try {
      isLoading.value = true;
      await FirebaseService().addItem(
          table: 'oqc_info',
          documentId: (oqcInfoList.length + 1).toString(),
          data: info.toJson());
      await getOqcInfoList();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> searchOQCResults() async {
    for (var info in oqcInfoList) {
      info.oqcResults = oqcResultController.oqcResultList
          .where((element) => element.oqcInfoId == info.id)
          .toList();
    }
  }
}
