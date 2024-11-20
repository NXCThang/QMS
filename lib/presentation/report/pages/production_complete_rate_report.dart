import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qms_app/common/color.dart';
import 'package:qms_app/common/icon_path.dart';
import 'package:qms_app/presentation/widgets/add_error.dart';
import 'package:qms_app/presentation/widgets/table_custom.dart';

class ProductionCompleteRateReport extends StatelessWidget {
  const ProductionCompleteRateReport({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black.withOpacity(0.1), width: 1),
      ),
      margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              appLocalizations?.production_order_completion_rate_report ?? '',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24),
            )
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextFieldCustom(
              label: appLocalizations?.minutesTemplateName ?? '',
              width: 300,
              hintText: appLocalizations?.minutesTemplateName ?? '',
            ),
            TextFieldCustom(
              label: appLocalizations?.minutesTemplateType ?? '',
              width: 300,
            ),
            TextFieldCustom(
              label: appLocalizations?.minutesTemplateCode ?? '',
              width: 300,
              hintText: appLocalizations?.minutesTemplateCode ?? '',
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Danh sách yêu cầu IQC(10)',
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
            ),
            const Spacer(),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.all(0),
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (_) => const AddError(
                              error: 'Thêm mới',
                            ));
                  },
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
                        'Thêm mới',
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
            ItemTitleWidget(title: 'Tên mẫu biên bản'): 4,
            ItemTitleWidget(title: 'Mã biên bản'): 2,
            ItemTitleWidget(title: 'Trạng thái'): 2,
            ItemTitleWidget(title: 'Loại biên bản'): 2,
            ItemTitleWidget(title: 'Ngày tạo'): 2,
            ItemTitleWidget(title: 'Tùy chọn'): 2
          },
        ),
      ]),
    );
  }
}
