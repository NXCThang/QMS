import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:qms_app/common/color.dart';
import 'package:qms_app/presentation/controllers/oqc_result_c.dart';

class DashboardPages extends StatelessWidget {
  DashboardPages({super.key});
  final controller = Get.find<OqcResultController>();

  final List<Color> colorList = [
    Colors.red, // Color for NG
    Colors.green, // Color for OK
  ];
  @override
  Widget build(BuildContext context) {
    final Map<String, double> dataMap = {
      "NG": controller.getTotalNGQuantity().toDouble(), // NG amount
      "OK": (controller.getTotalQuantity() - controller.getTotalNGQuantity())
          .toDouble(), // OK amount
    };

    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(
            child: CircularProgressIndicator(
          color: QMSColor.mainorange,
        ));
      } else {
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
            OrderCompletionChart(),
          ],
        );
      }
    });
  }
}

class OrderCompletionChart extends StatelessWidget {
  final List<Map<String, dynamic>> ranges = [
    {"range": "80-100%", "percent": 0.0},
    {"range": "60-80%", "percent": 0.0},
    {"range": "40-60%", "percent": 0.0},
    {"range": "20-40%", "percent": 0.0},
    {"range": "0-20%", "percent": 1.0},
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Tỉ lệ hoàn thành theo đơn hàng",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              "Tổng số đơn hàng: 1",
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              textAlign: TextAlign.right,
            ),
            Divider(),
            ...ranges.map((data) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 60, // Fixed width for range column
                        child: Text(
                          data["range"],
                          style:
                              TextStyle(fontSize: 12, color: Colors.grey[700]),
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: LinearPercentIndicator(
                          lineHeight: 14.0,
                          percent: data["percent"],
                          backgroundColor: Colors.grey[200]!,
                          progressColor: Colors.purple,
                          barRadius: Radius.circular(8),
                        ),
                      ),
                      SizedBox(width: 8),
                      SizedBox(
                        width: 40, // Fixed width for trailing percent column
                        child: Text(
                          "${(data["percent"] * 100).toStringAsFixed(0)}%",
                          style: TextStyle(fontSize: 12.0),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
