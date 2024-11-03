class OQCInfoModel {
  String? id;
  String? workOrderId;
  String? model;
  String? quantity;
  String? note;
  String? createdAt;
  String? createdBy;
  String? updatedAt;
  String? updatedBy;
  String? isActive;

  OQCInfoModel(
      {this.id,
      this.workOrderId,
      this.model,
      this.quantity,
      this.note,
      this.createdAt,
      this.createdBy,
      this.updatedAt,
      this.updatedBy,
      this.isActive});

  OQCInfoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    workOrderId = json['work_order_id'];
    model = json['model'];
    quantity = json['quantity'];
    note = json['note'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    updatedAt = json['updated_at'];
    updatedBy = json['updated_by'];
    isActive = json['is_active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['work_order_id'] = workOrderId;
    data['model'] = model;
    data['quantity'] = quantity;
    data['note'] = note;
    data['created_at'] = createdAt;
    data['created_by'] = createdBy;
    data['updated_at'] = updatedAt;
    data['updated_by'] = updatedBy;
    data['is_active'] = isActive;
    return data;
  }
}
