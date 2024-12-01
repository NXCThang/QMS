import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:qms_app/common/color.dart';
import 'package:qms_app/common/icon_path.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:qms_app/presentation/iqc/controllers/iqc_result_ng_c.dart';
import 'package:qms_app/presentation/widgets/table_custom.dart';

class AddErrorInfo extends StatelessWidget {
  AddErrorInfo({super.key});

  final controller = Get.find<IqcResultNgController>();
  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    return Dialog(
      child: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
              child: CircularProgressIndicator(
            color: QMSColor.mainorange,
          ));
        } else {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border:
                  Border.all(color: Colors.black.withOpacity(0.1), width: 1),
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
                    appLocalizations?.expenseManagement ?? '',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24),
                  )
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Thông tin lỗi',
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
                              'Thêm hàng khai báo',
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
                  ItemTitleWidget(
                    title: 'STT',
                  ): 1,
                  ItemTitleWidget(title: 'Nhóm lỗi'): 3,
                  ItemTitleWidget(title: 'Tên lỗi'): 3,
                  ItemTitleWidget(title: 'Số lượng'): 3,
                  ItemTitleWidget(title: 'Tỉ lệ'): 3,
                  ItemTitleWidget(title: 'Tùy chọn'): 2
                },
              ),
              // Expanded(
              //   child: ListView.builder(
              //     itemCount: controller.paginatedController.paginatedItems.length,
              //     itemBuilder: (BuildContext context, int index) {
              //       final item =
              //           controller.paginatedController.paginatedItems[index];
              //       final stt = index +
              //           1 +
              //           controller.paginatedController.currentPage.value *
              //               controller.paginatedController.itemsPerPage;
              //       return TableCustom(
              //         color: Colors.white,
              //         title: {
              //           ItemBodyWidget(title: '$stt'): 1,
              //           ItemBodyWidget(title: item.id.toString()): 3,
              //           ItemBodyWidget(title: item.acceptanceLimit.toString()): 3,
              //           ItemBodyWidget(title: item.ngLimit.toString()): 3,
              //           ItemBodyWidget(title: item.note.toString()): 3,
              //           CustomButtonRow(onEdit: () {
              //             showDialog(
              //                 context: context,
              //                 builder: (_) => AddAql(
              //                       create: false,
              //                       aql: item,
              //                     ));
              //           }, onDelete: () {
              //             showDialog(
              //                 context: context,
              //                 builder: (_) => ConfirmDeleteAqlPopup(
              //                       aql: item,
              //                     ));
              //           }): 2,
              //         },
              //       );
              //     },
              //   ),
              // ),
              // const SizedBox(height: 10),
              // BuildPaginationControls<AQLModel>(
              //   paginatedController: controller.paginatedController,
              // ),
              // const SizedBox(height: 10),
            ]),
          );
        }
      }),
    );
  }
}
