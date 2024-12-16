import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:qms_app/common/color.dart';
import 'package:qms_app/common/components/build_pagination_controls.dart';
import 'package:qms_app/common/extensions/date_time_format.dart';
import 'package:qms_app/common/icon_path.dart';
import 'package:qms_app/presentation/report/controllers/report_ng_ok_c.dart';
import 'package:qms_app/presentation/report/model/report_ng_ok.dart';
import 'package:qms_app/presentation/widgets/add_error.dart';
import 'package:qms_app/presentation/widgets/table_custom.dart';

class RateProductQuantity extends StatelessWidget {
  const RateProductQuantity({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    final controller = Get.find<ReportNgOkController>();
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(
            child: CircularProgressIndicator(
          color: QMSColor.mainorange,
        ));
      }
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
                appLocalizations?.report_NG_OK_ratio ?? '',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24),
              )
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          const SizedBox(
            height: 10,
          ),
          const SizedBox(
            height: 0,
          ),
          TableCustom(
            title: {
              ItemTitleWidget(title: 'STT'): 1,
              ItemTitleWidget(title: 'Mã sản phẩm'): 2,
              ItemTitleWidget(title: 'Tên sản phẩm'): 4,
              ItemTitleWidget(title: 'Mã WO'): 2,
              ItemTitleWidget(title: 'Thời gian bắt đầu'): 2,
              ItemTitleWidget(title: 'Thời gian kết thúc'): 2,
              ItemTitleWidget(title: 'Tổng thực tế'): 2,
              ItemTitleWidget(title: 'Số lượng OK'): 2,
              ItemTitleWidget(title: 'Số lượng NG'): 2,
              ItemTitleWidget(title: 'Tỉ lệ NG/OK'): 2,
            },
          ),
          Expanded(
            child: ListView.builder(
              itemCount: controller.paginatedController.paginatedItems.length,
              itemBuilder: (BuildContext context, int index) {
                final item =
                    controller.paginatedController.paginatedItems[index];
                final stt = index +
                    1 +
                    controller.paginatedController.currentPage.value *
                        controller.paginatedController.itemsPerPage;
                return TableCustom(
                  color: Colors.white,
                  title: {
                    ItemBodyWidget(title: '$stt'): 1,
                    ItemBodyWidget(
                        title:
                            item.workOrderModel?.productId.toString() ?? ''): 2,
                    ItemBodyWidget(
                        title: item.workOrderModel?.productName.toString() ??
                            ''): 4,
                    ItemBodyWidget(
                        title: item.workOrderModel?.id.toString() ?? ''): 2,
                    ItemBodyWidget(
                        title:
                            item.workOrderModel?.startDate?.formatDateTime() ??
                                ''): 2,
                    ItemBodyWidget(
                        title: item.workOrderModel?.dueDate?.formatDateTime() ??
                            ''): 2,
                    ItemBodyWidget(
                        title:
                            ((item.ngQuantity ?? 0) + (item.totalQuantity ?? 0))
                                .toString()): 2,
                    ItemBodyWidget(title: item.totalQuantity.toString()): 2,
                    ItemBodyWidget(title: item.ngQuantity.toString() ?? ''): 2,
                    ItemBodyWidget(
                        title:
                            '${item.ngQuantity == 0 ? '0.00' : (((item.ngQuantity ?? 0) / (item.totalQuantity ?? 1)) * 100).toStringAsFixed(2)}%'): 2,
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          BuildPaginationControls<ReportNgOkModel>(
            paginatedController: controller.paginatedController,
          ),
          const SizedBox(height: 10),
        ]),
      );
    });
  }
}
