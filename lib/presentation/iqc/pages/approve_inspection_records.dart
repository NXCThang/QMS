import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:qms_app/common/color.dart';
import 'package:qms_app/common/components/two_button_circle.dart';
import 'package:qms_app/common/extensions/date_time_format.dart';
import 'package:qms_app/common/icon_path.dart';
import 'package:qms_app/presentation/controllers/iqc_request_c.dart';
import 'package:qms_app/presentation/widgets/add_error.dart';
import 'package:qms_app/presentation/widgets/table_custom.dart';

class ApproveInspectionRecords extends StatelessWidget {
  ApproveInspectionRecords({super.key});
  final controller = Get.find<IqcRequestController>();

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
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
              appLocalizations?.approveInspectionRecords ?? '',
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
            itemCount: controller.IqcRequestList.length,
            itemBuilder: (BuildContext context, int index) {
              return TableCustom(
                color: Colors.white,
                title: {
                  ItemBodyWidget(title: '+'): 1,
                  ItemBodyWidget(
                      title: controller.IqcRequestList[index].iqcRequestCode
                          .toString()): 4,
                  ItemBodyWidget(
                      title: controller.IqcRequestList[index].poCode
                          .toString()): 2,
                  ItemBodyWidget(
                    title: controller.IqcRequestList[index].warehouseType
                        .toString(),
                  ): 2,
                  ItemBodyWidget(
                    title: controller.IqcRequestList[index].warehouseName
                        .toString(),
                  ): 2,
                  ItemBodyWidget(
                    title: controller.IqcRequestList[index].dueDate!
                        .formatDateTime(),
                  ): 2,
                  ItemBodyWidget(
                    title: controller.IqcRequestList[index].createdAt!
                        .formatDateTime(),
                  ): 2,
                  CustomButtonCircleRow(
                    onApprove: () {},
                    onReject: () {},
                  ): 2
                },
              );
            },
          ),
        ),
      ]),
    );
  }
}
