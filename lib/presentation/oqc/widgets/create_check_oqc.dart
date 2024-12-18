import 'package:flutter/material.dart';
import 'package:qms_app/common/components/text_field_input_custom.dart';
import 'package:qms_app/models/oqc_info.dart';
import 'package:qms_app/models/oqc_result.dart';
import 'package:qms_app/models/work_order.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:qms_app/common/color.dart';
import 'package:qms_app/common/extensions/date_time_format.dart';
import 'package:qms_app/common/icon_path.dart';
import 'package:qms_app/common/sidebar/controller/sidebar_c.dart';
import 'package:qms_app/data/local/login_session.dart';
import 'package:qms_app/presentation/category_manage/widgets/textfield_custom.dart';
import 'package:qms_app/presentation/oqc/controllers/oqc_info_c.dart';
import 'package:qms_app/presentation/oqc/controllers/oqc_result_c.dart';
import 'package:qms_app/presentation/pqc/controllers/work_order_c.dart';
import 'package:qms_app/presentation/widgets/table_custom.dart';

class CreateCheckOqc extends StatefulWidget {
  CreateCheckOqc({super.key, required this.info, this.enable = true});
  final OQCInfoModel info;
  bool? enable;

  @override
  State<CreateCheckOqc> createState() => _CreateCheckOqcState();
}

class _CreateCheckOqcState extends State<CreateCheckOqc> {
  late List<OQCResultModel> _items;
  late List<List<TextEditingController>> _controllers;
  final TextEditingController createDateController = TextEditingController();
  final TextEditingController workOrderCodeController = TextEditingController();
  final TextEditingController modelController = TextEditingController();
  final TextEditingController planQuantityController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  var sidebarController = Get.find<SideBarController>();
  var oqcInfoController = Get.find<OqcInfoController>();
  var oqcResultController = Get.find<OqcResultController>();
  var workOrderController = Get.find<WorkOrderController>();
  late int workOrderId;
  @override
  void initState() {
    super.initState();
    workOrderId = widget.info.workOrderId ?? 0;
    _items = List.from(widget.info.oqcResults ?? []);
    print('items: $_items');
    createDateController.text = widget.info.createdAt?.formatDateTime() ??
        DateTime.now().toIso8601String().formatDateTime();
    workOrderCodeController.text =
        workOrderController.workorderList[workOrderId].workOrderCode ?? '';
    modelController.text = widget.info.model ?? '';
    planQuantityController.text = widget.info.quantity?.toString() ?? '';
    noteController.text = widget.info.note ?? '';
    _controllers = List.generate(
      _items.length,
      (index) => [
        TextEditingController(
            text: _items[index].inputDate?.formatDateTime() ?? ''),
        TextEditingController(text: (_items[index].nGQuantity ?? 0).toString()),
        TextEditingController(
            text: (_items[index].createdAt?.formatDateTime() ?? '')),
        TextEditingController(text: (_items[index].createdBy ?? '')),
        TextEditingController(
            text: (_items[index].externalQuantity ?? 0).toString()),
        TextEditingController(
            text: (_items[index].featureQuantity ?? 0).toString()),
        TextEditingController(text: (_items[index].isActive ?? 0).toString()),
        TextEditingController(text: (_items[index].result ?? 0).toString()),
        TextEditingController(
            text: (_items[index].testQuantity ?? 0).toString()),
        TextEditingController(
            text: (_items[index].totalQuantity ?? 0).toString()),
        TextEditingController(
            text: (_items[index].updatedAt?.formatDateTime() ?? '')),
        TextEditingController(text: (_items[index].updatedBy ?? '')),
      ],
    );
  }

