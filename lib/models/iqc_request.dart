class IqcRequestModel {
  int? id;
  String? iqcRequestCode;
  String? poCode;
  String? warehouseName;
  String? warehouseType;
  String? dueDate;
  String? createdAt;

  IqcRequestModel(
      {this.id,
      this.iqcRequestCode,
      this.poCode,
      this.warehouseName,
      this.warehouseType,
      this.dueDate,
      this.createdAt});

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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['iqc_request_code'] = this.iqcRequestCode;
    data['po_code'] = this.poCode;
    data['warehouse_name'] = this.warehouseName;
    data['warehouse_type'] = this.warehouseType;
    data['due_date'] = this.dueDate;
    data['created_at'] = this.createdAt;
    return data;
  }
}
