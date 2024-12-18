import 'package:qms_app/models/oqc_result.dart';

class OQCInfoModel {
  int? id;
  int? workOrderId;
  String? model;
  int? quantity;
  String? note;
  String? createdAt;
  String? createdBy;
  String? updatedAt;
  String? updatedBy;
  int? isActive;
  String? status;
  List<OQCResultModel>? oqcResults;

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
      this.isActive,
      this.status,
      this.oqcResults});

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
    status = json['status'];
    if (json['oqcResults'] != null) {
      oqcResults = <OQCResultModel>[];
      json['oqcResults'].forEach((v) {
        oqcResults!.add(OQCResultModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    if (id != null) data['id'] = id;
    if (workOrderId != null) data['work_order_id'] = workOrderId;
    if (model != null) data['model'] = model;
    if (quantity != null) data['quantity'] = quantity;
    if (note != null) data['note'] = note;
    if (createdAt != null) data['created_at'] = createdAt;
    if (createdBy != null) data['created_by'] = createdBy;
    if (updatedAt != null) data['updated_at'] = updatedAt;
    if (updatedBy != null) data['updated_by'] = updatedBy;
    if (isActive != null) data['is_active'] = isActive;
    if (status != null) data['status'] = status;

    if (oqcResults != null) {
      data['oqcResults'] =
          oqcResults!.map((oqcResult) => oqcResult.toJson()).toList();
    }

    return data;
  }
}
