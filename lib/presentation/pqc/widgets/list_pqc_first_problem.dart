import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:qms_app/common/color.dart';
import 'package:qms_app/common/icon_path.dart';
import 'package:qms_app/models/pqc_first_problem.dart';
import 'package:qms_app/presentation/category_manage/widgets/textfield_custom.dart';
import 'package:qms_app/presentation/pqc/controllers/pqc_first_problem_c.dart';
import 'package:qms_app/presentation/widgets/table_custom.dart';

class PQCFirstProblemListTemporary extends StatefulWidget {
  PQCFirstProblemListTemporary(
      {super.key, List<PQCFirstProblemModel>? list, this.enable = true})
      : list = list ?? const [];

  List<PQCFirstProblemModel>? list;
  bool? enable;

  @override
  State<PQCFirstProblemListTemporary> createState() =>
      _PQCFirstProblemListTemporaryState();
}

class _PQCFirstProblemListTemporaryState
    extends State<PQCFirstProblemListTemporary> {
  late List<PQCFirstProblemModel> _items;
  late List<List<TextEditingController>> _controllers;
  final controller = Get.find<PqcFirstProblemController>();

  void _updateTemporaryList(PQCFirstProblemModel item) {
    if (item.checkDate != null &&
        item.checkDate!.isNotEmpty &&
        item.problem != null &&
        item.problem!.isNotEmpty &&
        item.solution != null &&
        item.solution!.isNotEmpty) {
      // Nếu item chưa có trong temporaryList thì thêm
      if (!controller.temporaryList.contains(item)) {
        controller.temporaryList.add(item);
      }
    } else {
      // Nếu item thiếu bất kỳ trường nào thì loại bỏ khỏi temporaryList
      controller.temporaryList.remove(item);
    }
  }

  @override
  void initState() {
    super.initState();
    _items = List.from(widget.list ?? []);
    controller.temporaryList.clear();
    _controllers = List.generate(
      _items.length,
      (index) => [
        TextEditingController(text: _items[index].checkDate ?? ''),
        TextEditingController(text: _items[index].problem ?? ''),
        TextEditingController(text: _items[index].solution ?? ''),
      ],
    );
  }

  @override
  void dispose() {
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
              'Thông tin ghi nhận vấn đề',
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
            ItemTitleWidget(title: 'Ngày kiểm tra'): 3,
            ItemTitleWidget(title: 'Vấn đề'): 3,
            ItemTitleWidget(title: 'Phương án khắc phục'): 2,
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
                  TextField(
                    controller: _controllers[index][0], // Check date
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      border: InputBorder.none, // Xóa underline
                    ),
                    onChanged: (value) {
                      setState(() {
                        _items[index].checkDate = value;
                        _updateTemporaryList(_items[index]);
                      });
                    },
                  ): 3,
                  TextField(
                    controller: _controllers[index][1], // Check date
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      border: InputBorder.none,
                    ),
                    onChanged: (value) {
                      setState(() {
                        _items[index].problem = value;
                        _updateTemporaryList(_items[index]);
                      });
                    },
                  ): 3,
                  TextField(
                    controller: _controllers[index][2], // Check date
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      border: InputBorder.none, // Xóa underline
                    ),
                    onChanged: (value) {
                      setState(() {
                        _items[index].solution = value;
                        _updateTemporaryList(_items[index]);
                      });
                    },
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
        PQCFirstProblemModel(),
      );
      // Add new controllers for the new row
      _controllers.add([
        TextEditingController(),
        TextEditingController(),
        TextEditingController(),
      ]);
    });
  }
}
