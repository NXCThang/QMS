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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['work_order_id'] = this.workOrderId;
    data['model'] = this.model;
    data['note'] = this.note;
    data['conclusion'] = this.conclusion;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['updated_at'] = this.updatedAt;
    data['updated_by'] = this.updatedBy;
    data['is_active'] = this.isActive;
    data['qc_leader_name'] = this.qcLeaderName;
    data['pqc_name'] = this.pqcName;
    data['quantity'] = this.quantity;
    data['type'] = this.type;
    return data;
  }
}
