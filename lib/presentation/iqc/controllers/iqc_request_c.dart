import 'package:get/get.dart';
import 'package:qms_app/common/components/paginated_c.dart';
import 'package:qms_app/models/iqc_report.dart';
import 'package:qms_app/models/iqc_request.dart';
import 'package:qms_app/presentation/iqc/controllers/iqc_report_c.dart';
import 'package:qms_app/services/firebase_service.dart';

class IqcRequestController extends GetxController {
  final RxList<IqcRequestModel> iqcRequestList = <IqcRequestModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxList<bool> isShow = <bool>[].obs;
  final PaginatedController<IqcRequestModel> paginatedController =
      PaginatedController<IqcRequestModel>();
  final iqcReportController = Get.find<IqcReportController>();

  @override
  void onInit() {
    super.onInit();
    initData();
  }

  Future<void> initData() async {
    await getIQCRequestList();
    isShow.assignAll(List.generate(iqcRequestList.length, (index) => false));
  }

  Future<void> getIQCRequestList() async {
    isLoading.value = true;
    try {
      iqcRequestList.value = await FirebaseService().getList(
        table: 'iqc_request',
        fromJson: (data) => IqcRequestModel.fromJson(data),
      );
      iqcRequestList.sort((a, b) => (a.id ?? 0).compareTo(b.id ?? 0));
      paginatedController.setList(iqcRequestList);
      searchIqcReport();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> searchIqcReport() async {
    for (var iqcRequest in iqcRequestList) {
      for (var iqcReport in iqcReportController.iqcReportList) {
        if (iqcRequest.id == iqcReport.iqcRequestId) {
          iqcRequest.reports ??= <IQCReportModel>[];
          iqcRequest.reports?.add(iqcReport);
        }
      }
      // iqcRequest.reports = iqcReportController.iqcReportList
      //     .where((element) => element.iqcRequestId == iqcRequest.id)
      //     .toList();
      print(iqcRequest.reports?.length ?? '');
    }
  }

  void showListProduct(int index) {
    isShow[index] = !isShow[index];
  }
}
