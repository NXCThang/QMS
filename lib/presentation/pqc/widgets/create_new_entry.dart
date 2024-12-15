import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qms_app/common/color.dart';
import 'package:qms_app/common/sidebar/controller/sidebar_c.dart';
import 'package:qms_app/data/local/login_session.dart';
import 'package:qms_app/models/pqc_final_result.dart';
import 'package:qms_app/models/work_order.dart';
import 'package:qms_app/presentation/category_manage/widgets/textfield_custom.dart';
import 'package:qms_app/presentation/pqc/controllers/pqc_final_result_c.dart';
import 'package:qms_app/presentation/pqc/controllers/work_order_c.dart';

class CreateNewEntry extends StatefulWidget {
  const CreateNewEntry({super.key, required this.workOrderModel});

  final WorkOrderModel workOrderModel;
  @override
  State<CreateNewEntry> createState() => _CreateNewEntryState();
}

class _CreateNewEntryState extends State<CreateNewEntry> {
  final TextEditingController _productCodeController = TextEditingController();
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _workOrderCodeController =
      TextEditingController();
  final TextEditingController _customerController = TextEditingController();
  final TextEditingController _customerCodeController = TextEditingController();
  final TextEditingController _requestTimeController = TextEditingController();
  final TextEditingController _colorController = TextEditingController();
  final TextEditingController _planController = TextEditingController();
  final TextEditingController _totalQuantityController =
      TextEditingController();
  final TextEditingController _testQuantityController = TextEditingController();
  final TextEditingController _requestStageController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  int externalResultValue = 0;
  int featureResultValue = 0;
  int finalResultValue = 0;
  var pqcFinalResultController = Get.find<PqcFinalResultController>();
  var sidebarController = Get.find<SideBarController>();

  @override
  void initState() {
    _productCodeController.text = widget.workOrderModel.productId.toString();
    _productNameController.text = widget.workOrderModel.productName ?? '';
    _workOrderCodeController.text = widget.workOrderModel.workOrderCode ?? '';
    super.initState();
  }

  @override
  void dispose() {
    _productCodeController.dispose();
    _productNameController.dispose();
    _workOrderCodeController.dispose();
    _customerController.dispose();
    _customerCodeController.dispose();
    _requestTimeController.dispose();
    _colorController.dispose();
    _planController.dispose();
    _totalQuantityController.dispose();
    _testQuantityController.dispose();
    _requestStageController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black.withOpacity(0.1), width: 1),
        ),
        margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            // mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Thêm mới thông tin yêu cầu (Thông tin sản xuất)',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextFieldCustom(
                    width: 320,
                    label: 'Mã sản phẩm',
                    textcontroller: _productCodeController,
                    enabled: false,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  TextFieldCustom(
                      width: 320,
                      label: 'Tên sản phẩm',
                      textcontroller: _productNameController,
                      enabled: false),
                  const SizedBox(
                    width: 20,
                  ),
                  TextFieldCustom(
                    width: 320,
                    label: 'Mã lệnh sản xuất',
                    textcontroller: _workOrderCodeController,
                    enabled: false,
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextFieldCustom(
                    width: 320,
                    label: 'Khách hàng',
                    textcontroller: _customerController,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  TextFieldCustom(
                      width: 320,
                      label: 'Mã khách hàng',
                      textcontroller: _customerCodeController),
                  const SizedBox(
                    width: 20,
                  ),
                  TextFieldCustom(
                    width: 320,
                    label: 'Thời gian yêu cầu',
                    textcontroller: _requestTimeController,
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextFieldCustom(
                    width: 320,
                    label: 'Màu sắc',
                    textcontroller: _colorController,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  TextFieldCustom(
                      width: 320,
                      label: 'Kế hoạch',
                      textcontroller: _planController),
                  const SizedBox(
                    width: 20,
                  ),
                  TextFieldCustom(
                      width: 320,
                      label: 'Tổng số lượng',
                      textcontroller: _totalQuantityController),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextFieldCustom(
                    width: 320,
                    label: 'Số lượng kế hoạch',
                    textcontroller: _testQuantityController,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  TextFieldCustom(
                    width: 320,
                    label: 'Bộ phận gửi yêu cầu',
                    textcontroller: _requestStageController,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  TextFieldCustom(
                      width: 320,
                      label: 'Ghi chú',
                      textcontroller: _noteController),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      'Nội dung kiểm tra:',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                    ),
                  ),
                  Expanded(
                    child: CheckboxListTile(
                      activeColor: QMSColor.mainorange,
                      title: Text(
                        'Kiểm tra chức năng',
                        style: TextStyle(fontSize: 18),
                      ),
                      value: featureResultValue == 1,
                      onChanged: (bool? value) {
                        setState(() {
                          featureResultValue =
                              (featureResultValue == 1) ? 0 : 1;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                      dense: true,
                    ),
                  ),
                  Expanded(
                    child: CheckboxListTile(
                      activeColor: QMSColor.mainorange,
                      title: Text(
                        'Kiểm tra ngoại quan',
                        style: TextStyle(fontSize: 18),
                      ),
                      value: externalResultValue == 1,
                      onChanged: (bool? value) {
                        setState(() {
                          externalResultValue =
                              (externalResultValue == 1) ? 0 : 1;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                      dense: true,
                    ),
                  ),
                  Expanded(
                    child: CheckboxListTile(
                      activeColor: QMSColor.mainorange,
                      title: Text(
                        'Kiểm tra đóng gói OBA',
                        style: TextStyle(fontSize: 18),
                      ),
                      value: finalResultValue == 1,
                      onChanged: (bool? value) {
                        setState(() {
                          finalResultValue = (finalResultValue == 1) ? 0 : 1;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                      dense: true,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Spacer(),
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
                          WorkOrderType.checkQuality);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.black.withOpacity(0.1), width: 1),
                          borderRadius: BorderRadius.circular(2)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      child: const Text(
                        'Hủy bỏ',
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
                      pqcFinalResultController
                          .addPQCFinalResult(PQCFinalResultModel(
                        id: pqcFinalResultController.pqcFinalResultList.length +
                            1,
                        workOrderId: widget.workOrderModel.id,
                        customerName: _customerController.text,
                        approvalPerson: LoginSession().getUser()?.name ?? '',
                        createdAt: DateTime.now().toIso8601String(),
                        createdBy: LoginSession().getUser()?.name ?? '',
                        externalResult: externalResultValue,
                        featureResult: featureResultValue,
                        finalResult: finalResultValue,
                        isActive: 1,
                        note: _noteController.text,
                        requestStage: _requestStageController.text,
                        testQuantity: int.parse(_testQuantityController.text),
                        totalQuantity: int.parse(_totalQuantityController.text),
                        updatedAt: DateTime.now().toIso8601String(),
                        updatedBy: LoginSession().getUser()?.name ?? '',
                      ));
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
                        'Thêm mới',
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
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
