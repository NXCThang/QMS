import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:qms_app/common/color.dart';
import 'package:qms_app/common/icon_path.dart';
import 'package:qms_app/presentation/category_manage/controllers/iqc_result_c.dart';
import 'package:qms_app/presentation/controllers/material_c.dart';
import 'package:qms_app/presentation/widgets/table_custom.dart';

class IcSfpReports extends StatelessWidget {
  const IcSfpReports({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    final controller = Get.find<MaterialController>();
    final iqcResultController = Get.find<IqcResultController>();
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
              'Danh sách biên bản NVL',
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
                  onTap: () {},
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
        const Text(
          'Thông tin tiêu chí',
          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
        ),
        const SizedBox(
          height: 10,
        ),
        TableCustom(
          title: {
            ItemTitleWidget(title: 'Tiêu chí'): 1,
            ItemTitleWidget(title: 'Min'): 4,
            ItemTitleWidget(title: 'Max'): 2,
            ItemTitleWidget(title: 'Đơn vị'): 2,
            ItemTitleWidget(title: 'Nội dung lưu ý'): 2,
            ItemTitleWidget(title: 'Yêu cầu khác'): 2,
            ItemTitleWidget(title: 'Số lượng'): 2
          },
        ),
        Expanded(
          child: ListView.builder(
            itemCount:
                iqcResultController.paginatedController.paginatedItems.length,
            itemBuilder: (BuildContext context, int index) {
              final item =
                  iqcResultController.paginatedController.paginatedItems[index];
              return Column(
                children: [
                  TableCustom(
                    color: Colors.white,
                    title: {
                      // Obx(() => CustomButton(
                      //       text: (!controller.isShow[index]) ? '+' : '-',
                      //       textColor: Colors.black,
                      //       borderColor: Colors.white,
                      //       onPressed: () {
                      //         controller.showListProduct(index);
                      //       },
                      //       backgroundColor: Colors.white,
                      //     )): 1,
                      ItemBodyWidget(title: item.criteriaName.toString()): 4,
                      ItemBodyWidget(title: item.min.toString()): 2,
                      ItemBodyWidget(
                        title: item.max.toString(),
                      ): 2,
                      ItemBodyWidget(
                        title: item.unit.toString(),
                      ): 2,
                      ItemBodyWidget(
                        title: item.note.toString(),
                      ): 2,
                      ItemBodyWidget(
                        title: item.otherRequirement.toString(),
                      ): 2,
                      ItemBodyWidget(
                        title: item.quantity.toString(),
                      ): 2,
                    },
                  ),
                  // Obx(() => Visibility(
                  //     visible: controller.isShow[index],
                  //     child: IqcReportList(iqcReportList: item.reports!))),
                ],
              );
            },
          ),
        ),
        // const SizedBox(height: 10),
        // BuildPaginationControls<IqcRequestModel>(
        //   paginatedController: controller.paginatedController,
        // ),
        // const SizedBox(height: 10),
      ]),
    );
  }
}
