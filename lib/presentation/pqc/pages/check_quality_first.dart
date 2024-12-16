import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:qms_app/common/color.dart';
import 'package:qms_app/common/components/build_pagination_controls.dart';
import 'package:qms_app/common/extensions/date_time_format.dart';
import 'package:qms_app/common/extensions/number_format.dart';
import 'package:qms_app/common/icon_path.dart';
import 'package:qms_app/common/sidebar/controller/sidebar_c.dart';
import 'package:qms_app/models/work_order.dart';
import 'package:qms_app/presentation/pqc/controllers/work_order_c.dart';
import 'package:qms_app/presentation/widgets/add_error.dart';
import 'package:qms_app/presentation/widgets/table_custom.dart';

class CheckQualityFirst extends StatelessWidget {
  const CheckQualityFirst({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    final controller = Get.find<WorkOrderController>();
    final sidebarController = Get.find<SideBarController>();
    controller.onInit();
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
          Expanded(
            child: ListView.builder(
              itemCount: controller.paginatedController.paginatedItems.length,
              itemBuilder: (BuildContext context, int index) {
                final item =
                    controller.paginatedController.paginatedItems[index];
                return TableCustom(
                  color: Colors.white,
                  title: {
                    ItemBodyWidget(title: item.workOrderCode.toString()): 2,
                    ItemBodyWidget(title: item.productId.toString()): 2,
                    ItemBodyWidget(title: item.productName ?? ''): 4,
                    ItemBodyWidget(title: item.quantity.toString()): 2,
                    ItemBodyWidget(
                        title: item.createdAt?.formatDateTime() ?? ''): 2,
                    ItemBodyWidget(
                        title: item.isActive?.formatIsActive() ?? ''): 2,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.info,
                            color: QMSColor.mainorange,
                          ),
                          onPressed: () {
                            print(item
                                .toJson()); // Prints the Map<String, dynamic>
                            sidebarController.changePageWithArguments(
                                'Thông tin lệnh sản xuất',
                                {
                                  'WorkOrderModel': item.toJson(),
                                },
                                WorkOrderType.productOrder);
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.folder_open,
                            color: QMSColor.mainorange,
                          ),
                          onPressed: () {
                            print(item.toJson());
                            sidebarController.changePageWithArguments(
                                'Thông tin lệnh sản xuất',
                                {
                                  'WorkOrderModel': item.toJson(),
                                },
                                WorkOrderType.checkQuanlityFirst);
                          },
                        )
                      ],
                    ): 2,
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          BuildPaginationControls<WorkOrderModel>(
            paginatedController: controller.paginatedController,
          ),
          const SizedBox(height: 10),
        ]),
      );
    });
  }
}
