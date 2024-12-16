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
    if (json['iqcResultList'] != null) {
      iqcResultList = <IQCResultModel>[];
      json['iqcResultList'].forEach((v) {
        iqcResultList!.add(IQCResultModel.fromJson(v));
      });
    }
    if (json['iqcResultNgList'] != null) {
      iqcResultNgList = <IQCResultNgModel>[];
      json['iqcResultNgList'].forEach((v) {
        iqcResultNgList!.add(IQCResultNgModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (id != null) data['id'] = id;
    if (iqcReportCode != null) data['iqc_report_code'] = iqcReportCode;
    if (materialCode != null) data['material_code'] = materialCode;
    if (materialName != null) data['material_name'] = materialName;
    if (checkDate != null) data['check_date'] = checkDate;
    if (conclusion != null) data['conclusion'] = conclusion;
    if (poCode != null) data['po_code'] = poCode;
    if (iqcRequestId != null) data['iqc_request_id'] = iqcRequestId;
    if (warehouseId != null) data['warehouse_id'] = warehouseId;
    if (billNumber != null) data['bill_number'] = billNumber;
    if (isActive != null) data['is_active'] = isActive;
    if (quantity != null) data['quantity'] = quantity;
    data['iqcResultList'] =
        iqcResultList?.map((result) => result.toJson()).toList();
    data['iqcResultNgList'] =
        iqcResultNgList?.map((resultNG) => resultNG.toJson()).toList();
    return data;
  }
}
