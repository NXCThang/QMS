import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:qms_app/common/color.dart';
import 'package:qms_app/common/components/build_pagination_controls.dart';
import 'package:qms_app/common/extensions/date_time_format.dart';
import 'package:qms_app/common/icon_path.dart';
import 'package:qms_app/common/sidebar/controller/sidebar_c.dart';
import 'package:qms_app/models/oqc_info.dart';
import 'package:qms_app/models/work_order.dart';
import 'package:qms_app/presentation/oqc/controllers/oqc_info_c.dart';
import 'package:qms_app/presentation/oqc/controllers/sell_order_c.dart';
import 'package:qms_app/presentation/pqc/controllers/work_order_c.dart';
import 'package:qms_app/presentation/widgets/add_error.dart';
import 'package:qms_app/presentation/widgets/table_custom.dart';
import 'package:qms_app/common/extensions/number_format.dart';

class ApprovalStock extends StatelessWidget {
  const ApprovalStock({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    final workOrderController = Get.find<WorkOrderController>();
    final sidebarController = Get.find<SideBarController>();
    final oqcInfoController = Get.find<OqcInfoController>();
    final sellOrderController = Get.find<SellOrderController>();
    oqcInfoController.onInit();
    return Obx(() {
      if (oqcInfoController.isLoading.value) {
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
                'Danh sách yêu cầu nhập kho',
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
              // TextFieldCustom(
              //   label: appLocalizations?.minutesTemplateName ?? '',
              //   width: 300,
              //   hintText: appLocalizations?.minutesTemplateName ?? '',
              // ),
              // TextFieldCustom(
              //   label: appLocalizations?.minutesTemplateType ?? '',
              //   width: 300,
              // ),
              // TextFieldCustom(
              //   label: appLocalizations?.minutesTemplateCode ?? '',
              //   width: 300,
              //   hintText: appLocalizations?.minutesTemplateCode ?? '',
              // ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const SizedBox(
            height: 0,
          ),
          TableCustom(
            title: {
              ItemTitleWidget(title: 'Mã lệnh sản xuất'): 2,
              ItemTitleWidget(title: 'Mã sản phẩm'): 2,
              ItemTitleWidget(title: 'Tên sản phẩm'): 4,
              ItemTitleWidget(title: 'Mã đơn hàng'): 3,
              ItemTitleWidget(title: 'Ngày tạo'): 2,
              ItemTitleWidget(title: 'Trạng thái'): 2,
              ItemTitleWidget(title: 'Thao tác'): 2,
            },
          ),
          Expanded(
            child: ListView.builder(
                itemCount:
                    oqcInfoController.paginatedController.paginatedItems.length,
                itemBuilder: (BuildContext context, int index) {
                  final item = oqcInfoController
                      .paginatedController.paginatedItems[index];
                  final int workOrderId = item.workOrderId ?? 0;
                  final order = workOrderController.workorderList[workOrderId];

                  return TableCustom(
                    color: Colors.white,
                    title: {
                      ItemBodyWidget(title: order.workOrderCode.toString()): 2,
                      ItemBodyWidget(title: item.model.toString()): 2,
                      ItemBodyWidget(title: order.productName ?? ''): 4,
                      ItemBodyWidget(
                          title: sellOrderController.sellOrderList[index].soCode
                              .toString()): 3,
                      ItemBodyWidget(
                          title: item.createdAt?.formatDateTime() ?? ''): 2,
                      (item.status?.trim().toLowerCase() == 'đã duyệt')
                          ? Container(
                              decoration: BoxDecoration(
                                  color: Colors.green.withOpacity(0.3),
                                  border: Border.all(color: Colors.green)),
                              padding: EdgeInsets.all(2),
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              child: Center(
                                child: Text(
                                  item.status ?? '',
                                  style: TextStyle(color: Colors.green),
                                ),
                              ),
                            )
                          : Container(
                              decoration: BoxDecoration(
                                  color: Colors.blue.withOpacity(0.3),
                                  border: Border.all(color: Colors.blue)),
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              padding: EdgeInsets.all(2),
                              child: Center(
                                child: Text(
                                  item.status ?? '',
                                  style: TextStyle(color: Colors.blue),
                                ),
                              ),
                            ): 2,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.info,
                              color: QMSColor.mainorange,
                            ),
                            onPressed: () {
                              sidebarController.changePageWithArguments(
                                  'Khai báo thông tin kiểm tra chất lượng công đoạn OQC',
                                  {
                                    'OQCInfoModel': item.toJson(),
                                  },
                                  null,
                                  false);
                            },
                          ),
                        ],
                      ): 2,
                    },
                  );
                }),
          ),
          const SizedBox(height: 10),
          BuildPaginationControls<OQCInfoModel>(
            paginatedController: oqcInfoController.paginatedController,
          ),
          const SizedBox(height: 10),
        ]),
      );
    });
  }
}
