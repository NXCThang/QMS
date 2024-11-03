class OQCResultModel {
  String? id;
  String? oqcInfoId;
  String? inputDate;
  String? isActive;
  String? status;
  String? result;
  String? createdAt;
  String? updatedAt;
  String? updatedBy;
  String? createdBy;

  OQCResultModel(
      {this.id,
      this.oqcInfoId,
      this.inputDate,
      this.isActive,
      this.status,
      this.result,
      this.createdAt,
      this.updatedAt,
      this.updatedBy,
      this.createdBy});

  OQCResultModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    oqcInfoId = json['oqc_info_id'];
    inputDate = json['input_date'];
    isActive = json['is_active'];
    status = json['status'];
    result = json['result'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    updatedBy = json['updated_by'];
    createdBy = json['created_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['oqc_info_id'] = oqcInfoId;
    data['input_date'] = inputDate;
    data['is_active'] = isActive;
    data['status'] = status;
    data['result'] = result;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['updated_by'] = updatedBy;
    data['created_by'] = createdBy;
    return data;
  }
}
