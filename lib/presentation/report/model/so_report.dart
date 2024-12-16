import 'package:qms_app/models/oqc_info.dart';
import 'package:qms_app/models/oqc_result.dart';
import 'package:qms_app/models/work_order.dart';

class SoReportModel {
  WorkOrderModel? workOrderModel;
  int? planQquantity;
  int? totalQuantity;

  SoReportModel({this.workOrderModel, this.planQquantity, this.totalQuantity});

  Map<String, dynamic> toJson() {
    return {
      'workOrderModel': workOrderModel?.toJson(),
      'planQquantity': planQquantity,
      'totalQuantity': totalQuantity,
    };
  }
}
