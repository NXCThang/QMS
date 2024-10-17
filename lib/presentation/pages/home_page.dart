import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qms_app/common/color.dart';
import 'package:qms_app/common/icon_path.dart';
import 'package:qms_app/common/widgets/side_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:qms_app/presentation/widgets/data_table_row.dart';
import 'package:qms_app/presentation/widgets/title_table.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    return SafeArea(
        child: Scaffold(
            appBar: _appbar(context),
            body: Row(
              children: [
                const SideBarWidget(),
                Expanded(
                    child: Container(
                  color: Colors.black12,
                  margin: const EdgeInsets.only(left: 24, right: 24, top: 60),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            color: Colors.white,
                            padding: const EdgeInsets.only(left: 23),
                            // padding: const EdgeInsets.only(left: 24, top: 14),
                            child: const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Danh sách yêu cầu IQC hàng hóa',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 24),
                                    )
                                  ],
                                )
                              ],
                            ))
                        // Text('Quản lý danh mục >'),
                        // Row(
                        //   children: [Text('Danh sách lỗi/ nhóm lỗi')],
                        // )
                        ,
                        Text(
                          appLocalizations?.generalSearch ?? '',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.black.withOpacity(0.7)),
                        ),
                        TextField(
                          decoration: InputDecoration(
                              hintText:
                                  'Nhập thông tin và nhấn Enter để tìm kiếm',
                              prefixIcon: Image.asset(
                                IconPath.search,
                                width: 5,
                                height: 5,
                              ),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1,
                                      color: Colors.black.withOpacity(0.2)),
                                  borderRadius: BorderRadius.circular(4))),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Danh sách yêu cầu IQC(10)',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 18),
                            ),
                            SvgPicture.asset(
                              IconPath.addData,
                              width: 36,
                              height: 36,
                            ),
                          ],
                        ),
                        ErrorTable(),
                        // TitleTable(),
                        // SearchTitle(),
                        // Text(
                        //   'Danh sách lỗi(4)',
                        //   style: TextStyle(
                        //       fontWeight: FontWeight.w400, fontSize: 18),
                        // ),
                        // Row(
                        //   children: [
                        //     Text(appLocalizations?.errorCode ?? ''),
                        //     Text(appLocalizations?.errorName ?? ''),
                        //     Text(appLocalizations?.description ?? ''),
                        //     Text(appLocalizations?.creator ?? ''),
                        //     Text(appLocalizations?.creationTime ?? ''),
                        //     Text(appLocalizations?.status ?? ''),
                        //   ],
                        // ),
                      ]),
                ))
              ],
            )));
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

class ErrorTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Table(
        border: TableBorder(
          horizontalInside: BorderSide(
            width: 1,
            color: Colors.grey,
          ),
          verticalInside: BorderSide(
            width: 1,
            color: Colors.grey,
          ),
        ),
        columnWidths: const <int, TableColumnWidth>{
          0: FlexColumnWidth(1),
          1: FlexColumnWidth(8),
          2: FlexColumnWidth(13),
          3: FlexColumnWidth(9),
          4: FlexColumnWidth(6),
          5: FlexColumnWidth(6),
          6: FlexColumnWidth(5),
        },
        children: [
          TableRow(
            decoration: BoxDecoration(
              color: QMSColor.orangetableheader,
            ),
            children: [
              TableCell(
                  child:
                      Padding(padding: EdgeInsets.all(8.0), child: Text(''))),
              TableCell(
                  child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Mã nhóm lỗi'))),
              TableCell(
                  child: Padding(
                      padding: EdgeInsets.all(8.0), child: Text('Nhóm lỗi'))),
              TableCell(
                  child: Padding(
                      padding: EdgeInsets.all(8.0), child: Text('Mô tả'))),
              TableCell(
                  child: Padding(
                      padding: EdgeInsets.all(8.0), child: Text('Người tạo'))),
              TableCell(
                  child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Thời gian tạo'))),
              TableCell(
                  child: Padding(
                      padding: EdgeInsets.all(8.0), child: Text('Trạng thái'))),
            ],
          ),
          for (int i = 0; i < 2; i++)
            TableRow(
              decoration: BoxDecoration(
                color: i % 2 == 0 ? QMSColor.orangetableheader : Colors.white,
              ),
              children: [
                TableCell(
                    child: Padding(
                        padding: EdgeInsets.all(8.0), child: Text('icon'))),
                TableCell(
                    child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('error_0001'))),
                TableCell(
                    child: Padding(
                        padding: EdgeInsets.all(8.0), child: Text('Lỗi xước'))),
                TableCell(
                    child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Người phụ trách'))),
                TableCell(
                    child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Người tạo'))),
                TableCell(
                    child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('19-07-2023'))),
                TableCell(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        'Hoạt động',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

class ItemTitleWidget extends StatelessWidget {
  ItemTitleWidget({
    super.key,
    required this.title,
    required this.flex,
    this.assetname,
  });

  final int flex;
  final String title;
  String? assetname;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: flex,
      child: Container(
        decoration: BoxDecoration(
          // color: QMSColor.orangetableheader,
          border: Border.all(color: Colors.black.withOpacity(0.1), width: 1),
        ),
        constraints: BoxConstraints.expand(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (assetname != null)
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: SvgPicture.asset(
                    assetname!,
                    width: 10,
                    height: 10,
                    fit: BoxFit.scaleDown,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
