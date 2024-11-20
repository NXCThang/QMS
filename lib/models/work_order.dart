import 'package:qms_app/models/oqc_info.dart';

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
      this.updatedBy});

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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['work_order_code'] = this.workOrderCode;
    data['product_id'] = this.productId;
    data['product_name'] = this.productName;
    data['quantity'] = this.quantity;
    data['created_by'] = this.createdBy;
    data['created_at'] = this.createdAt;
    data['start_date'] = this.startDate;
    data['due_date'] = this.dueDate;
    data['note'] = this.note;
    data['is_active'] = this.isActive;
    data['updated_at'] = this.updatedAt;
    data['updated_by'] = this.updatedBy;
    return data;
  }
}
