import 'package:qms_app/models/oqc_info.dart';
import 'package:qms_app/models/oqc_result.dart';
import 'package:qms_app/models/work_order.dart';

class ReportNgOkModel {
  WorkOrderModel? workOrderModel;
  OQCInfoModel? oqcInfoModel;
  OQCResultModel? oqcResultModel;

  ReportNgOkModel(
      {this.workOrderModel, this.oqcInfoModel, this.oqcResultModel});
}
