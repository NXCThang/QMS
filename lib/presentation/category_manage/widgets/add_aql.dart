import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:qms_app/common/color.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:qms_app/models/aql.dart';
import 'package:qms_app/presentation/category_manage/controllers/aql_c.dart';
import 'package:qms_app/presentation/category_manage/widgets/textfield_custom.dart';

class AddAql extends StatelessWidget {
  final bool create;
  AQLModel? aql;
  AddAql({
    super.key,
    required this.create,
    this.aql,
  });
  final controller = Get.find<AQLController>();

  final TextEditingController checkLimitController = TextEditingController();
  final TextEditingController acceptanceLimitController =
      TextEditingController();
  final TextEditingController ngLimitController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    checkLimitController.text = aql?.checkLimit.toString() ?? '';
    acceptanceLimitController.text = aql?.acceptanceLimit.toString() ?? '';
    ngLimitController.text = aql?.ngLimit.toString() ?? '';
    noteController.text = aql?.note ?? '';
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(width: 20),
                  const Text(
                    'Thông tin chỉ tiêu AQL',
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
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextFieldCustom(
                        label: 'Mức kiểm tra',
                        textcontroller: checkLimitController,
                        width: 172,
                      ),
                      TextFieldCustom(
                        label: 'Mức chấp nhận',
                        textcontroller: acceptanceLimitController,
                        width: 172,
                      ),
                      TextFieldCustom(
                        label: 'Lỗi cho phép',
                        textcontroller: ngLimitController,
                        width: 172,
                      ),
                    ],
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
                          ? controller.addAql(AQLModel(
                              id: aql?.id,
                              checkLimit: int.parse(checkLimitController.text),
                              acceptanceLimit:
                                  int.parse(acceptanceLimitController.text),
                              ngLimit: int.parse(ngLimitController.text),
                              note: noteController.text,
                            ))
                          : controller.updateAql(AQLModel(
                              id: aql?.id,
                              checkLimit: int.parse(checkLimitController.text),
                              acceptanceLimit:
                                  int.parse(acceptanceLimitController.text),
                              ngLimit: int.parse(ngLimitController.text),
                              note: noteController.text,
                            ));
                    },
                    child: Text(
                      (create) ? 'Thêm mới' : 'Cập nhật thông tin',
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
