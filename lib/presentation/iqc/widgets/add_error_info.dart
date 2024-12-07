import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:qms_app/common/color.dart';
import 'package:qms_app/common/icon_path.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:qms_app/models/iqc_result_ng.dart';
import 'package:qms_app/presentation/category_manage/widgets/textfield_custom.dart';
import 'package:qms_app/presentation/iqc/controllers/iqc_result_ng_c.dart';
import 'package:qms_app/presentation/widgets/table_custom.dart';

class AddErrorInfo extends StatefulWidget {
  AddErrorInfo({super.key, required this.iqcReportId, this.list = const []});
  final int iqcReportId;
  List<IQCResultNgModel>? list;
  @override
  State<AddErrorInfo> createState() => _AddErrorInfoState();
}

class _AddErrorInfoState extends State<AddErrorInfo> {
  final controller = Get.find<IqcResultNgController>();
  late List<IQCResultNgModel> _items;
  late List<List<TextEditingController>> _controllers;

  @override
  void initState() {
    super.initState();
    _items = List.from(widget.list ?? []);

    // Initialize a list of controllers for each row
    _controllers = List.generate(
      _items.length,
      (index) => [
        TextEditingController(text: _items[index].iqcErrGroup ?? ''),
        TextEditingController(text: _items[index].iqcErrName ?? ''),
        TextEditingController(
            text: _items[index].quantity == 0
                ? ''
                : _items[index].quantity.toString()),
        TextEditingController(text: _items[index].ratio ?? ''),
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
            height: 200 + _items.length * 60.0,
            decoration: BoxDecoration(
              color: Colors.white,
              border:
                  Border.all(color: Colors.black.withOpacity(0.1), width: 1),
            ),
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
                    'Thông tin lỗi',
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
                    '',
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
                  ),
                  const Spacer(),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.all(0),
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
                        ItemBodyWidget(title: stt.toString()): 1,
                        Container(
                            height: 36,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.black.withOpacity(0.5),
                                  width: 1),
                            ),
                            margin: const EdgeInsets.symmetric(
                                horizontal: 50, vertical: 4),
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: DropdownButton<String>(
                              isExpanded: true,
                              underline: SizedBox.shrink(),
                              value: controller.iqcResultNgList
                                      .map((e) => e.iqcErrGroup)
                                      .contains(item.iqcErrGroup)
                                  ? item.iqcErrGroup
                                  : null,
                              hint: const Text('Chọn Nhóm Lỗi'),
                              items: controller.iqcResultNgList
                                  .map((e) => e.iqcErrGroup)
                                  .where((group) => group != null)
                                  .toSet()
                                  .map((group) => DropdownMenuItem<String>(
                                        value: group,
                                        child: Text(group ?? ''),
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  item.iqcErrGroup = value ?? '';
                                });
                              },
                            )): 3,
                        Container(
                            height: 36,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.black.withOpacity(0.5),
                                  width: 1),
                            ),
                            margin: const EdgeInsets.symmetric(
                                horizontal: 50, vertical: 4),
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: DropdownButton<String>(
                              isExpanded: true,
                              underline: SizedBox.shrink(),
                              value: controller.iqcResultNgList
                                      .where((e) =>
                                          e.iqcErrGroup == item.iqcErrGroup)
                                      .map((e) => e.iqcErrName)
                                      .contains(item.iqcErrName)
                                  ? item.iqcErrName
                                  : null,
                              hint: const Text('Chọn Tên Lỗi'),
                              items: controller.iqcResultNgList
                                  .where(
                                      (e) => e.iqcErrGroup == item.iqcErrGroup)
                                  .map((e) => e.iqcErrName)
                                  .where((name) => name != null)
                                  .toSet()
                                  .map((name) => DropdownMenuItem<String>(
                                        value: name,
                                        child: Text(name ?? ''),
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  item.iqcErrName = value ?? '';
                                });
                              },
                            )): 3,
                        TextFieldCustom(
                          width: 100,
                          label: '',
                          textcontroller: _controllers[index][0],
                          isNumber: true,
                        ): 3,
                        TextFieldCustom(
                          width: 100,
                          label: '',
                          textcontroller: _controllers[index][1],
                        ): 3,
                        InkWell(
                          onTap: () {
                            setState(() {
                              _items.removeAt(index);
                              _controllers.removeAt(index);
                            });
                          },
                          child: Icon(
                            Icons.delete,
                            color: Colors.red,
                            size: 24,
                          ),
                        ): 2,
                      },
                    );
                  },
                ),
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      Get.back();
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
                  InkWell(
                    onTap: () {
                      for (var i = 0; i < _items.length; i++) {
                        controller.addIqcResultNg(IQCResultNgModel(
                          id: controller.iqcResultNgList.length + 1,
                          iqcErrGroup: _items[i].iqcErrGroup,
                          iqcErrName: _items[i].iqcErrName,
                          iqcReportId: widget.iqcReportId,
                          quantity: int.parse(_controllers[i][0].text),
                          ratio: _controllers[i][1].text,
                        ));
                      }
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
                        'OK',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ).paddingOnly(left: 16),
                ],
              ).paddingOnly(bottom: 16),
            ]),
          );
        }
      }),
    );
  }

  void _addNewRow() {
    setState(() {
      _items.add(
        IQCResultNgModel(
            iqcErrGroup: '', iqcErrName: '', quantity: 0, ratio: ''),
      );
      // Add new controllers for the new row
      _controllers.add([
        TextEditingController(),
        TextEditingController(),
        TextEditingController(),
        TextEditingController(),
      ]);
    });
  }
}
