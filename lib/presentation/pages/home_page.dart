import 'package:flutter/material.dart';
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
              title: const Text('FaceNet'),
            ),
            body: Row(
              children: [
                Container(
                  child: const Column(
                    children: [
                      Text('Quản lý danh mục'),
                      TitleWidget(title: 'Kiểm tra IQC')
                    ],
                  ),
                )
              ],
            )));
  }
}
