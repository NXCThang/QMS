class PQCFirstInfoModel {
  int? id;
  int? workOrderId;
  String? model;
  String? note;
  int? conclusion;
  String? createdAt;
  String? createdBy;
  String? updatedAt;
  String? updatedBy;
  int? isActive;
  String? qcLeaderName;
  String? pqcName;
  int? quantity;
  String? type;

  PQCFirstInfoModel(
      {this.id,
      this.workOrderId,
      this.model,
      this.note,
      this.conclusion,
      this.createdAt,
      this.createdBy,
      this.updatedAt,
      this.updatedBy,
      this.isActive,
      this.qcLeaderName,
      this.pqcName,
      this.quantity,
      this.type});

  PQCFirstInfoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    workOrderId = json['work_order_id'];
    model = json['model'];
    note = json['note'];
    conclusion = json['conclusion'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    updatedAt = json['updated_at'];
    updatedBy = json['updated_by'];
    isActive = json['is_active'];
    qcLeaderName = json['qc_leader_name'];
    pqcName = json['pqc_name'];
    quantity = json['quantity'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (id != null) data['id'] = id;
    if (workOrderId != null) data['work_order_id'] = workOrderId;
    if (model != null) data['model'] = model;
    if (note != null) data['note'] = note;
    if (conclusion != null) data['conclusion'] = conclusion;
    if (createdAt != null) data['created_at'] = createdAt;
    if (createdBy != null) data['created_by'] = createdBy;
    if (updatedAt != null) data['updated_at'] = updatedAt;
    if (updatedBy != null) data['updated_by'] = updatedBy;
    if (isActive != null) data['is_active'] = isActive;
    if (qcLeaderName != null) data['qc_leader_name'] = qcLeaderName;
    if (pqcName != null) data['pqc_name'] = pqcName;
    if (quantity != null) data['quantity'] = quantity;
    if (type != null) data['type'] = type;
    return data;
  }
}
