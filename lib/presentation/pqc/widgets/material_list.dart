import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:qms_app/common/color.dart';
import 'package:qms_app/common/components/build_pagination_controls.dart';
import 'package:qms_app/common/icon_path.dart';
import 'package:qms_app/models/work_order.dart';
import 'package:qms_app/presentation/controllers/material_c.dart';
import 'package:qms_app/presentation/widgets/add_error.dart';
import 'package:qms_app/presentation/widgets/table_custom.dart';

class ListMaterial extends StatelessWidget {
  const ListMaterial({super.key, required this.workOrderModel});
  final WorkOrderModel workOrderModel;
  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);

    return Obx(() {
      // if (controller.isLoading.value) {
      //   return const Center(
      //       child: CircularProgressIndicator(
      //     color: QMSColor.mainorange,
      //   ));
      // }
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
                appLocalizations?.listofProductionOrders ?? '',
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
              ItemTitleWidget(title: 'Mã lệnh sản xuất'): 2,
              ItemTitleWidget(title: 'Mã sản phẩm'): 2,
              ItemTitleWidget(title: 'Tên sản phẩm'): 4,
              ItemTitleWidget(title: 'Số lượng sản xuất'): 2,
              ItemTitleWidget(title: 'Ngày tạo'): 2,
              ItemTitleWidget(title: 'Trạng thái'): 2,
              ItemTitleWidget(title: 'Thao tác'): 2,
            },
          ),
          // Expanded(
          //   child: ListView.builder(
          //     itemCount: controller.paginatedController.paginatedItems.length,
          //     itemBuilder: (BuildContext context, int index) {
          //       final item =
          //           controller.paginatedController.paginatedItems[index];
          //       return TableCustom(
          //         color: Colors.white,
          //         title: {
          //           ItemBodyWidget(title: item.workOrderCode.toString()): 2,
          //           ItemBodyWidget(title: item.productId.toString()): 2,
          //           ItemBodyWidget(title: item.productName ?? ''): 4,
          //           ItemBodyWidget(title: item.quantity.toString()): 2,
          //           ItemBodyWidget(title: item.createdAt!.formatDateTime()): 2,
          //           ItemBodyWidget(title: item.isActive.toString()): 2,
          //           IconButton(
          //             icon: Icon(Icons.info),
          //             onPressed: () {
          //               showDialog(
          //                   context: context,
          //                   builder: (_) => const AddError(
          //                         error: 'Sửa',
          //                       ));
          //             },
          //           ): 2,
          //         },
          //       );
          //     },
          //   ),
          // ),
          // const SizedBox(height: 10),
          // BuildPaginationControls<WorkOrderModel>(
          //   paginatedController: controller.paginatedController,
          // ),
          // const SizedBox(height: 10),
        ]),
      );
    });
  }
}
