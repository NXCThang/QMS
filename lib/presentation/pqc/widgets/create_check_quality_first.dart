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
import 'package:qms_app/data/local/login_session.dart';
import 'package:qms_app/models/iqc_report.dart';
import 'package:qms_app/models/iqc_request.dart';
import 'package:qms_app/models/iqc_result.dart';
import 'package:qms_app/models/material.dart';
import 'package:qms_app/models/pqc_final_result.dart';
import 'package:qms_app/models/pqc_first_info.dart';
import 'package:qms_app/models/pqc_first_problem.dart';
import 'package:qms_app/models/pqc_first_result.dart';
import 'package:qms_app/models/work_order.dart';
import 'package:qms_app/presentation/category_manage/widgets/textfield_custom.dart';
import 'package:qms_app/presentation/controllers/material_c.dart';
import 'package:qms_app/presentation/iqc/controllers/iqc_report_c.dart';
import 'package:qms_app/presentation/iqc/widgets/conclusion.dart';
import 'package:qms_app/presentation/pqc/controllers/pqc_first_info_c.dart';
import 'package:qms_app/presentation/pqc/controllers/pqc_first_problem_c.dart';
import 'package:qms_app/presentation/pqc/controllers/pqc_first_result_c.dart';
import 'package:qms_app/presentation/pqc/controllers/work_order_c.dart';
import 'package:qms_app/presentation/pqc/widgets/list_pqc_first_problem.dart';
import 'package:qms_app/presentation/pqc/widgets/list_pqc_first_result.dart';
import 'package:qms_app/presentation/widgets/table_custom.dart';

class CreateCheckQualityFirst extends StatefulWidget {
  CreateCheckQualityFirst(
      {super.key, required this.workOrderModel, this.isEditable = true});

  final WorkOrderModel workOrderModel;
  bool? isEditable;
  @override
  State<CreateCheckQualityFirst> createState() =>
      _CreateCheckQualityFirstState();
}

class _CreateCheckQualityFirstState extends State<CreateCheckQualityFirst> {
  late TextEditingController productCodeController = TextEditingController();
  late TextEditingController productNameController = TextEditingController();
  late TextEditingController workOrderCodeController = TextEditingController();
  late TextEditingController createdAtController = TextEditingController();
  late TextEditingController startDateController = TextEditingController();
  late TextEditingController dueDateController = TextEditingController();
  late TextEditingController quantityController = TextEditingController();
  late TextEditingController modelController = TextEditingController();
  late TextEditingController typeController = TextEditingController();
  late TextEditingController updateAtController = TextEditingController();
  late TextEditingController pqcController = TextEditingController();
  late TextEditingController productionManagerController =
      TextEditingController();
  late TextEditingController qcLeaderController = TextEditingController();
  late TextEditingController noteController = TextEditingController();
  int? conclusionValue;

