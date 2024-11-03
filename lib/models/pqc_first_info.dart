class PQCFirstInfoModel {
  String? id;
  String? workOrderId;
  String? model;
  String? note;
  String? conclusion;
  String? createdAt;
  String? createdBy;
  String? updatedAt;
  String? updatedBy;
  String? isActive;
  String? qcLeaderName;
  String? pqcName;

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
      this.pqcName});

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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['work_order_id'] = workOrderId;
    data['model'] = model;
    data['note'] = note;
    data['conclusion'] = conclusion;
    data['created_at'] = createdAt;
    data['created_by'] = createdBy;
    data['updated_at'] = updatedAt;
    data['updated_by'] = updatedBy;
    data['is_active'] = isActive;
    data['qc_leader_name'] = qcLeaderName;
    data['pqc_name'] = pqcName;
    return data;
  }
}
