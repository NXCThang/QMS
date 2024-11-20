import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:qms_app/common/color.dart';
import 'package:qms_app/common/icon_path.dart';
import 'package:qms_app/presentation/report/controllers/report_ng_ok_c.dart';
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
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextFieldCustom(
                label: appLocalizations?.minutesTemplateName ?? '',
                width: 300,
                hintText: appLocalizations?.minutesTemplateName ?? '',
              ),
              TextFieldCustom(
                label: appLocalizations?.minutesTemplateType ?? '',
                width: 300,
              ),
              TextFieldCustom(
                label: appLocalizations?.minutesTemplateCode ?? '',
                width: 300,
                hintText: appLocalizations?.minutesTemplateCode ?? '',
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Danh sách yêu cầu IQC(10)',
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
              ),
              const Spacer(),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.all(0),
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (_) => const AddError(
                                error: 'Thêm mới',
                              ));
                    },
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          IconPath.addNew,
                          width: 18,
                          height: 18,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        const Text(
                          'Thêm mới',
                          style: TextStyle(
                              color: QMSColor.mainorange,
                              fontSize: 18,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
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
              ItemTitleWidget(title: 'Sản lượng kế hoạch'): 2,
              ItemTitleWidget(title: 'Tổng số lượng nhập kho'): 2,
              ItemTitleWidget(title: 'Số lượng OK'): 2,
              ItemTitleWidget(title: 'Số lượng NG'): 2,
              ItemTitleWidget(title: 'Tỉ lệ NG/OK'): 2,
              ItemTitleWidget(title: 'Trạng thái'): 2,
            },
          ),
          Expanded(
            child: ListView.builder(
              itemCount: controller.reportList.length,
              itemBuilder: (BuildContext context, int index) {
                var okQuantity =
                    controller.reportList[index].oqcResultModel?.testQuantity ??
                        0 -
                            (controller.reportList[index].oqcResultModel
                                    ?.nGQuantity ??
                                0);
                return TableCustom(
                  color: Colors.white,
                  title: {
                    ItemBodyWidget(title: '$index'.toString()): 1,
                    ItemBodyWidget(
                        title: controller
                                .reportList[index].workOrderModel?.productId
                                .toString() ??
                            ''): 2,
                    ItemBodyWidget(
                        title: controller
                                .reportList[index].workOrderModel?.productName
                                .toString() ??
                            ''): 4,
                    ItemBodyWidget(
                        title: controller.reportList[index].workOrderModel?.id
                                .toString() ??
                            ''): 2,
                    ItemBodyWidget(
                        title: controller
                                .reportList[index].workOrderModel?.startDate ??
                            ''): 2,
                    ItemBodyWidget(
                        title: controller
                                .reportList[index].workOrderModel?.dueDate ??
                            ''): 2,
                    ItemBodyWidget(
                        title: controller
                                .reportList[index].workOrderModel?.quantity
                                .toString() ??
                            ''): 2,
                    ItemBodyWidget(
                        title: controller
                                .reportList[index].oqcResultModel?.totalQuantity
                                .toString() ??
                            ''): 2,
                    ItemBodyWidget(title: (okQuantity).toString()): 2,
                    ItemBodyWidget(
                        title: controller
                                .reportList[index].oqcResultModel?.nGQuantity
                                .toString() ??
                            ''): 2,
                    ItemBodyWidget(
                        title: (controller.reportList[index].oqcResultModel
                                    ?.nGQuantity ??
                                0 / okQuantity)
                            .toString()): 2,
                    ItemBodyWidget(
                        title: (controller
                                .reportList[index].oqcResultModel?.isActive)
                            .toString()): 2,
                  },
                );
              },
            ),
          ),
        ]),
      );
    });
  }
}
