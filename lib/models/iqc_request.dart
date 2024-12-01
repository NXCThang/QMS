import 'package:qms_app/models/iqc_report.dart';

class IqcRequestModel {
  int? id;
  String? iqcRequestCode;
  String? poCode;
  String? warehouseName;
  String? warehouseType;
  String? dueDate;
  String? createdAt;
  List<IQCReportModel>? reports;
  bool? isStatus;

  IqcRequestModel(
      {this.id,
      this.iqcRequestCode,
      this.poCode,
      this.warehouseName,
      this.warehouseType,
      this.dueDate,
      this.createdAt,
      this.reports,
      this.isStatus});

  IqcRequestModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    iqcRequestCode = json['iqc_request_code'];
    poCode = json['po_code'];
    warehouseName = json['warehouse_name'];
    warehouseType = json['warehouse_type'];
    dueDate = json['due_date'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['iqc_request_code'] = iqcRequestCode;
    data['po_code'] = poCode;
    data['warehouse_name'] = warehouseName;
    data['warehouse_type'] = warehouseType;
    data['due_date'] = dueDate;
    data['created_at'] = createdAt;
    return data;
  }
}
