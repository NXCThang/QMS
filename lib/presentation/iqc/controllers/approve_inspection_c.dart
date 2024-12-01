import 'package:get/get.dart';
import 'package:qms_app/common/components/paginated_c.dart';
import 'package:qms_app/models/iqc_request.dart';
import 'package:qms_app/presentation/iqc/controllers/iqc_report_c.dart';
import 'package:qms_app/presentation/iqc/controllers/iqc_request_c.dart';

class ApproveInspectionController extends GetxController {
  final RxList<IqcRequestModel> approveInspectionList = <IqcRequestModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxList<bool> isShow = <bool>[].obs;
  final PaginatedController<IqcRequestModel> paginatedController =
      PaginatedController<IqcRequestModel>();
  final iqcReportController = Get.find<IqcReportController>();
  final iqcRequestController = Get.find<IqcRequestController>();

  @override
  void onInit() {
    super.onInit();
    initData();
  }

  void initData() async {
    await getApproveInspectionList();
    isShow.assignAll(
        List.generate(approveInspectionList.length, (index) => false));
  }

  Future<void> getApproveInspectionList() async {
    isLoading.value = true;
    approveInspectionList.clear();
    try {
      await iqcRequestController.initData();
      for (var request in iqcRequestController.iqcRequestList) {
        request.isStatus = true;
        if (request.reports != null) {
          bool isActive = false;
          for (var report in request.reports!) {
            if (report.isActive == 'Chờ phê duyệt') request.isStatus = false;
            if (report.isActive == 'Chờ phê duyệt' ||
                report.isActive == 'QC Passed') {
              isActive = true;
              break;
            }
          }
          if (isActive) approveInspectionList.add(request);
        }
      }
      paginatedController.setList(approveInspectionList);
      print('approveInspectionList ${approveInspectionList.length}');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> approve(int index) async {
    var request = approveInspectionList[index];
    for (var report in request.reports!) {
      if (report.isActive == 'Chờ phê duyệt') {
        report.isActive = 'QC Passed';
        await iqcReportController.updateIqcReport(report);
      }
    }
    initData();
  }

  Future<void> reject(int index) async {
    var request = approveInspectionList[index];
    for (var report in request.reports!) {
      if (report.isActive == 'Chờ phê duyệt') {
        report.isActive = 'QC Failed';
        await iqcReportController.updateIqcReport(report);
      }
    }
    initData();
  }

  void showListProduct(int index) {
    isShow[index] = !isShow[index];
  }
}
