import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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

  reportNGOKRatio('Báo cáo tỉ lệ NG/OK'),
  orderCompletionRateReport('Báo cáo tỷ lệ hoàn thành theo đơn đặt hàng'),
  productionOrderCompletionRateReport(
      'Báo cáo tỷ lệ hoàn thành theo lệnh sản xuất'),
  product('Sản phẩm'),
  material('Danh sách NVL, LKDT'),
  iqcResult('Chỉnh sửa thông tin mẫu biên bản');

  final String value;

  const SideBarOption(this.value);
}

class SideBarController extends GetxController {
  var currentPage = SideBarOption.none.obs;

  void changePage(String title) {
    SideBarOption option = SideBarOption.values.firstWhere(
        (element) => element.value == title,
        orElse: () => SideBarOption.none);
    currentPage.value = option;
    print(currentPage.value.value);
  }
}
