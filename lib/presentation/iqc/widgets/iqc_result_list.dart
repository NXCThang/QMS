import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qms_app/common/color.dart';
import 'package:qms_app/common/icon_path.dart';
import 'package:qms_app/models/iqc_result.dart';
import 'package:qms_app/presentation/category_manage/widgets/textfield_custom.dart';
import 'package:qms_app/presentation/widgets/table_custom.dart';

class IqcResultListTemporary extends StatefulWidget {
  const IqcResultListTemporary({Key? key, required this.list})
      : super(key: key);

  final List<IQCResultModel> list;

  @override
  State<IqcResultListTemporary> createState() => _IqcResultListTemporaryState();
}

class _IqcResultListTemporaryState extends State<IqcResultListTemporary> {
  late List<IQCResultModel> _items;

  // Các controller cho TextField
  late TextEditingController criteriaNameController;
  late TextEditingController minController;
  late TextEditingController maxController;
  late TextEditingController unitController;
  late TextEditingController otherRequirementController;
  late TextEditingController quantityController;
  late TextEditingController testResultController;
  late TextEditingController conclusionController;
  late TextEditingController noteController;

  @override
  void initState() {
    super.initState();
    _items = List.from(widget.list);

    // Khởi tạo các TextEditingController
    criteriaNameController = TextEditingController();
    minController = TextEditingController();
    maxController = TextEditingController();
    unitController = TextEditingController();
    otherRequirementController = TextEditingController();
    quantityController = TextEditingController();
    testResultController = TextEditingController();
    conclusionController = TextEditingController();
    noteController = TextEditingController();
  }

  @override
  void dispose() {
    criteriaNameController.dispose();
    minController.dispose();
    maxController.dispose();
    unitController.dispose();
    otherRequirementController.dispose();
    quantityController.dispose();
    testResultController.dispose();
    conclusionController.dispose();
    noteController.dispose();
    super.dispose();
  }

  void _addNewRow() {
    setState(() {
      _items.add(
        IQCResultModel(
          criteriaName: '',
          min: 0,
          max: 0,
          unit: '',
          otherRequirement: '',
          quantity: 0,
          testResult: '',
          conclusion: 0,
          note: '',
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Thông tin tiêu chí',
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
            ),
            const Spacer(),
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
            ItemTitleWidget(title: 'STT'): 1,
            ItemTitleWidget(title: 'Tiêu chí'): 3,
            ItemTitleWidget(title: 'Min'): 2,
            ItemTitleWidget(title: 'Max'): 2,
            ItemTitleWidget(title: 'Đơn vị'): 2,
            ItemTitleWidget(title: 'Yêu cầu khác'): 2,
            ItemTitleWidget(title: 'Số lượng'): 2,
            ItemTitleWidget(title: 'Kết quả kiểm tra'): 2,
            ItemTitleWidget(title: 'Đánh giá'): 2,
            ItemTitleWidget(title: 'Ghi chú'): 2,
            ItemTitleWidget(title: 'Thao tác'): 2,
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
              criteriaNameController.text = item.criteriaName ?? '';
              minController.text = item.min == 0 ? '' : item.min.toString();
              maxController.text = item.max == 0 ? '' : item.max.toString();
              unitController.text = item.unit ?? '';
              otherRequirementController.text = item.otherRequirement ?? '';
              quantityController.text =
                  item.quantity == 0 ? '' : item.quantity.toString();
              testResultController.text = item.testResult ?? '';
              conclusionController.text =
                  item.conclusion == 0 ? '' : item.conclusion.toString();
              noteController.text = item.note ?? '';
              return TableCustom(
                color: Colors.white,
                title: {
                  ItemBodyWidget(title: stt.toString()): 1,
                  TextFieldCustom(
                    width: 120,
                    label: '',
                    textcontroller: criteriaNameController,
                  ): 3,
                  TextFieldCustom(
                    width: 100,
                    label: '',
                    textcontroller: minController,
                    onChanged: (value) {
                      setState(() {
                        item.criteriaName = value;
                      });
                    },
                  ): 2,
                  TextFieldCustom(
                    width: 100,
                    label: '',
                    textcontroller: maxController,
                    onChanged: (value) {
                      setState(() {
                        item.criteriaName = value;
                      });
                    },
                  ): 2,
                  TextFieldCustom(
                    width: 100,
                    label: '',
                    textcontroller: unitController,
                    onChanged: (value) {
                      setState(() {
                        item.criteriaName = value;
                      });
                    },
                  ): 2,
                  TextFieldCustom(
                    width: 100,
                    label: '',
                    textcontroller: otherRequirementController,
                    onChanged: (value) {
                      setState(() {
                        item.criteriaName = value;
                      });
                    },
                  ): 2,
                  TextFieldCustom(
                    width: 100,
                    label: '',
                    textcontroller: quantityController,
                    onChanged: (value) {
                      setState(() {
                        item.criteriaName = value;
                      });
                    },
                  ): 2,
                  TextFieldCustom(
                    width: 100,
                    label: '',
                    textcontroller: testResultController,
                    onChanged: (value) {
                      setState(() {
                        item.criteriaName = value;
                      });
                    },
                  ): 2,
                  TextFieldCustom(
                    width: 100,
                    label: '',
                    textcontroller: conclusionController,
                    onChanged: (value) {
                      setState(() {
                        item.criteriaName = value;
                      });
                    },
                  ): 2,
                  TextFieldCustom(
                    width: 100,
                    label: '',
                    textcontroller: noteController,
                    onChanged: (value) {
                      setState(() {
                        item.criteriaName = value;
                      });
                    },
                  ): 2,
                  InkWell(
                    onTap: () {
                      setState(() {
                        _items.removeAt(index);
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
      ],
    );
  }
}
