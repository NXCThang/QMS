import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:qms_app/common/color.dart';
import 'package:qms_app/common/components/build_pagination_controls.dart';
import 'package:qms_app/common/extensions/date_time_format.dart';
import 'package:qms_app/common/extensions/number_format.dart';
import 'package:qms_app/common/icon_path.dart';
import 'package:qms_app/common/sidebar/controller/sidebar_c.dart';
import 'package:qms_app/models/iqc_report.dart';
import 'package:qms_app/models/iqc_request.dart';
import 'package:qms_app/models/iqc_result.dart';
import 'package:qms_app/models/material.dart';
import 'package:qms_app/models/pqc_final_result.dart';
import 'package:qms_app/models/pqc_first_info.dart';
import 'package:qms_app/models/work_order.dart';
import 'package:qms_app/presentation/category_manage/controllers/iqc_result_c.dart';
import 'package:qms_app/presentation/category_manage/widgets/iqc_result_list.dart';
import 'package:qms_app/presentation/category_manage/widgets/textfield_custom.dart';
import 'package:qms_app/presentation/controllers/material_c.dart';
import 'package:qms_app/presentation/iqc/controllers/iqc_report_c.dart';
import 'package:qms_app/presentation/iqc/widgets/add_error_info.dart';
import 'package:qms_app/presentation/iqc/widgets/conclusion.dart';
import 'package:qms_app/presentation/iqc/widgets/iqc_result_list.dart';
import 'package:qms_app/presentation/pqc/controllers/work_order_c.dart';
import 'package:qms_app/presentation/widgets/table_custom.dart';

class ProductOrderDetail extends StatefulWidget {
  ProductOrderDetail(
      {super.key, required this.workOrderModel, required this.type});

  final PQCType type;
  final WorkOrderModel workOrderModel;
  @override
  State<ProductOrderDetail> createState() => _ProductOrderDetailState();
}

