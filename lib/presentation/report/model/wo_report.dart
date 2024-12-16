import 'package:qms_app/models/oqc_info.dart';
import 'package:qms_app/models/oqc_result.dart';
import 'package:qms_app/models/work_order.dart';

class WoReportModel {
  WorkOrderModel? workOrderModel;
  int? woquantity;
  int? totalQuantity;

  WoReportModel({this.workOrderModel, this.woquantity, this.totalQuantity});
}
