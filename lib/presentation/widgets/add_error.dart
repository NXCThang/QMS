import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qms_app/common/color.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddError extends StatelessWidget {
  final String error;
  const AddError({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: SizedBox(
        width: 1300,
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
                    'Thêm chi tiết định mức lỗi',
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
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // First row: Mã lỗi, Tên lỗi
                  Row(
                    children: [
                      TextFieldCustom(
                        label: appLocalizations?.errorCode ?? '',
                      ),
                      const SizedBox(width: 100),
                      TextFieldCustom(
                        label: appLocalizations?.errorName ?? '',
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // Second row: Mã job, Tên job
                  Row(
                    children: [
                      TextFieldCustom(label: appLocalizations?.jobCode ?? ''),
                      // Expanded(
                      //   child: DropdownButtonFormField<String>(
                      //     decoration: InputDecoration(
                      //       labelText: 'Mã job*',
                      //     ),
                      //     items: ['Job 1', 'Job 2', 'Job 3']
                      //         .map((job) => DropdownMenuItem(
                      //               value: job,
                      //               child: Text(job),
                      //             ))
                      //         .toList(),
                      //     onChanged: (value) {},
                      //   ),
                      // ),

                      const SizedBox(width: 100),
                      TextFieldCustom(label: appLocalizations?.jobName ?? ''),

                      // Expanded(
                      //   child: DropdownButtonFormField<String>(
                      //     decoration: InputDecoration(
                      //       labelText: 'Tên job*',
                      //     ),
                      //     items: ['Job A', 'Job B', 'Job C']
                      //         .map((job) => DropdownMenuItem(
                      //               value: job,
                      //               child: Text(job),
                      //             ))
                      //         .toList(),
                      //     onChanged: (value) {},
                      //   ),
                      // ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // Định mức cho phép
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextFieldCustom(
                          label: appLocalizations?.allowedStandard ?? ''),
                    ],
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
                          borderRadius: BorderRadius.circular(4),
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
                    width: 64,
                  ),
                  TextButton(
                    style: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.all(QMSColor.mainorange),
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      padding: WidgetStateProperty.all(
                        const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 10),
                      ),
                    ),
                    onPressed: () {},
                    child: Text(
                      'Thêm mới',
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

    //  Dialog(
    //   child: Container(
    //     width: 1300,
    //     height: 480,
    //     padding: EdgeInsets.all(20),
    //     decoration: BoxDecoration(
    //       borderRadius: BorderRadius.circular(10),
    //     ),
    //     child: Column(
    //       children: [
    //         Container(
    //           width: double.infinity,
    //           decoration: BoxDecoration(color: QMSColor.orangetableheader),
    //           child: Text(
    //             'Thêm chỉ tiêu định mức lỗi',
    //             style: TextStyle(
    //               color: Colors.white,
    //               fontSize: 20,
    //               fontWeight: FontWeight.bold,
    //             ),
    //           ),
    //         ),
    //         Row(
    //           children: [
    //             Icon(Icons.error_outline, color: Colors.white),
    //             SizedBox(width: 10),
    //             Expanded(
    //               child: Text(
    //                 error,
    //                 style: TextStyle(color: Colors.white),
    //               ),
    //             ),
    //           ],
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}

class TextFieldCustom extends StatelessWidget {
  const TextFieldCustom({
    super.key,
    required this.label,
    this.width = 560,
    this.hintText = '',
  });
  final String label;
  final double width;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: Colors.black.withOpacity(0.7),
          ),
        ),
        SizedBox(
          width: width,
          child: TextField(
            decoration: InputDecoration(
              isDense: true,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
              hintText: hintText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4.0),
                borderSide: BorderSide(
                  color: Colors.black.withOpacity(0.2),
                  width: 1.0,
                ),
              ),
            ),
          ),
        ),
      ],
    ).paddingOnly(right: 20);
  }
}