class _ProductOrderDetailState extends State<ProductOrderDetail> {
  late TextEditingController productCodeController = TextEditingController();
  late TextEditingController productNameController = TextEditingController();
  late TextEditingController workOrderCodeController = TextEditingController();
  late TextEditingController createdAtController = TextEditingController();
  late TextEditingController startDateController = TextEditingController();
  late TextEditingController dueDateController = TextEditingController();
  late TextEditingController quantityController = TextEditingController();
  final controller = Get.find<MaterialController>();
  final iqcResultController = Get.find<IqcResultController>();
  final sidebarController = Get.find<SideBarController>();
  var iqcReportController = Get.find<IqcReportController>();
  @override
  void initState() {
    print(widget.workOrderModel);
    productCodeController.text = widget.workOrderModel.productId.toString();
    productNameController.text = widget.workOrderModel.productName.toString();
    workOrderCodeController.text =
        widget.workOrderModel.workOrderCode.toString();
    quantityController.text = widget.workOrderModel.quantity.toString();
    createdAtController.text =
        widget.workOrderModel.createdAt?.formatDateTime() ?? '';
    startDateController.text =
        widget.workOrderModel.startDate?.formatDateTime() ?? '';
    dueDateController.text =
        widget.workOrderModel.dueDate?.formatDateTime() ?? '';
    // checkDateController.text = widget.iqcReportModel?.checkDate ?? '';
    // billNumberController.text =
    //     widget.iqcReportModel?.billNumber.toString() ?? '';
    // quantityController.text = widget.iqcReportModel?.quantity.toString() ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isEditable = true;
    print('type: ${widget.type}');
    // final appLocalizations = AppLocalizations.of(context);

    // widget.workOrderModel.isActive?.toLowerCase() == 'Nháp'.toLowerCase();

    return Obx(() {
      if (iqcReportController.isLoading.value) {
        return CircularProgressIndicator(
          color: QMSColor.mainorange,
        );
      } else {
        return Scaffold(
          body: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border:
                  Border.all(color: Colors.black.withOpacity(0.1), width: 1),
            ),
            margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Thông tin lệnh sản xuất',
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 24),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        TextFieldCustom(
                          width: 320,
                          label: 'Mã sản phẩm',
                          textcontroller: productCodeController,
                          enabled: false,
                        ),
                        TextFieldCustom(
                            width: 320,
                            label: 'Tên sản phẩm',
                            textcontroller: productNameController,
                            enabled: false),
                        TextFieldCustom(
                            width: 320,
                            label: 'Version',
                            textcontroller: TextEditingController(),
                            enabled: false),
                      ],
                    ),
                    Row(
                      children: [
                        TextFieldCustom(
                            width: 320,
                            label: 'Mã lệnh sản xuất',
                            textcontroller: workOrderCodeController,
                            enabled: false),
                        TextFieldCustom(
                            width: 320,
                            label: 'Số lượng sản xuất',
                            textcontroller: quantityController,
                            enabled: false),
                        TextFieldCustom(
                            width: 320,
                            label: 'Mã đơn hàng',
                            textcontroller: TextEditingController(),
                            enabled: false),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    if (widget.type == PQCType.productOrder)
                      _material(items: widget.workOrderModel.materials ?? []),
                    if (widget.type == PQCType.checkQuanlityFirst)
                      _checkQualityFirst(
                          items: widget.workOrderModel.pqcFirstInfos ?? []),
                    if (widget.type == PQCType.checkQuality)
                      _checkQuality(
                          items: widget.workOrderModel.pqcFinalResults ?? [],
                          workOrderModel: widget.workOrderModel),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            sidebarController
                                .changePage('Danh sách lệnh sản xuất');
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: QMSColor.mainorange,
                                border: Border.all(
                                    color: Colors.black.withOpacity(0.1),
                                    width: 1),
                                borderRadius: BorderRadius.circular(2)),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            child: const Text(
                              'Trở lại',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ]),
            ),
          ),
        );
      }
    });
  }

  Widget _checkQualityFirst({required List<PQCFirstInfoModel> items}) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Thông tin kiểm tra chất lượng sản phẩm đầu',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
            ),
            const Spacer(),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.all(0),
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    sidebarController.changePageWithArguments(
                      'Khai báo thông tin kiểm tra chất lượng sản phẩm đầu',
                      {
                        'WorkOrderModel': widget.workOrderModel.toJson(),
                      },
                    );
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
                        'Khai báo thông tin kiểm tra',
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
          height: 10,
        ),
        TableCustom(
          title: {
            ItemTitleWidget(title: 'STT'): 1,
            ItemTitleWidget(title: 'Người thực hiện'): 3,
            ItemTitleWidget(title: 'Ngày thực hiện'): 3,
            ItemTitleWidget(title: 'Model'): 3,
            ItemTitleWidget(title: 'Loại kiểm tra'): 2,
            ItemTitleWidget(title: 'Số lượng kiểm tra'): 2,
            ItemTitleWidget(title: 'Thời gian kiểm tra'): 2,
            ItemTitleWidget(title: 'Kết luận'): 2,
            ItemTitleWidget(title: 'Ghi chú'): 2,
            ItemTitleWidget(title: 'Thao tác'): 2,
          },
        ),
        SizedBox(
          height: 100 + items.length * 50.0,
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (BuildContext context, int index) {
              var item = items[index];
              var stt = index + 1;
              return TableCustom(
                color: Colors.white,
                title: {
                  ItemBodyWidget(title: stt.toString()): 1,
                  ItemBodyWidget(title: item.createdBy.toString()): 3,
                  ItemBodyWidget(title: item.createdAt?.formatDateTime() ?? ''):
                      3,
                  ItemBodyWidget(title: item.model.toString()): 3,
                  ItemBodyWidget(title: item.type.toString()): 2,
                  ItemBodyWidget(title: item.quantity.toString()): 2,
                  ItemBodyWidget(title: item.createdAt?.formatDateTime() ?? ''):
                      2,
                  ItemBodyWidget(
                      title: item.conclusion?.formatConclusion() ?? ''): 2,
                  ItemBodyWidget(title: item.note.toString()): 2,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                          onPressed: () {
                            sidebarController.changePageWithArguments(
                              'Khai báo thông tin kiểm tra chất lượng sản phẩm đầu',
                              {
                                'WorkOrderModel':
                                    widget.workOrderModel.toJson(),
                              },
                            );
                          },
                          icon: Icon(
                            Icons.info,
                            color: QMSColor.mainorange,
                          )),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.delete_outline,
                            color: Colors.red,
                          )),
                    ],
                  ): 2,
                },
              );
            },
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}

