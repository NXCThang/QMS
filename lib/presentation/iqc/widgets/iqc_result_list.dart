import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qms_app/common/color.dart';
import 'package:qms_app/common/icon_path.dart';
import 'package:qms_app/models/iqc_result.dart';
import 'package:qms_app/presentation/category_manage/widgets/textfield_custom.dart';
import 'package:qms_app/presentation/widgets/table_custom.dart';

class IqcResultListTemporary extends StatefulWidget {
  IqcResultListTemporary({Key? key, required this.list, this.enable = true})
      : super(key: key);

  final List<IQCResultModel> list;
  bool? enable;

  @override
  State<IqcResultListTemporary> createState() => _IqcResultListTemporaryState();
}

class _IqcResultListTemporaryState extends State<IqcResultListTemporary> {
  late List<IQCResultModel> _items;
  late List<List<TextEditingController>> _controllers;

  @override
  void initState() {
    super.initState();
    _items = List.from(widget.list);

    // Initialize a list of controllers for each row
    _controllers = List.generate(
      _items.length,
      (index) => [
        TextEditingController(text: _items[index].criteriaName ?? ''),
        TextEditingController(
            text: _items[index].min == 0 ? '' : _items[index].min.toString()),
        TextEditingController(
            text: _items[index].max == 0 ? '' : _items[index].max.toString()),
        TextEditingController(text: _items[index].unit ?? ''),
        TextEditingController(text: _items[index].otherRequirement ?? ''),
        TextEditingController(
            text: _items[index].quantity == 0
                ? ''
                : _items[index].quantity.toString()),
        TextEditingController(text: _items[index].testResult ?? ''),
        TextEditingController(
            text: _items[index].conclusion == 0
                ? ''
                : _items[index].conclusion.toString()),
        TextEditingController(text: _items[index].note ?? ''),
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

              return TableCustom(
                color: Colors.white,
                title: {
                  ItemBodyWidget(title: stt.toString()): 1,
                  TextFieldCustom(
                    width: 120,
                    label: '',
                    textcontroller: _controllers[index][0], // Criteria Name
                  ): 3,
                  TextFieldCustom(
                    width: 100,
                    label: '',
                    textcontroller: _controllers[index][1], // Min
                    isNumber: true,
                  ): 2,
                  TextFieldCustom(
                    width: 100,
                    label: '',
                    textcontroller: _controllers[index][2], // Max
                    isNumber: true,
                  ): 2,
                  TextFieldCustom(
                    width: 100,
                    label: '',
                    textcontroller: _controllers[index][3], // Unit
                  ): 2,
                  TextFieldCustom(
                    width: 100,
                    label: '',
                    textcontroller: _controllers[index][4], // Other Requirement
                  ): 2,
                  TextFieldCustom(
                    width: 100,
                    label: '',
                    textcontroller: _controllers[index][5], // Quantity
                    isNumber: true,
                  ): 2,
                  TextFieldCustom(
                    width: 100,
                    label: '',
                    textcontroller: _controllers[index][6], // Test Result
                  ): 2,
                  TextFieldCustom(
                    width: 100,
                    label: '',
                    textcontroller: _controllers[index][7], // Conclusion
                    isNumber: true,
                  ): 2,
                  TextFieldCustom(
                    width: 100,
                    label: '',
                    textcontroller: _controllers[index][8], // Note
                  ): 2,
                  (widget.enable == true)
                      ? InkWell(
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
                        )
                      : SizedBox.shrink(): 2,
                },
              );
            },
          ),
        ),
      
      ],
    );
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
      // Add new controllers for the new row
      _controllers.add([
        TextEditingController(),
        TextEditingController(),
        TextEditingController(),
        TextEditingController(),
        TextEditingController(),
        TextEditingController(),
        TextEditingController(),
        TextEditingController(),
        TextEditingController(),
      ]);
    });
  }

}