  @override
  void dispose() {
    // Dispose controllers for each row when the widget is disposed
    for (var controllersList in _controllers) {
      for (var controller in controllersList) {
        controller.dispose();
      }
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Khai báo thông tin kiểm tra chất lượng công đoạn OQC',
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 24),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextFieldCustom(
                      width: 320,
                      label: 'Ngày thực hiện',
                      textcontroller: createDateController,
                      enabled: false,
                    ),
                    TextFieldCustom(
                        width: 320,
                        label: 'Lệnh sản xuất',
                        textcontroller: workOrderCodeController,
                        enabled: false),
                    TextFieldCustom(
                        width: 320,
                        label: 'Model',
                        textcontroller: modelController,
                        enabled: false),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextFieldCustom(
                        width: 320,
                        label: 'Kế hoạch',
                        textcontroller: planQuantityController,
                        enabled: false),
                    TextFieldCustom(
                        width: 320,
                        label: 'Ghi chú',
                        textcontroller: noteController,
                        enabled: false),
                    SizedBox(
                      width: 340,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Khai báo thông tin kiểm hàng',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    const Spacer(),
                    if (widget.enable == true)
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: _addNewRow,
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                IconPath.addNew,
                                width: 18,
                                height: 18,
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                'Thêm hàng khai báo',
                                style: TextStyle(
                                  color: QMSColor.mainorange,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 10),
                TableCustom(
                  title: {
                    ItemTitleWidget(title: 'Ngày nhập'): 3,
                    ItemTitleWidget(title: 'Tổng số lượng'): 2,
                    ItemTitleWidget(title: 'Ngày kiểm'): 2,
                    ItemTitleWidget(title: 'NG'): 2,
                    ItemTitleWidget(title: 'Phán định'): 2,
                    ItemTitleWidget(title: 'Thao tác'): 1,
                  },
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: _items.length * 60.0,
                  child: ListView.builder(
                    itemCount: _items.length,
                    itemBuilder: (BuildContext context, int index) {
                      final item = _items[index];
                      final stt = index + 1;
                      return TableCustom(
                        color: Colors.white,
                        title: {
                          TextFieldInputCustom(
                            controller: _controllers[index][0],
                            enable: widget.enable,
                          ): 3,
                          // TextFieldCustom(
                          //   width: 120,
                          //   label: '',
                          //   textcontroller: _controllers[index]
                          //       [0], // Criteria Name
                          // ): 3,
                          TextFieldInputCustom(
                            controller: _controllers[index][1],
                            enable: widget.enable,
                            isNumber: true,
                          ): 2,
                          // TextFieldCustom(
                          //   width: 100,
                          //   label: '',
                          //   textcontroller: _controllers[index][1], // Min
                          //   isNumber: true,
                          // ): 2,
                          TextFieldInputCustom(
                            controller: _controllers[index][2],
                            enable: widget.enable,
                            isNumber: true,
                          ): 2,
                          // TextFieldCustom(
                          //   width: 100,
                          //   label: '',
                          //   textcontroller: _controllers[index][2], // Max
                          //   isNumber: true,
                          // ): 2,
                          TextFieldInputCustom(
                            controller: _controllers[index][3],
                            enable: widget.enable,
                          ): 2,
                          // TextFieldCustom(
                          //   width: 100,
                          //   label: '',
                          //   textcontroller: _controllers[index][3], // Unit
                          // ): 2,
                          Container(
                              height: 36,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.black.withOpacity(0.5),
                                    width: 1),
                              ),
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 4),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: DropdownButton<String>(
                                isExpanded: true,
                                underline: SizedBox.shrink(),
                                value: _controllers[index][4].text.isEmpty
                                    ? null
                                    : _controllers[index][4].text,
                                items: ['OK', 'NG']
                                    .map((value) => DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        ))
                                    .toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _controllers[index][4].text = value ?? '';
                                    item.result = (value == 'OK') ? 1 : 0;
                                    // if (item.result != null &&
                                    //     !oqcInfoController.evaluateItems
                                    //         .contains(item)) {
                                    //   pqcFirstResultController.evaluateItems
                                    //       .add(item);
                                    // } else {
                                    //   pqcFirstResultController.evaluateItems
                                    //       .remove(item);
                                    // }
                                  });
                                },
                              )): 2,
                          InkWell(
                            onTap: () {
                              if (widget.enable == true) {
                                setState(() {
                                  _items.removeAt(index);
                                  _controllers.removeAt(index);
                                });
                              }
                            },
                            child: Icon(
                              Icons.delete_outline,
                              color: Colors.red,
                              size: 24,
                            ),
                          ): 1,
                        },
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Phê duyệt',
                          style: TextStyle(fontSize: 17),
                        ),
                        (widget.enable == false)
                            ? Image.asset('assets/images/nhu_sign.jpg',
                                width: 100, height: 100)
                            : SizedBox(
                                height: 50,
                              ),
                      ],
                    ),
                    SizedBox(
                      width: 50,
                    ),
                    Column(
                      children: [
                        Text(
                          'Người kiểm tra',
                          style: TextStyle(fontSize: 17),
                        ),
                        (widget.enable == false)
                            ? Image.asset('assets/images/nhu_sign.jpg',
                                width: 100, height: 100)
                            : SizedBox(
                                height: 50,
                              ),
                      ],
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      (widget.enable == true)
                          ? 'Ngày tháng năm'
                          : widget.info.createdAt?.displayTime() ?? '',
                      style: TextStyle(fontSize: 17),
                    ),
                    SizedBox(
                      width: 50,
                    ),
                    Text(
                      (widget.enable == true)
                          ? 'Ngày tháng năm'
                          : widget.info.updatedAt?.displayTime() ?? '',
                      style: TextStyle(fontSize: 17),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (widget.enable == true)
                      InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                contentPadding: const EdgeInsets.all(20),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.warning_amber_rounded,
                                      color: QMSColor.mainorange,
                                      size: 48,
                                    ),
                                    const SizedBox(height: 16),
                                    const Text(
                                      "Xác nhận",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    const Text(
                                      "Những thay đổi chưa được lưu, bạn có muốn thoát?",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                                actions: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.deepPurple,
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      sidebarController.changePageWithArguments(
                                          'Thông tin lệnh sản xuất',
                                          {
                                            'WorkOrderModel':
                                                workOrderController
                                                    .workorderList[workOrderId]
                                                    .toJson(),
                                          },
                                          WorkOrderType.checkOQC);
                                    },
                                    child: const Text(
                                      "Đồng ý",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blueGrey,
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text(
                                      "Hủy",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.black.withOpacity(0.1),
                                  width: 1),
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
                    (widget.enable == true)
                        ? InkWell(
                            onTap: () async {
                              await oqcInfoController.addOqcInfo(OQCInfoModel(
                                  createdAt: DateTime.now().toIso8601String(),
                                  createdBy:
                                      LoginSession().getUser()?.name ?? '',
                                  id: oqcInfoController.oqcInfoList.length + 1,
                                  isActive: 1,
                                  model: modelController.text,
                                  note: noteController.text,
                                  quantity:
                                      int.parse(planQuantityController.text),
                                  status: 'Chờ phê duyệt',
                                  updatedAt: DateTime.now().toIso8601String(),
                                  updatedBy:
                                      LoginSession().getUser()?.name ?? '',
                                  workOrderId: workOrderController
                                      .workorderList[
                                          widget.info.workOrderId ?? 1]
                                      .id));
                              for (int index = 0;
                                  index < _items.length;
                                  index++) {
                                OQCResultModel result = OQCResultModel(
                                  id: oqcResultController.oqcResultList.length +
                                      1,
                                  oqcInfoId:
                                      oqcInfoController.oqcInfoList.length + 1,
                                  createdAt: DateTime.now().toIso8601String(),
                                  updatedBy:
                                      LoginSession().getUser()?.name ?? '',
                                  createdBy:
                                      LoginSession().getUser()?.name ?? '',
                                  inputDate: _controllers[index][0].text,
                                  totalQuantity:
                                      int.parse(_controllers[index][1].text),
                                  updatedAt: _controllers[index][2].text,
                                  nGQuantity:
                                      int.parse(_controllers[index][3].text),
                                  result: _items[index].result,
                                );
                              }
                              sidebarController
                                  .changePage('Phê duyệt nhập kho');
                              // print(result.toJson());
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
                                'Gửi duyệt',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          )
                        : (widget.info.status != 'Đã duyệt')
                            ? Row(
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      // print('info id: ${widget.info.id}');
                                      await oqcInfoController
                                          .removeOQCInfo(widget.info.id ?? 0);
                                      sidebarController
                                          .changePage('Phê duyệt nhập kho');
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.blueAccent,
                                          border: Border.all(
                                              color:
                                                  Colors.black.withOpacity(0.1),
                                              width: 1),
                                          borderRadius:
                                              BorderRadius.circular(2)),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 4),
                                      child: const Text(
                                        'Từ chối',
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
                                      await oqcInfoController.updateOQCInfo(
                                          OQCInfoModel(
                                              id: widget.info.id,
                                              status: 'Đã duyệt'));
                                      sidebarController
                                          .changePage('Phê duyệt nhập kho');
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: QMSColor.mainorange,
                                          border: Border.all(
                                              color:
                                                  Colors.black.withOpacity(0.1),
                                              width: 1),
                                          borderRadius:
                                              BorderRadius.circular(2)),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 4),
                                      child: const Text(
                                        'Phê duyệt',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            : SizedBox.shrink(),
                    SizedBox(
                      width: 20,
                    ),
                    InkWell(
                      onTap: () {
                        sidebarController.changePage('Phê duyệt nhập kho');
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
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ))));
  }

  void _addNewRow() {
    setState(() {
      _items.add(
        OQCResultModel(
          id: null,
          oqcInfoId: null,
          inputDate: '',
          isActive: null,
          result: null,
          createdAt: '',
          updatedAt: '',
          updatedBy: '',
          createdBy: '',
          totalQuantity: 0,
          testQuantity: 0,
          nGQuantity: 0,
          externalQuantity: 0,
          featureQuantity: 0,
        ),
      );

      _controllers.add([
        TextEditingController(), // inputDate
        TextEditingController(text: ''), // isActive
        TextEditingController(text: ''), // result
        TextEditingController(), // createdAt
        TextEditingController(), // updatedAt
        TextEditingController(), // updatedBy
        TextEditingController(), // createdBy
        TextEditingController(text: ''), // totalQuantity
        TextEditingController(text: ''), // testQuantity
        TextEditingController(text: ''), // nGQuantity
        TextEditingController(text: ''), // externalQuantity
        TextEditingController(text: ''), // featureQuantity
      ]);
    });
  }
}
