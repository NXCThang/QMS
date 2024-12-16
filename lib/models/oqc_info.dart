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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['work_order_id'] = this.workOrderId;
    data['model'] = this.model;
    data['quantity'] = this.quantity;
    data['note'] = this.note;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['updated_at'] = this.updatedAt;
    data['updated_by'] = this.updatedBy;
    data['is_active'] = this.isActive;
    data['status'] = this.status;
    data['oqcResults'] =
        oqcResults?.map((oqcResult) => oqcResult.toJson()).toList();
    return data;
  }
}
