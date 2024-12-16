import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:qms_app/common/color.dart';
import 'package:qms_app/presentation/databoard/widgets/so_chart.dart';
import 'package:qms_app/presentation/oqc/controllers/oqc_result_c.dart';
import 'package:qms_app/presentation/report/controllers/report_ng_ok_c.dart';
import 'package:qms_app/presentation/report/controllers/so_report_c.dart';

class SOChart extends StatefulWidget {
  @override
  State<SOChart> createState() => _SOChartState();
}

class _SOChartState extends State<SOChart> {
  var controller = Get.find<SOReportController>();
  List<double> percentages = [];

  @override
  void initState() {
    super.initState();
    percentages = controller.reportList.map<double>((report) {
      int planQuantity = report.planQquantity ?? 1;
      int totalQuantity = report.totalQuantity ?? 0;
      return planQuantity > 0 ? (totalQuantity / planQuantity) * 100 : 0.0;
    }).toList();
  }

  List<Map<String, dynamic>> getRanges() {
    final ranges = [
      {"range": "80-100%", "percent": 0.0},
      {"range": "60-80%", "percent": 0.0},
      {"range": "40-60%", "percent": 0.0},
      {"range": "20-40%", "percent": 0.0},
      {"range": "0-20%", "percent": 0.0},
    ];

    // Phân loại giá trị phần trăm vào các khoảng
    for (var value in percentages) {
      if (value >= 80) {
        ranges[0]["percent"] = (ranges[0]["percent"] as double? ?? 0) + 1;
      } else if (value >= 60) {
        ranges[1]["percent"] = (ranges[1]["percent"] as double? ?? 0) + 1;
      } else if (value >= 40) {
        ranges[2]["percent"] = (ranges[2]["percent"] as double? ?? 0) + 1;
      } else if (value >= 20) {
        ranges[3]["percent"] = (ranges[3]["percent"] as double? ?? 0) + 1;
      } else {
        ranges[4]["percent"] = (ranges[4]["percent"] as double? ?? 0) + 1;
      }
    }

    final total = percentages.length;
    for (var range in ranges) {
      range["percent"] = (range["percent"] as double? ?? 0) / total;
    }

    return ranges;
  }

  @override
  Widget build(BuildContext context) {
    final ranges = getRanges();

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
              "Tỉ lệ hoàn thành theo SO",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              "Tổng số đơn hàng: ${controller.reportList.length}",
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              textAlign: TextAlign.right,
            ),
            Divider(),
            ...ranges.map((data) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 60,
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
                          progressColor: QMSColor.mainorange,
                          barRadius: Radius.circular(8),
                        ),
                      ),
                      SizedBox(width: 8),
                      SizedBox(
                        width: 40,
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
