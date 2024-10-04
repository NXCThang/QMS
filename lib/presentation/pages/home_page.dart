import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qms_app/common/color.dart';
import 'package:qms_app/common/icon_path.dart';
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
              title: Row(
                children: [
                  SizedBox(
                    width: 330,
                    child: GestureDetector(
                        onTap: () {}, child: const Text('Facenet')),
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
              )
              // const Text('FaceNet')
              ,
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
            ),
            body: Row(
              children: [
                Container(
                  width: 330,
                  decoration: const BoxDecoration(
                    color: QMSColor.main_grey,
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TitleWidget(
                          icon: IconPath.dashboard, title: 'QUẢN LÝ DANH MỤC'),
                      TitleWidget(
                          icon: IconPath.dashboard, title: 'KIỂM TRA IQC'),
                      TitleWidget(
                          icon: IconPath.dashboard, title: 'KIỂM TRA PQC'),
                      TitleWidget(
                          icon: IconPath.dashboard, title: 'KIỂM TRA OQC'),
                      TitleWidget(
                          icon: IconPath.dashboard, title: 'BÁO CÁO, THÔNG KÊ'),
                    ],
                  ),
                ),
                Expanded(
                    child: Container(
                  color: Colors.black12,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                            padding: const EdgeInsets.only(left: 24, top: 14),
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
                          'Tìm kiếm chung',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.black.withOpacity(0.7)),
                        ),
                        TextField(
                          decoration: InputDecoration(
                              hintText:
                                  'Nhập thông tin và nhấn Enter để tìm kiếm',
                              prefixIcon: SvgPicture.asset(
                                IconPath.search,
                                width: 16,
                                height: 16,
                              ),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1,
                                      color: Colors.black.withOpacity(0.2)),
                                  borderRadius: BorderRadius.circular(4))),
                        ),
                        const Row(
                          children: [
                            Text(
                              'Danh sách yêu cầu IQC(10)',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 18),
                            ),
                          ],
                        ),
                        const Text(
                          'Kiểm tra IQC',
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 18),
                        ),
                        const Text(
                          'Danh sách yêu cầu IQC hàng hóa',
                          style: TextStyle(
                              color: QMSColor.main_orange,
                              fontWeight: FontWeight.w400,
                              fontSize: 18),
                        )
                      ]),
                ))
              ],
            )));
  }
}
