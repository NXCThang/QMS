import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:qms_app/common/color.dart';
import 'package:qms_app/common/components/build_pagination_controls.dart';
import 'package:qms_app/common/extensions/date_time_format.dart';
import 'package:qms_app/common/icon_path.dart';
import 'package:qms_app/common/sidebar/controller/sidebar_c.dart';
import 'package:qms_app/models/iqc_report.dart';
import 'package:qms_app/models/iqc_request.dart';
import 'package:qms_app/models/iqc_result.dart';
import 'package:qms_app/presentation/category_manage/controllers/iqc_result_c.dart';
import 'package:qms_app/presentation/category_manage/widgets/iqc_result_list.dart';
import 'package:qms_app/presentation/category_manage/widgets/textfield_custom.dart';
import 'package:qms_app/presentation/controllers/material_c.dart';
import 'package:qms_app/presentation/iqc/widgets/add_error_info.dart';
import 'package:qms_app/presentation/iqc/widgets/conclusion.dart';
import 'package:qms_app/presentation/iqc/widgets/iqc_result_list.dart';
import 'package:qms_app/presentation/widgets/table_custom.dart';

class MaterialReportList extends StatefulWidget {
  MaterialReportList({
    super.key,
    this.iqcReportModel,
  });

  IQCReportModel? iqcReportModel;
  @override
  State<MaterialReportList> createState() => _MaterialReportListState();
}

class _MaterialReportListState extends State<MaterialReportList> {
  late TextEditingController materialCodeController = TextEditingController();
  late TextEditingController materialNameController = TextEditingController();
  late TextEditingController checkDateController = TextEditingController();
  late TextEditingController receiveDateController = TextEditingController();
  late TextEditingController billNumberController = TextEditingController();
  late TextEditingController quantityController = TextEditingController();

  @override
  void initState() {
    print(widget.iqcReportModel);
    materialCodeController.text = widget.iqcReportModel?.materialCode ?? '';
    materialNameController.text = widget.iqcReportModel?.materialName ?? '';
    checkDateController.text = widget.iqcReportModel?.checkDate ?? '';
    billNumberController.text =
        widget.iqcReportModel?.billNumber.toString() ?? '';
    quantityController.text = widget.iqcReportModel?.quantity.toString() ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isEditable = widget.iqcReportModel?.isActive == 'Nháp';
    final appLocalizations = AppLocalizations.of(context);
    final controller = Get.find<MaterialController>();
    final iqcResultController = Get.find<IqcResultController>();
    final sidebarController = Get.find<SideBarController>();
    return Scaffold(
      body: Container(
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
                'Danh sách biên bản NVL',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24),
              )
            ],
          ),
          const SizedBox(
            height: 16,
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
              if (isEditable)
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.all(0),
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {},
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
            height: 10,
          ),
          Row(
            children: [
              TextFieldCustom(
                width: 320,
                label: 'Mã vật tư',
                textcontroller: materialCodeController,
                enabled: isEditable,
              ),
              TextFieldCustom(
                  width: 320,
                  label: 'Tên vật tư',
                  textcontroller: materialNameController,
                  enabled: isEditable),
              TextFieldCustom(
                  width: 320,
                  label: 'Ngày kiểm',
                  textcontroller: checkDateController,
                  enabled: isEditable),
            ],
          ),
          Row(
            children: [
              TextFieldCustom(
                  width: 320,
                  label: 'Số hóa đơn',
                  textcontroller: billNumberController,
                  enabled: isEditable),
              TextFieldCustom(
                  width: 320,
                  label: 'Số lượng kiểm tra',
                  textcontroller: quantityController,
                  enabled: isEditable),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          if (isEditable)
            InkWell(
              onTap: () {
                showDialog(context: context, builder: (_) => AddErrorInfo());
              },
              child: Container(
                decoration: BoxDecoration(
                    color: QMSColor.mainorange,
                    border: Border.all(
                        color: Colors.black.withOpacity(0.1), width: 1),
                    borderRadius: BorderRadius.circular(6)),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: const Text(
                  'Thêm thông tin lỗi',
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                      color: Colors.white),
                ),
              ),
            ),
          IqcResultListTemporary(
            enable: isEditable,
            list: widget.iqcReportModel?.iqcResultList ?? [],
          ),
          const SizedBox(
            height: 10,
          ),
          ConclusionWidget(
            enable: isEditable,
            value: widget.iqcReportModel?.conclusion ?? 1,
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () {
                  sidebarController.changePage('Danh sách yêu cầu IQC');
                },
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.black.withOpacity(0.1), width: 1),
                      borderRadius: BorderRadius.circular(2)),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: const Text(
                    'Trở lại',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              if (isEditable)
                InkWell(
                  onTap: () {
                    // sidebarController.changePage('Danh sách yêu cầu IQC');
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.black.withOpacity(0.1), width: 1),
                        borderRadius: BorderRadius.circular(2)),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: const Text(
                      'Gửi duyệt',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ).paddingOnly(left: 16),
            ],
          )
        ]),
      ),
    );
  }
}
