import 'package:qms_app/models/oqc_info.dart';
import 'package:qms_app/models/oqc_result.dart';
import 'package:qms_app/models/work_order.dart';

class ReportNgOkModel {
  WorkOrderModel? workOrderModel;
  int? ngQuantity;
  int? totalQuantity;

  ReportNgOkModel({this.workOrderModel, this.ngQuantity, this.totalQuantity});
}
