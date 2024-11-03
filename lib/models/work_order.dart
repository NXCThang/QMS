class WorkOrderModel {
  String? id;
  String? workOrderCode;
  String? productId;
  String? quantity;
  String? createdBy;
  String? createdAt;
  String? startDate;
  String? dueDate;
  String? note;
  String? isActive;
  String? updatedAt;
  String? updatedBy;

  WorkOrderModel(
      {this.id,
      this.workOrderCode,
      this.productId,
      this.quantity,
      this.createdBy,
      this.createdAt,
      this.startDate,
      this.dueDate,
      this.note,
      this.isActive,
      this.updatedAt,
      this.updatedBy});

  WorkOrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    workOrderCode = json['work_order_code'];
    productId = json['product_id'];
    quantity = json['quantity'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    startDate = json['start_date'];
    dueDate = json['due_date'];
    note = json['note'];
    isActive = json['is_active'];
    updatedAt = json['updated_at'];
    updatedBy = json['updated_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['work_order_code'] = workOrderCode;
    data['product_id'] = productId;
    data['quantity'] = quantity;
    data['created_by'] = createdBy;
    data['created_at'] = createdAt;
    data['start_date'] = startDate;
    data['due_date'] = dueDate;
    data['note'] = note;
    data['is_active'] = isActive;
    data['updated_at'] = updatedAt;
    data['updated_by'] = updatedBy;
    return data;
  }
}
