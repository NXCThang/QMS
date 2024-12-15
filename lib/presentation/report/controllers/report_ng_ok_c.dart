import 'package:get/get.dart';
import 'package:qms_app/common/components/paginated_c.dart';
import 'package:qms_app/models/oqc_info.dart';
import 'package:qms_app/models/oqc_result.dart';
import 'package:qms_app/presentation/oqc/controllers/oqc_info_c.dart';
import 'package:qms_app/presentation/oqc/controllers/oqc_result_c.dart';
import 'package:qms_app/presentation/pqc/controllers/work_order_c.dart';
import 'package:qms_app/presentation/report/model/report_ng_ok.dart';

class ReportNgOkController extends GetxController {
  final workOrderController = Get.find<WorkOrderController>();
  final oqcInfoController = Get.find<OqcInfoController>();
  final oqcResultController = Get.find<OqcResultController>();
  final isLoading = true.obs;
  final PaginatedController<ReportNgOkModel> paginatedController =
      PaginatedController<ReportNgOkModel>();

  RxList<ReportNgOkModel> reportList = <ReportNgOkModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadLists();
  }

  Future<void> loadLists() async {
    await workOrderController.getWorkOrderList();
    await oqcInfoController.getOqcInfoList();
    await oqcResultController.getOqcResultList();
    print(workOrderController.workorderList.length);
    print(oqcInfoController.oqcInfoList.length);
    print(oqcResultController.oqcResultList.length);
    initReportNGOKList();
  }

  Future<void> initReportNGOKList() async {
    List<ReportNgOkModel> tempList = [];
    try {
      isLoading.value = true;
      for (var workOrder in workOrderController.workorderList) {
        OQCInfoModel? info = await oqcInfoController.oqcInfoList
            .firstWhereOrNull((oqcInfo) => oqcInfo.workOrderId == workOrder.id);
        OQCResultModel? result = await oqcResultController.oqcResultList
            .firstWhereOrNull(
                (oqcResult) => oqcResult.oqcInfoId == workOrder.id);
        tempList.add(ReportNgOkModel(
            workOrderModel: workOrder,
            oqcInfoModel: info,
            oqcResultModel: result));
      }
      reportList.value = tempList;
      paginatedController.setList(reportList);
      print(reportList.length);
    } finally {
      isLoading.value = false;
    }
    // try {
    //   for (var workOrder in workOrderController.workorderList) {
    //     // Sử dụng await để chờ kết quả của các hàm không đồng bộ
    //     OQCInfoModel? info = await oqcInfoController.oqcInfoList
    //         .firstWhereOrNull((oqcInfo) => oqcInfo.workOrderId == workOrder.id);
    //     OQCResultModel? result = await oqcResultController.oqcResultList
    //         .firstWhereOrNull(
    //             (oqcResult) => oqcResult.oqcInfoId == workOrder.id);

    //     // Nếu cả `info` và `result` không null, thêm vào danh sách tạm
    //     if (info != null && result != null) {
    //       tempList.add(ReportNgOkModel(
    //         workOrderModel: workOrder,
    //         oqcInfoModel: info,
    //         oqcResultModel: result,
    //       ));
    //     }
    //     print(workOrder); // Debug in thông tin workOrder
    //   }

    //   // Cập nhật danh sách báo cáo
    //   reportList.value = tempList;
    // } catch (e) {
    //   print('Error: $e'); // Bắt lỗi trong quá trình xử lý
    // } finally {
    //   isLoading.value = false; // Đánh dấu kết thúc tải dữ liệu
    // }

    // // Debug số lượng phần tử trong danh sách
    // print("reportList: " + reportList.length.toString());
  }
}
