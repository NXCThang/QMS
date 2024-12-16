import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:qms_app/models/iqc_report.dart';
import 'package:qms_app/presentation/pqc/controllers/work_order_c.dart';
import 'package:qms_app/presentation/pqc/widgets/create_check_quality_first.dart';

enum SideBarOption {
  none('none'),

  dashboard('Dashboard'),

  inspectionReportSample('Mẫu biên bản kiểm tra'),
  expenseManagement('Quản lý chi tiêu AQL'),

  approveInspectionRecords('Phê duyệt biên bản kiểm tra'),
  listofIQCRequirements('Danh sách yêu cầu IQC'),

  listofProductionOrders('Danh sách lệnh sản xuất'),
  checkProductQualityFirst('Kiểm tra chất lượng sản phẩm đầu'),
  checkProductQuality('Kiểm tra chất lượng sản phẩm'),

  checkOQC('Kiểm tra OQC'),
  approvalForWarehouseEntry('Phê duyệt nhập kho'),

  reportNGOKRatio('Báo cáo tỷ lệ NG/OK'),
  workOrderReport('Báo cáo tỷ lệ hoàn thành theo WO'),
  sellOrderReport('Báo cáo tỷ lệ hoàn thành theo SO'),
  product('Sản phẩm'),
  material('Danh sách NVL, LKDT'),
  iqcResult('Chỉnh sửa thông tin mẫu biên bản'),
  detailProductionOrder('Thông tin lệnh sản xuất'),
  materialReport('Danh sách biên bản NVL'),
  createCheckQualityFirst(
      'Khai báo thông tin kiểm tra chất lượng sản phẩm đầu'),
  createNewEntry('Thêm mới thông tin yêu cầu (Thông tin sản xuất)'),
  createCheckOQC('Khai báo thông tin kiểm tra chất lượng công đoạn OQC'),
  ;

  final String value;

  const SideBarOption(this.value);
}

// class SideBarController extends GetxController {
//   var currentPage = SideBarOption.none.obs;
//   Map<String, dynamic>? arguments;

//   void changePage(String title) {
//     SideBarOption option = SideBarOption.values.firstWhere(
//         (element) => element.value == title,
//         orElse: () => SideBarOption.none);
//     currentPage.value = option;
//     arguments = null;
//     print(currentPage.value.value);
//   }

//   void changePageWithArguments(String title, IQCReportModel args) {
//     SideBarOption option = SideBarOption.values.firstWhere(
//       (element) => element.value == title,
//       orElse: () => SideBarOption.none,
//     );
//     currentPage.value = option;
//     Get.toNamed(Get.currentRoute, arguments: args); // Truyền tham số
//   }
// }

class SideBarController extends GetxController {
  var currentPage = SideBarOption.none.obs;

  Map<String, dynamic>? arguments;

  void changePage(String title) {
    final option = SideBarOption.values.firstWhere(
      (element) => element.value == title,
      orElse: () => SideBarOption.none,
    );

    currentPage.value = option;
    arguments = null;

    print('Changed to page: ${currentPage.value.value}');
  }

  void changePageWithArguments(String title, Map<String, dynamic> args,
      [WorkOrderType? type, bool enable = true]) {
    final option = SideBarOption.values.firstWhere(
      (element) => element.value == title,
      orElse: () => SideBarOption.none,
    );

    currentPage.value = option;

    // Nếu `type` không có, truyền `0` vào arguments
    arguments = {
      ...args, // Giữ nguyên các dữ liệu cũ
      'type': type?.name ?? '0', // Truyền `type` nếu có, nếu không thì là '0'
      'enable': enable, // Truyền thêm enable vào arguments
    };

    Get.toNamed(Get.currentRoute, arguments: arguments);
    print('Changed to page: ${currentPage.value.value} with arguments');
  }
}
