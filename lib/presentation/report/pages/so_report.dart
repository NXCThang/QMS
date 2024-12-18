import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:qms_app/common/color.dart';
import 'package:qms_app/common/components/build_pagination_controls.dart';
import 'package:qms_app/common/extensions/date_time_format.dart';
import 'package:qms_app/common/extensions/number_format.dart';
import 'package:qms_app/common/helper/export_excel.dart';
import 'package:qms_app/common/icon_path.dart';
import 'package:qms_app/presentation/oqc/controllers/sell_order_c.dart';
import 'package:qms_app/presentation/report/controllers/so_report_c.dart';
import 'package:qms_app/presentation/report/model/so_report.dart';
import 'package:qms_app/presentation/widgets/add_error.dart';
import 'package:qms_app/presentation/widgets/table_custom.dart';

class SoReport extends StatelessWidget {
  SoReport({super.key});
  var soReportController = Get.find<SOReportController>();
  var sellOrderController = Get.find<SellOrderController>();
  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    return Obx(() {
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black.withOpacity(0.1), width: 1),
        ),
        margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Báo cáo tỷ lệ hoàn thành theo SO',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () => exportCustomExcelSO(soReportController.reportList),
                child: Container(
                  decoration: BoxDecoration(
                    color: QMSColor.mainorange,
                  ),
                  padding: EdgeInsets.all(4),
                  child: Row(
                    children: [
                      Icon(
                        Icons.download,
                        color: Colors.white,
                      ),
                      Text(
                        'Xuất Excel',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          TableCustom(
            title: {
              ItemTitleWidget(title: 'STT'): 1,
              ItemTitleWidget(title: 'Mã đơn hàng'): 3,
              ItemTitleWidget(title: 'Mã sản phẩm'): 2,
              ItemTitleWidget(title: 'Tên sản phẩm'): 3,
              ItemTitleWidget(title: 'Thời gian bắt đầu'): 2,
              ItemTitleWidget(title: 'Thời gian kết thúc'): 2,
              ItemTitleWidget(title: 'Sản lượng kế hoạch'): 2,
              ItemTitleWidget(title: 'Tổng số lượng'): 2,
              ItemTitleWidget(title: 'Tỉ lệ hoàn thành'): 2,
              ItemTitleWidget(title: 'Trạng thái'): 3
            },
          ),
          SizedBox(
            height: 45.0 *
                soReportController.paginatedController.paginatedItems.length,
            child: ListView.builder(
              itemCount:
                  soReportController.paginatedController.paginatedItems.length,
              itemBuilder: (BuildContext context, int index) {
                final item = soReportController
                    .paginatedController.paginatedItems[index];
                // var okQuantity = item.oqcResultModel?.testQuantity ??
                //     0 - (item.oqcResultModel?.nGQuantity ?? 0);
                final stt = index +
                    1 +
                    soReportController.paginatedController.currentPage.value *
                        soReportController.paginatedController.itemsPerPage;
                final sellItem = sellOrderController
                    .sellOrderList[item.workOrderModel?.id ?? 1];
                return TableCustom(
                  color: Colors.white,
                  title: {
                    ItemBodyWidget(title: '$stt'): 1,
                    ItemBodyWidget(title: sellItem.soCode.toString()): 3,
                    ItemBodyWidget(
                        title:
                            item.workOrderModel?.productId.toString() ?? ''): 2,
                    ItemBodyWidget(
                        title: item.workOrderModel?.productName ?? ''): 3,
                    ItemBodyWidget(
                        title:
                            item.workOrderModel?.startDate?.formatDateTime() ??
                                ''): 2,
                    ItemBodyWidget(
                        title: item.workOrderModel?.dueDate?.formatDateTime() ??
                            ''): 2,
                    ItemBodyWidget(title: item.planQquantity.toString()): 2,
                    ItemBodyWidget(title: item.totalQuantity.toString()): 2,
                    ItemBodyWidget(
                        title:
                            '${item.planQquantity == 0 ? '0.00' : (((item.totalQuantity ?? 0) / (item.planQquantity ?? 1)) * 100).toStringAsFixed(2)}%'): 2,
                    (item.workOrderModel?.isActive == 1)
                        ? Container(
                            decoration: BoxDecoration(
                                color: Colors.green.withOpacity(0.3),
                                border: Border.all(color: Colors.green)),
                            padding: EdgeInsets.all(2),
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: Center(
                              child: Text(
                                item.workOrderModel?.isActive
                                        ?.displayIsActive() ??
                                    '',
                                style: TextStyle(color: Colors.green),
                              ),
                            ),
                          )
                        : Container(
                            decoration: BoxDecoration(
                                color: Colors.red.withOpacity(0.2),
                                border: Border.all(color: Colors.red)),
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            padding: EdgeInsets.all(2),
                            child: Center(
                              child: Text(
                                item.workOrderModel?.isActive
                                        ?.displayIsActive() ??
                                    '',
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ): 3,
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          BuildPaginationControls<SoReportModel>(
            paginatedController: soReportController.paginatedController,
          ),
          const SizedBox(height: 10),
        ]),
      );
    });
  }
}
