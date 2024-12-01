import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:qms_app/common/color.dart';
import 'package:qms_app/common/components/build_pagination_controls.dart';
import 'package:qms_app/common/components/paginated_c.dart';
import 'package:qms_app/common/components/two_button.dart';
import 'package:qms_app/common/icon_path.dart';
import 'package:qms_app/models/iqc_result.dart';
import 'package:qms_app/presentation/category_manage/widgets/add_criteria.dart';
import 'package:qms_app/presentation/category_manage/controllers/iqc_result_c.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:qms_app/presentation/category_manage/widgets/confirm_delete_iqc.dart';
import 'package:qms_app/presentation/widgets/table_custom.dart';

class IqcResultList extends StatelessWidget {
  IqcResultList({super.key});
  final controller = Get.find<IqcResultController>();

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(
            child: CircularProgressIndicator(
          color: QMSColor.mainorange,
        ));
      } else {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black.withOpacity(0.1), width: 1),
          ),
          margin:
              const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  appLocalizations?.editTemplate ?? '',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Thông tin tiêu chí (${controller.iqcResultList.length})',
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
                            builder: (_) => AddCriteria(
                                  create: true,
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
                ItemTitleWidget(title: '#'): 1,
                ItemTitleWidget(title: 'Tiêu chí'): 3,
                ItemTitleWidget(title: 'Min'): 2,
                ItemTitleWidget(title: 'Max'): 2,
                ItemTitleWidget(title: 'Đơn vị'): 2,
                ItemTitleWidget(title: 'Nội dung lưu ý'): 6,
                ItemTitleWidget(title: 'Tùy chọn'): 2
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
                      ItemBodyWidget(
                        title: '$stt',
                      ): 1,
                      ItemBodyWidget(
                        title: item.criteriaName.toString(),
                      ): 3,
                      ItemBodyWidget(
                        title: item.min.toString(),
                      ): 2,
                      ItemBodyWidget(
                        title: item.max.toString(),
                      ): 2,
                      ItemBodyWidget(
                        title: item.unit.toString(),
                      ): 2,
                      ItemBodyWidget(
                        title: item.note.toString(),
                      ): 6,
                      CustomButtonRow(
                        onDelete: () {
                          showDialog(
                              context: context,
                              builder: (_) => DeleteIQCPopup(
                                    iqcResult: item,
                                  ));
                        },
                        onEdit: () {
                          showDialog(
                              context: context,
                              builder: (_) => AddCriteria(
                                    create: false,
                                    id: item.id,
                                    criteriaName: controller
                                        .iqcResultList[index].criteriaName,
                                    minValue: controller
                                        .iqcResultList[index].min
                                        .toString(),
                                    maxValue: controller
                                        .iqcResultList[index].max
                                        .toString(),
                                    unit: item.unit,
                                    note: item.note,
                                  ));
                        },
                      ): 2
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            BuildPaginationControls<IQCResultModel>(
              paginatedController: controller.paginatedController,
            ),
            const SizedBox(height: 10),
          ]),
        );
      }
    });
  }
}
