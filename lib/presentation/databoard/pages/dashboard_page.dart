import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:qms_app/common/color.dart';
import 'package:qms_app/presentation/databoard/widgets/so_chart.dart';
import 'package:qms_app/presentation/databoard/widgets/wo_char.dart';
import 'package:qms_app/presentation/oqc/controllers/oqc_result_c.dart';
import 'package:qms_app/presentation/report/controllers/report_ng_ok_c.dart';
import 'package:qms_app/presentation/report/controllers/so_report_c.dart';

class DashboardPages extends StatelessWidget {
  DashboardPages({super.key});
  final controller = Get.find<ReportNgOkController>();

  final List<Color> colorList = [
    Colors.red,
    Colors.green,
  ];
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(
            child: CircularProgressIndicator(
          color: QMSColor.mainorange,
        ));
      } else {
        final Map<String, double> dataMap = {
          "NG": controller.getTotalNGQuantity().toDouble(),
          "OK": controller.getTotalNGQuantity().toDouble()
        };

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: PieChart(
                dataMap: dataMap,
                animationDuration: const Duration(milliseconds: 800),
                chartLegendSpacing: 32,
                chartRadius: MediaQuery.of(context).size.width / 5,
                colorList: colorList,
                initialAngleInDegree: 270,
                chartType: ChartType.ring,
                ringStrokeWidth: 32,
                centerText: "Tổng số BTP/TP\n171,920",
                legendOptions: const LegendOptions(
                  showLegendsInRow: false,
                  legendPosition: LegendPosition.bottom,
                  showLegends: true,
                  legendShape: BoxShape.circle,
                  legendTextStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                chartValuesOptions: const ChartValuesOptions(
                  showChartValueBackground: true,
                  showChartValues: true,
                  showChartValuesInPercentage: true,
                  showChartValuesOutside: false,
                  decimalPlaces: 1,
                ),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SOChart(),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: WOChart(),
                ),
              ],
            ),
          ],
        );
      }
    });
  }
}
