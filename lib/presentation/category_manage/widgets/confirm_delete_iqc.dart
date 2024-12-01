import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qms_app/common/color.dart';
import 'package:qms_app/common/components/custom_button.dart';
import 'package:qms_app/models/iqc_result.dart';
import 'package:qms_app/presentation/category_manage/controllers/iqc_result_c.dart';

class DeleteIQCPopup extends StatelessWidget {
  DeleteIQCPopup({super.key, required this.iqcResult});
  final IQCResultModel iqcResult;
  final controller = Get.find<IqcResultController>();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 530,
        height: 260,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 16),
              Text(
                'Xóa tiêu chí',
                style: TextStyle(
                  fontSize: 20,
                  height: 30 / 22,
                  fontWeight: FontWeight.w600,
                  color: QMSColor.mainorange,
                ),
              ),
              const SizedBox(height: 12),
              Text.rich(
                textAlign: TextAlign.center,
                TextSpan(
                  text: 'Bạn chắc chắn muốn xóa tiêu chí',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: iqcResult.criteriaName,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: ' ?',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: 454,
                height: 80,
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                    color: QMSColor.orangetableheader, // Màu nền cam nhạt
                    border: Border(
                        left: BorderSide(
                            color: QMSColor.mainorange, width: 4))), // Viền cam

                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.warning_amber_rounded,
                      color: const Color(0xFFFFAB40),
                      size: 24,
                    ),
                    const SizedBox(
                        width: 12), // Khoảng cách giữa icon và nội dung
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          text: 'Lưu ý: ',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF000000), // Màu chữ đen
                            fontSize: 16,
                          ),
                          children: [
                            TextSpan(
                              text:
                                  'Nếu bạn xóa tiêu chí này thì các dữ liệu liên quan đến tiêu chí này đều sẽ không còn được dùng trong hệ thống nữa!',
                              style: const TextStyle(
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(
                    text: 'Hủy',
                    textColor: Colors.black,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    borderColor: null,
                    backgroundColor: QMSColor.maingrey,
                  ),
                  const SizedBox(width: 48),
                  CustomButton(
                    text: 'Đồng ý',
                    textColor: Colors.white,
                    onPressed: () {
                      controller.deleteIqcResult(iqcResult.id.toString());
                    },
                    borderColor: null,
                    backgroundColor: QMSColor.mainorange,
                  ),
                  const SizedBox(width: 20),
                ],
              ),
              SizedBox(height: 4),
            ],
          ),
        ),
      ),
    );
  }
}
