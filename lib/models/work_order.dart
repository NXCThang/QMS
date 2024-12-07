import 'package:qms_app/models/material.dart';

class WorkOrderModel {
  int? id;
  String? workOrderCode;
  int? productId;
  String? productName;
  int? quantity;
  String? createdBy;
  String? createdAt;
  String? startDate;
  String? dueDate;
  String? note;
  int? isActive;
  int? updatedAt;
  int? updatedBy;
  List<MaterialModel>? materials;

  WorkOrderModel(
      {this.id,
      this.workOrderCode,
      this.productId,
      this.productName,
      this.quantity,
      this.createdBy,
      this.createdAt,
      this.startDate,
      this.dueDate,
      this.note,
      this.isActive,
      this.updatedAt,
      this.updatedBy,
      this.materials});

  WorkOrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    workOrderCode = json['work_order_code'];
    productId = json['product_id'];
    productName = json['product_name'];
    quantity = json['quantity'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    startDate = json['start_date'];
    dueDate = json['due_date'];
    note = json['note'];
    isActive = json['is_active'];
    updatedAt = json['updated_at'];
    updatedBy = json['updated_by'];
    if (json['materials'] != null) {
      materials = <MaterialModel>[];
      json['materials'].forEach((v) {
        materials!.add(MaterialModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['work_order_code'] = workOrderCode;
    data['product_id'] = productId;
    data['product_name'] = productName;
    data['quantity'] = quantity;
    data['created_by'] = createdBy;
    data['created_at'] = createdAt;
    data['start_date'] = startDate;
    data['due_date'] = dueDate;
    data['note'] = note;
    data['is_active'] = isActive;
    data['updated_at'] = updatedAt;
    data['updated_by'] = updatedBy;
    data['materials'] =
        materials?.map((material) => material.toJson()).toList();
    return data;
  }
}
