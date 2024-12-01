import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:qms_app/common/color.dart';
import 'package:qms_app/common/components/main_page.dart';
import 'package:qms_app/common/extensions/date_time_format.dart';
import 'package:qms_app/common/icon_path.dart';
import 'package:qms_app/common/sidebar/controller/sidebar_c.dart';
import 'package:qms_app/common/sidebar/widgets/side_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:qms_app/common/components/two_button.dart';
import 'package:qms_app/presentation/category_manage/controllers/template_c.dart';
import 'package:qms_app/presentation/widgets/add_error.dart';
import 'package:qms_app/presentation/widgets/table_custom.dart';

class MinutesPage extends StatefulWidget {
  const MinutesPage({super.key});

  @override
  State<MinutesPage> createState() => _MinutesPageState();
}

class _MinutesPageState extends State<MinutesPage> {
  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    return SafeArea(
        child: Scaffold(
            appBar: _appbar(context),
            body: Row(
              children: [const SideBarWidget(), Expanded(child: MainPage())],
            )));
  }
}

class InspectionRecordPage extends StatelessWidget {
  InspectionRecordPage({
    super.key,
  });
  final controller = Get.find<TemplateController>();
  final sidebarController = Get.find<SideBarController>();

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(
          child: CircularProgressIndicator(
            color: QMSColor.mainorange,
          ),
        );
      }
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
                appLocalizations?.inspectionReportSample ?? '',
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
              Text(
                'Danh sách mẫu biên bản kiểm tra (${controller.templateList.length})',
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
              ItemTitleWidget(
                title: '#',
              ): 1,
              ItemTitleWidget(title: 'Tên mẫu biên bản'): 4,
              ItemTitleWidget(title: 'Mã biên bản'): 2,
              ItemTitleWidget(title: 'Trạng thái'): 2,
              ItemTitleWidget(title: 'Loại biên bản'): 2,
              ItemTitleWidget(title: 'Ngày tạo'): 2,
              ItemTitleWidget(title: 'Tùy chọn'): 2
            },
          ),
          Expanded(
            child: ListView.builder(
              itemCount: controller.templateList.length,
              itemBuilder: (BuildContext context, int index) {
                return TableCustom(color: Colors.white, title: {
                  ItemBodyWidget(
                      title: controller.templateList[index].id.toString()): 1,
                  ItemBodyWidget(
                      title: controller.templateList[index].templateName
                          .toString()): 4,
                  ItemBodyWidget(
                      title: controller.templateList[index].templateCode
                          .toString()): 2,
                  ItemBodyWidget(
                      title: controller.templateList[index].isActive
                          .toString()): 2,
                  ItemBodyWidget(
                      title: controller.templateList[index].templateType
                          .toString()): 2,
                  ItemBodyWidget(
                      title: controller.templateList[index].createdAt
                              ?.formatDateTime() ??
                          ''): 2,
                  CustomButtonRow(
                    onDelete: () {},
                    onEdit: () {
                      sidebarController
                          .changePage(appLocalizations?.editTemplate ?? '');
                    },
                  ): 2
                });
              },
            ),
          ),
        ]),
      );
    });
  }
}

@override
PreferredSizeWidget _appbar(BuildContext context) {
  return AppBar(
    backgroundColor: QMSColor.blueheader,
    title: Row(
      children: [
        SizedBox(
          width: 330,
          child: GestureDetector(onTap: () {}, child: const Text('Facenet')),
        ),
        SvgPicture.asset(
          IconPath.menu,
          width: 22,
          height: 18,
        ),
        const SizedBox(width: 19),
        const Text(
          'Quality Management System',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        )
      ],
    ),
    actions: [
      const Icon(
        Icons.person_pin,
        weight: 40,
      ),
      const SizedBox(
        width: 7,
      ),
      const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Xin chào',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w400),
            ),
            Text(
              'Lô Quỳnh Như',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 16),
            )
          ]),
      const SizedBox(width: 24),
      GestureDetector(
          onTap: () {},
          child: SvgPicture.asset(
            IconPath.fullscreen,
            width: 24,
            height: 24,
          )),
      const SizedBox(
        width: 24,
      ),
      GestureDetector(
          onTap: () {},
          child: SvgPicture.asset(
            IconPath.notification,
            width: 24,
            height: 24,
          )),
      const SizedBox(
        width: 24,
      ),
      GestureDetector(
          onTap: () {},
          child: SvgPicture.asset(
            IconPath.logout,
            width: 24,
            height: 24,
          )),
      const SizedBox(
        width: 40,
      )
    ],
  );
}

class ItemSearch extends StatelessWidget {
  const ItemSearch({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Image.asset(
              IconPath.search,
              width: 16,
              height: 16,
              fit: BoxFit.scaleDown,
            ),
          ),
        ],
      ),
    );
  }
}
