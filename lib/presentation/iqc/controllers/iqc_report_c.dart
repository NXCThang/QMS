import 'package:get/get.dart';
import 'package:qms_app/models/iqc_report.dart';
import 'package:qms_app/models/iqc_result.dart';
import 'package:qms_app/presentation/category_manage/controllers/iqc_result_c.dart';
import 'package:qms_app/presentation/iqc/controllers/iqc_request_c.dart';
import 'package:qms_app/services/firebase_service.dart';

class IqcReportController extends GetxController {
  final RxList<IQCReportModel> iqcReportList = <IQCReportModel>[].obs;
  final RxBool isLoading = false.obs;
  var iqcResultController = Get.find<IqcResultController>();
  // final iqcRequestController = Get.find<IqcRequestController>();

  @override
  void onInit() {
    super.onInit();
    getIqcReportList();
  }

  Future<void> getIqcReportList() async {
    isLoading.value = true;
    try {
      iqcReportList.value = await FirebaseService().getList(
        table: 'iqc_report',
        fromJson: (data) => IQCReportModel.fromJson(data),
      );
      iqcReportList.sort((a, b) => (a.id ?? 0).compareTo(b.id ?? 0));
      searchIQCResult();
      // iqcRequestController.getIQCRequestList();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addIqcReport(IQCReportModel report) async {
    await FirebaseService().addItem(
        table: 'iqc_report',
        documentId: (iqcReportList.length + 1).toString(),
        data: report.toJson());
    getIqcReportList();
  }

  Future<void> deleteIqcReport(String id) async {
    await FirebaseService()
        .deleteItem(table: 'iqc_report', field: 'id', documentId: id);
    getIqcReportList();
  }

  Future<void> updateIqcReport(IQCReportModel report) async {
    await FirebaseService().updateItem(
        table: 'iqc_report',
        field: 'id',
        documentId: report.id.toString(),
        data: report.toJson());
    getIqcReportList();
  }

  Future<void> searchIQCResult() async {
    await iqcResultController.getIqcResultList();
    for (var report in iqcReportList) {
      report.iqcResultList = iqcResultController.iqcResultList
          .where((element) => element.iqcReportId == report.id)
          .toList();
      print('report ${report.id} has ${report.iqcResultList?.length}');
    }
  }
}
