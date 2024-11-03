class IQCReportModel {
  String? id;
  String? iqcReportCode;
  String? materialCode;
  String? materialName;
  String? quantity;
  String? checkDate;
  String? conclusion;
  String? poCode;
  String? iqcRequestId;
  String? warehouseId;
  String? billNumber;
  String? checkQuantity;

  IQCReportModel(
      {this.id,
      this.iqcReportCode,
      this.materialCode,
      this.materialName,
      this.quantity,
      this.checkDate,
      this.conclusion,
      this.poCode,
      this.iqcRequestId,
      this.warehouseId,
      this.billNumber,
      this.checkQuantity});

  IQCReportModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    iqcReportCode = json['iqc_report_code'];
    materialCode = json['material_code'];
    materialName = json['material_name'];
    quantity = json['quantity'];
    checkDate = json['check_date'];
    conclusion = json['conclusion'];
    poCode = json['po_code'];
    iqcRequestId = json['iqc_request_id'];
    warehouseId = json['warehouse_id'];
    billNumber = json['bill_number'];
    checkQuantity = json['check_quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['iqc_report_code'] = iqcReportCode;
    data['material_code'] = materialCode;
    data['material_name'] = materialName;
    data['quantity'] = quantity;
    data['check_date'] = checkDate;
    data['conclusion'] = conclusion;
    data['po_code'] = poCode;
    data['iqc_request_id'] = iqcRequestId;
    data['warehouse_id'] = warehouseId;
    data['bill_number'] = billNumber;
    data['check_quantity'] = checkQuantity;
    return data;
  }
}
