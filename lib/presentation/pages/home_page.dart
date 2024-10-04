import 'package:flutter/material.dart';
import 'package:qms_app/common/color.dart';
import 'package:qms_app/presentation/widgets/title_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: QMSColor.blueheader,
              title: const Text('FaceNet'),
            ),
            body: Row(
              children: [
                Container(
                  width: 300,
                  decoration: const BoxDecoration(
                    color: QMSColor.main_grey,
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TitleWidget(title: 'Quản lý danh mục'),
                      TitleWidget(title: 'Kiểm tra IQC'),
                      TitleWidget(title: 'Kiểm tra PQC'),
                      TitleWidget(title: 'Báo cáo, thông kê')
                    ],
                  ),
                ),
                Expanded(
                    child: Container(
                  child: const Padding(
                    padding: EdgeInsets.only(left: 24, top: 4),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Quản lý danh mục >'),
                          Row(
                            children: [Text('Danh sách lỗi/ nhóm lỗi')],
                          )
                        ]),
                  ),
                ))
              ],
            )));
  }
}