Widget _material({required List<MaterialModel> items}) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'Thông tin nguyên vật liệu',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
          )
        ],
      ),
      const SizedBox(
        height: 10,
      ),
      TableCustom(
        title: {
          ItemTitleWidget(title: 'STT'): 1,
          ItemTitleWidget(title: 'Mã vật tư'): 3,
          ItemTitleWidget(title: 'Tên vật tư'): 3,
          ItemTitleWidget(title: 'Partnumber'): 3,
          ItemTitleWidget(title: 'Số lượng yêu cầu'): 2,
          ItemTitleWidget(title: 'Nhà cung cấp'): 2,
        },
      ),
      SizedBox(
        height: 100 + items.length * 50.0,
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (BuildContext context, int index) {
            var item = items[index];
            return TableCustom(
              color: Colors.white,
              title: {
                ItemBodyWidget(title: item.id.toString()): 1,
                ItemBodyWidget(title: item.materialCode.toString()): 3,
                ItemBodyWidget(title: item.materialName.toString()): 3,
                ItemBodyWidget(title: item.partNumber.toString()): 3,
                ItemBodyWidget(title: item.quantity.toString()): 2,
                ItemBodyWidget(title: item.provider.toString()): 2,
              },
            );
          },
        ),
      ),
      const SizedBox(
        height: 10,
      ),
    ],
  );
}

Widget _checkQuality(
    {required List<PQCFinalResultModel> items,
    required WorkOrderModel workOrderModel}) {
  var sidebarController = Get.find<SideBarController>();
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'Thông tin kiểm tra chất lượng sản phẩm',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
          ),
          const Spacer(),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.all(0),
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  sidebarController.changePageWithArguments(
                    'Thêm mới thông tin yêu cầu (Thông tin sản xuất)',
                    {
                      'WorkOrderModel': workOrderModel.toJson(),
                    },
                  );
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
                      'Thêm mới yêu cầu kiểm tra',
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
        height: 10,
      ),
      TableCustom(
        title: {
          ItemTitleWidget(title: 'STT'): 1,
          ItemTitleWidget(title: 'Người thực hiện'): 3,
          ItemTitleWidget(title: 'Ngày thực hiện'): 3,
          ItemTitleWidget(title: 'Tổng số lượng'): 2,
          ItemTitleWidget(title: 'Bộ phận gửi yêu cầu'): 2,
          ItemTitleWidget(title: 'Ghi chú'): 2,
          ItemTitleWidget(title: 'Thao tác'): 2,
        },
      ),
      SizedBox(
        height: 100 + items.length * 50.0,
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (BuildContext context, int index) {
            var item = items[index];
            var stt = index + 1;
            return TableCustom(
              color: Colors.white,
              title: {
                ItemBodyWidget(title: stt.toString()): 1,
                ItemBodyWidget(title: item.createdBy.toString()): 3,
                ItemBodyWidget(title: item.createdAt?.formatDateTime() ?? ''):
                    3,
                ItemBodyWidget(title: item.totalQuantity.toString()): 2,
                ItemBodyWidget(title: item.requestStage.toString()): 2,
                ItemBodyWidget(title: item.note.toString()): 2,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.info,
                          color: QMSColor.mainorange,
                        )),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.delete_outline,
                          color: Colors.red,
                        )),
                  ],
                ): 2,
              },
            );
          },
        ),
      ),
      const SizedBox(
        height: 10,
      ),
    ],
  );
}
