import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qms_app/common/color.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:qms_app/models/iqc_request.dart';
import 'package:qms_app/models/iqc_result.dart';
import 'package:qms_app/presentation/category_manage/controllers/iqc_result_c.dart';
import 'package:qms_app/presentation/category_manage/widgets/textfield_custom.dart';

class AddCriteria extends StatelessWidget {
  final bool create;
  int? id;
  String? criteriaName;
  String? minValue;
  String? maxValue;
  String? unit;
  String? note;
  AddCriteria(
      {super.key,
      required this.create,
      this.id,
      this.criteriaName,
      this.minValue,
      this.maxValue,
      this.unit,
      this.note});
  final controller = Get.find<IqcResultController>();

  final TextEditingController criteriaNameController = TextEditingController();
  final TextEditingController minValueController = TextEditingController();
  final TextEditingController maxValueController = TextEditingController();
  final TextEditingController unitController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    criteriaNameController.text = criteriaName ?? '';
    minValueController.text = minValue ?? '';
    maxValueController.text = maxValue ?? '';
    unitController.text = unit ?? '';
    noteController.text = note ?? '';
    final appLocalizations = AppLocalizations.of(context);
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: SizedBox(
        width: 650,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: const BoxDecoration(
                color: QMSColor.orangetableheader,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 40),
                  const Text(
                    'Thông tin mẫu kiểm tra NVL/BTP/TP',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const Icon(
                      Icons.close,
                      weight: 20,
                      color: QMSColor.black11,
                    ),
                  ),
                ],
              ),
            ),
            // Content of the popup
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFieldCustom(
                    label: 'Tên tiêu chí',
                    textcontroller: criteriaNameController,
                  ),
                  TextFieldCustom(
                    label: 'Thông số min',
                    textcontroller: minValueController,
                    isNumber: true,
                  ),
                  TextFieldCustom(
                    label: 'Thông số max',
                    textcontroller: maxValueController,
                    isNumber: true,
                  ),
                  TextFieldCustom(
                    label: 'Đơn vị',
                    textcontroller: unitController,
                  ),
                  TextFieldCustom(
                    label: 'Ghi chú',
                    textcontroller: noteController,
                  ),
                ],
              ),
            ),
            Divider(
              height: 1,
              color: Colors.black.withOpacity(0.2),
            ),
            const SizedBox(height: 20),
            // Actions
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    style: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.all(QMSColor.maingrey),
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      padding: WidgetStateProperty.all(
                        const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 10),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Hủy bỏ',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                          color: Colors.black.withOpacity(0.7)),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  TextButton(
                    style: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.all(QMSColor.mainorange),
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      padding: WidgetStateProperty.all(
                        const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 10),
                      ),
                    ),
                    onPressed: () {
                      (create)
                          ? controller.addIqcResult(IQCResultModel(
                              id: controller.iqcResultList.length + 1,
                              criteriaName: criteriaNameController.text,
                              min: int.parse(minValueController.text),
                              max: int.parse(maxValueController.text),
                              unit: unitController.text,
                              note: noteController.text,
                            ))
                          : controller.updateIqcResult(IQCResultModel(
                              id: id,
                              criteriaName: criteriaNameController.text,
                              min: int.parse(minValueController.text),
                              max: int.parse(maxValueController.text),
                              unit: unitController.text,
                              note: noteController.text,
                            ));
                    },
                    child: Text(
                      (create) ? 'Thêm mới' : 'Cập nhật',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                          color: Colors.black.withOpacity(0.7)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
