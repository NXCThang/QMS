import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:qms_app/common/color.dart';
import 'package:qms_app/common/components/custom_button.dart';
import 'package:qms_app/common/components/main_page.dart';
import 'package:qms_app/common/extensions/date_time_format.dart';
import 'package:qms_app/common/icon_path.dart';
import 'package:qms_app/common/sidebar/controller/sidebar_c.dart';
import 'package:qms_app/models/iqc_report.dart';
import 'package:qms_app/presentation/category_manage/pages/template.dart';
import 'package:qms_app/presentation/iqc/widgets/material_report_list.dart';
import 'package:qms_app/presentation/widgets/table_custom.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class IqcReportList extends StatelessWidget {
  const IqcReportList({super.key, required this.iqcReportList});
  final List<IQCReportModel> iqcReportList;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    final sidebarController = Get.find<SideBarController>();
    print('iqcReportList: $iqcReportList');
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Danh sách NVL, LKDT',
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
              ),
            ],
          ),
          const SizedBox(height: 10),
          TableCustom(
            title: {
              ItemTitleWidget(title: 'Mã NVL'): 3,
              ItemTitleWidget(title: 'Tên NVL'): 3,
              ItemTitleWidget(title: 'Số lượng yêu cầu'): 3,
              ItemTitleWidget(title: 'Ngày yêu cầu'): 2,
              ItemTitleWidget(title: 'Kết luận'): 2,
              ItemTitleWidget(title: 'Trạng thái'): 2,
              ItemTitleWidget(title: 'Thao tác'): 2,
            },
          ),
          SizedBox(
            height: 50 * iqcReportList.length.toDouble(),
            child: ListView.builder(
              itemCount: iqcReportList.length,
              itemBuilder: (BuildContext context, int index) {
                final item = iqcReportList[index];
                return Column(
                  children: [
                    TableCustom(color: Colors.white, title: {
                      ItemBodyWidget(title: item.materialCode.toString()): 3,
                      ItemBodyWidget(title: item.materialName.toString()): 3,
                      ItemBodyWidget(title: item.quantity.toString()): 3,
                      ItemBodyWidget(
                          title: item.checkDate?.formatDateTime() ?? ''): 2,
                      ItemBodyWidget(title: item.conclusion.toString()): 2,
                      ItemBodyWidget(title: item.isActive.toString()): 2,
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              if (item.isActive?.toLowerCase() ==
                                  'Nháp'.toLowerCase())
                                IconButton(
                                    onPressed: () {}, icon: Icon(Icons.edit)),
                              IconButton(
                                  onPressed: () {
                                    print(item.toJson());
                                    sidebarController.changePageWithArguments(
                                      'Danh sách biên bản NVL',
                                      {
                                        'IqcReportModel': item.toJson()
                                      }, // Make sure the key matches the one in the destination screen
                                    );
                                  },
                                  icon: Icon(Icons.info)),
                            ],
                          )): 2,
                    }),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
