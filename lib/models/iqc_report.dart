import 'package:qms_app/models/iqc_result.dart';
import 'package:qms_app/models/iqc_result_ng.dart';

class IQCReportModel {
  int? id;
  String? iqcReportCode;
  String? materialCode;
  String? materialName;
  String? checkDate;
  int? conclusion;
  String? poCode;
  int? iqcRequestId;
  int? warehouseId;
  int? billNumber;
  String? isActive;
  int? quantity;
  List<IQCResultModel>? iqcResultList;
  List<IQCResultNgModel>? iqcResultNgList;

  IQCReportModel(
      {this.id,
      this.iqcReportCode,
      this.materialCode,
      this.materialName,
      this.checkDate,
      this.conclusion,
      this.poCode,
      this.iqcRequestId,
      this.warehouseId,
      this.billNumber,
      this.isActive,
      this.quantity,
      this.iqcResultList,
      this.iqcResultNgList});

  IQCReportModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    iqcReportCode = json['iqc_report_code'];
    materialCode = json['material_code'];
    materialName = json['material_name'];
    checkDate = json['check_date'];
    conclusion = json['conclusion'];
    poCode = json['po_code'];
    iqcRequestId = json['iqc_request_id'];
    warehouseId = json['warehouse_id'];
    billNumber = json['bill_number'];
    isActive = json['is_active'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['iqc_report_code'] = iqcReportCode;
    data['material_code'] = materialCode;
    data['material_name'] = materialName;
    data['check_date'] = checkDate;
    data['conclusion'] = conclusion;
    data['po_code'] = poCode;
    data['iqc_request_id'] = iqcRequestId;
    data['warehouse_id'] = warehouseId;
    data['bill_number'] = billNumber;
    data['is_active'] = isActive;
    data['quantity'] = quantity;
    return data;
  }
}