  @override
  void initState() {
    print(widget.workOrderModel);
    productCodeController.text = widget.workOrderModel.productId.toString();
    productNameController.text = widget.workOrderModel.productName.toString();
    workOrderCodeController.text =
        widget.workOrderModel.workOrderCode.toString();
    createdAtController.text =
        widget.workOrderModel.createdAt?.formatDateTime() ?? '';
    startDateController.text =
        widget.workOrderModel.startDate?.formatDateTime() ?? '';
    dueDateController.text =
        widget.workOrderModel.dueDate?.formatDateTime() ?? '';
    createdAtController.text =
        DateTime.now().toIso8601String().formatDateTime();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    final controller = Get.find<MaterialController>();
    final sidebarController = Get.find<SideBarController>();
    var iqcReportController = Get.find<IqcReportController>();
    final pqcFirstInfoController = Get.find<PqcFirstInfoController>();
    final pqcFirstResultController = Get.find<PqcFirstResultController>();
    final pqcFirstProblemController = Get.find<PqcFirstProblemController>();
    String? selectedType;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black.withOpacity(0.1), width: 1),
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
                      'Khai báo thông tin kiểm tra chất lượng sản phẩm đầu',
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 24),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    TextFieldCustom(
                      width: 265,
                      label: 'Ngày thực hiện',
                      textcontroller: createdAtController,
                      enabled: false,
                    ),
                    TextFieldCustom(
                        width: 265,
                        label: 'Lệnh sản xuất',
                        textcontroller: workOrderCodeController,
                        enabled: false),
                    TextFieldCustom(
                        width: 265,
                        label: 'Model',
                        textcontroller: modelController,
                        enabled: widget.isEditable),
                    TextFieldCustom(
                        width: 265,
                        label: 'Số lượng kiểm tra',
                        textcontroller: quantityController,
                        enabled: widget.isEditable),
                  ],
                ),
                SizedBox(
                  height: 4,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Loại kiểm tra',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Colors.black.withOpacity(0.7),
                          ),
                        ),
                        Container(
                          width: 260,
                          height: 32,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.black.withOpacity(0.5), width: 1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: DropdownButton<String>(
                            isExpanded: true,
                            underline: SizedBox.shrink(),
                            value: pqcFirstInfoController.pqcFirstInfoList
                                    .map((e) => e.type)
                                    .contains(typeController.text)
                                ? typeController.text
                                : null,
                            hint: const Text('Chọn Nhóm Lỗi'),
                            items: pqcFirstInfoController.pqcFirstInfoList
                                .map((e) => e.type)
                                .where((type) => type != null)
                                .toSet()
                                .map((type) => DropdownMenuItem<String>(
                                      value: type,
                                      child: Text(type ?? ''),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                typeController.text = value ?? '';
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 24,
                    ),
                    TextFieldCustom(
                        width: 260,
                        label: 'Thời gian kiểm tra',
                        textcontroller: updateAtController,
                        enabled: widget.isEditable),
                    SizedBox(
                      width: 8,
                    ),
                    TextFieldCustom(
                        width: 260,
                        label: 'Ghi chú',
                        textcontroller: noteController,
                        enabled: widget.isEditable),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                ListPqcFirstResult(),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Thông tin ghi nhận vấn đề',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
                    )
                  ],
                ),
                PQCFirstProblemListTemporary(),
                // TableCustom(
                //   title: {
                //     ItemTitleWidget(title: 'STT'): 1,
                //     ItemTitleWidget(title: 'Ngày kiểm tra'): 3,
                //     ItemTitleWidget(title: 'Vấn đề'): 3,
                //     ItemTitleWidget(title: 'Phương án khắc phục'): 2,
                //     ItemTitleWidget(title: 'Thao tác'): 2,
                //   },
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Thông tin phê duyệt',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextFieldCustom(
                        width: 500,
                        label: 'PQC',
                        textcontroller: pqcController,
                        enabled: widget.isEditable),
                    TextFieldCustom(
                        width: 500,
                        label: 'QC leader',
                        textcontroller: qcLeaderController,
                        enabled: widget.isEditable),
                  ],
                ),
                ConclusionWidget(
                  onChanged: (value) {
                    setState(() {
                      conclusionValue = value;
                    });
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        sidebarController.changePageWithArguments(
                            'Thông tin lệnh sản xuất',
                            {
                              'WorkOrderModel': widget.workOrderModel.toJson(),
                            },
                            WorkOrderType.checkQuanlityFirst);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.black.withOpacity(0.1), width: 1),
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
                    SizedBox(
                      width: 20,
                    ),
                    InkWell(
                      onTap: () async {
                        // print(pqcFirstProblemController.temporaryList.length);
                        // for (var item
                        //     in pqcFirstProblemController.temporaryList) {
                        //   await pqcFirstProblemController
                        //       .addPQCFirstProblem(PQCFirstProblemModel(
                        //     id: pqcFirstProblemController
                        //             .pqcFirstProblemList.length +
                        //         1,
                        //     checkDate: item.checkDate,
                        //     problem: item.problem,
                        //     solution: item.solution,
                        //     pqcFirstInfoId:
                        //         pqcFirstInfoController.pqcFirstInfoList.length +
                        //             1,
                        //   ));
                        //   print(item.toJson());
                        // }
                        // for (var item
                        //     in pqcFirstResultController.evaluateItems) {
                        //   await pqcFirstResultController
                        //       .addPQCFirstResult(PQCFirstResultModel(
                        //     content: item.content,
                        //     conclusion: item.conclusion,
                        //     isActive: 1,
                        //     method: item.method,
                        //     pqcFirstInfoId:
                        //         pqcFirstInfoController.pqcFirstInfoList.length +
                        //             1,
                        //     stageName: item.stageName,
                        //     standard: item.standard,
                        //   ));
                        // }
                        await pqcFirstInfoController.addPQCFirstInfo(
                            PQCFirstInfoModel(
                                id: pqcFirstInfoController
                                        .pqcFirstInfoList.length +
                                    1,
                                createdAt: DateTime.now().toIso8601String(),
                                createdBy: LoginSession().getUser()?.name,
                                isActive: 1,
                                model: modelController.text,
                                note: noteController.text,
                                pqcName: pqcController.text,
                                qcLeaderName: qcLeaderController.text,
                                quantity: int.parse(quantityController.text),
                                type: typeController.text,
                                updatedAt: DateTime.now().toIso8601String(),
                                updatedBy: LoginSession().getUser()?.name,
                                workOrderId: widget.workOrderModel.id,
                                conclusion: conclusionValue));
                        sidebarController.changePageWithArguments(
                            'Thông tin lệnh sản xuất',
                            {
                              'WorkOrderModel': widget.workOrderModel.toJson(),
                            },
                            WorkOrderType.checkQuanlityFirst);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: QMSColor.mainorange,
                            border: Border.all(
                                color: Colors.black.withOpacity(0.1), width: 1),
                            borderRadius: BorderRadius.circular(2)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        child: const Text(
                          'Lưu lại',
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
}
