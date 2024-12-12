import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:qms_app/common/color.dart';
import 'package:qms_app/common/components/build_pagination_controls.dart';
import 'package:qms_app/common/components/custom_button.dart';
import 'package:qms_app/common/components/two_button_circle.dart';
import 'package:qms_app/common/extensions/date_time_format.dart';
import 'package:qms_app/common/icon_path.dart';
import 'package:qms_app/models/iqc_request.dart';
import 'package:qms_app/presentation/iqc/controllers/approve_inspection_c.dart';
import 'package:qms_app/presentation/iqc/widgets/iqc_report_list.dart';
import 'package:qms_app/presentation/widgets/add_error.dart';
import 'package:qms_app/presentation/widgets/table_custom.dart';

class ApproveInspectionRecords extends StatelessWidget {
  ApproveInspectionRecords({super.key});
  final controller = Get.find<ApproveInspectionController>();

  @override
  Widget build(BuildContext context) {
    controller.onInit();
    final appLocalizations = AppLocalizations.of(context);
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(
          child: CircularProgressIndicator(
            color: QMSColor.mainorange,
          ),
        );
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
                'Danh sách biên bản chờ phê duyệt',
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
          TableCustom(
            title: {
              Text(''): 1,
              ItemTitleWidget(title: 'Mã yêu cầu IQC'): 4,
              ItemTitleWidget(title: 'Mã PO'): 2,
              ItemTitleWidget(title: 'Loại nhập kho'): 2,
              ItemTitleWidget(title: 'Kho'): 2,
              ItemTitleWidget(title: 'Ngày yêu cầu hết hạn'): 2,
              ItemTitleWidget(title: 'Ngày tạo'): 2,
              ItemTitleWidget(title: 'Thao tác'): 2,
            },
          ),
          Expanded(
            child: ListView.builder(
              itemCount: controller.paginatedController.paginatedItems.length,
              itemBuilder: (BuildContext context, int index) {
                final item =
                    controller.paginatedController.paginatedItems[index];
                return Column(
                  children: [
                    TableCustom(
                      color: Colors.white,
                      title: {
                        Obx(() => CustomButton(
                              text: (!controller.isShow[index]) ? '+' : '-',
                              textColor: Colors.black,
                              borderColor: Colors.white,
                              onPressed: () {
                                controller.showListProduct(index);
                              },
                              backgroundColor: Colors.white,
                            )): 1,
                        ItemBodyWidget(title: item.iqcRequestCode.toString()):
                            4,
                        ItemBodyWidget(title: item.poCode.toString()): 2,
                        ItemBodyWidget(
                          title: item.warehouseType.toString(),
                        ): 2,
                        ItemBodyWidget(
                          title: item.warehouseName.toString(),
                        ): 2,
                        ItemBodyWidget(
                          title: item.dueDate!.formatDateTime(),
                        ): 2,
                        ItemBodyWidget(
                          title: item.createdAt!.formatDateTime(),
                        ): 2,
                        (item.isStatus ?? false)
                            ? SizedBox.shrink()
                            : CustomButtonCircleRow(
                                onApprove: () => controller.approve(index),
                                onReject: () => controller.reject(index),
                              ): 2,
                      },
                    ),
                    Obx(() => Visibility(
                        visible: controller.isShow[index],
                        child: IqcReportList(iqcReportList: item.reports!))),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          BuildPaginationControls<IqcRequestModel>(
            paginatedController: controller.paginatedController,
          ),
          const SizedBox(height: 10),
        ]),
      );
    });
  }
}
