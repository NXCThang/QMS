import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:qms_app/common/color.dart';
import 'package:qms_app/common/icon_path.dart';
import 'package:qms_app/common/sidebar/widgets/side_bar.dart';
import 'package:qms_app/common/components/two_button.dart';
import 'package:qms_app/presentation/category_manage/controllers/aql_c.dart';
import 'package:qms_app/presentation/widgets/add_error.dart';
import 'package:qms_app/presentation/widgets/table_custom.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ExpensePage extends StatelessWidget {
  ExpensePage({super.key});
  final controller = Get.find<AQLController>();

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
                  appLocalizations?.expenseManagement ?? '',
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
                  label: appLocalizations?.testLevel ?? '',
                  width: 300,
                  hintText: appLocalizations?.testLevel ?? '',
                ),
                TextFieldCustom(
                  label: appLocalizations?.acceptanceLevel ?? '',
                  width: 300,
                  hintText: appLocalizations?.acceptanceLevel ?? '',
                ),
                TextFieldCustom(
                  label: appLocalizations?.allowableDefects ?? '',
                  width: 300,
                  hintText: appLocalizations?.allowableDefects ?? '',
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
                ItemTitleWidget(
                  title: '#',
                ): 1,
                ItemTitleWidget(title: 'Mức kiểm tra'): 3,
                ItemTitleWidget(title: 'Mức chấp nhận'): 3,
                ItemTitleWidget(title: 'Lỗi cho phép'): 3,
                ItemTitleWidget(title: 'Ghi chú'): 3,
                ItemTitleWidget(title: 'Tùy chọn'): 2
              },
            ),
            Expanded(
              child: ListView.builder(
                itemCount: controller.aqlList.length,
                itemBuilder: (BuildContext context, int index) {
                  return TableCustom(
                    color: Colors.white,
                    title: {
                      ItemBodyWidget(title: '$index'): 1,
                      ItemBodyWidget(
                          title: controller.aqlList[index].id.toString()): 3,
                      ItemBodyWidget(
                          title: controller.aqlList[index].acceptanceLimit
                              .toString()): 3,
                      ItemBodyWidget(
                          title:
                              controller.aqlList[index].ngLimit.toString()): 3,
                      ItemBodyWidget(
                          title: controller.aqlList[index].note.toString()): 3,
                      CustomButtonRow(onEdit: () {}, onDelete: () {}): 2,
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            // Pagination controls
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     IconButton(
            //       icon: Icon(Icons.arrow_left),
            //       onPressed: controller.currentPage > 1
            //           ? () => controller.previousPage()
            //           : null,
            //     ),
            //     Text(
            //       '${controller.currentPage}',
            //       style: const TextStyle(
            //         fontSize: 18,
            //         fontWeight: FontWeight.w500,
            //         color: Colors.blue,
            //       ),
            //     ),
            //     IconButton(
            //       icon: Icon(Icons.arrow_right),
            //       onPressed: controller.hasMorePages()
            //           ? () => controller.nextPage()
            //           : null,
            //     ),
            //     const SizedBox(width: 20),
            //     DropdownButton<int>(
            //       value: controller.itemsPerPage.value,
            //       items: [10, 20, 30, 50]
            //           .map(
            //             (e) => DropdownMenuItem<int>(
            //               value: e,
            //               child: Text('$e / page'),
            //             ),
            //           )
            //           .toList(),
            //       onChanged: (value) {
            //         if (value != null) {
            //           controller.updateItemsPerPage(value);
            //         }
            //       },
            //     ),
            //   ],
            // ),

            const SizedBox(height: 10),
          ]),
        );
      }
    });
  }
}