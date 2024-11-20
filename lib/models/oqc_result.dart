class OQCResultModel {
  int? id;
  int? oqcInfoId;
  String? inputDate;
  int? isActive;
  int? result;
  String? createdAt;
  String? updatedAt;
  String? updatedBy;
  String? createdBy;
  int? totalQuantity;
  int? testQuantity;
  num? nGQuantity;
  int? externalQuantity;
  int? featureQuantity;

  OQCResultModel(
      {this.id,
      this.oqcInfoId,
      this.inputDate,
      this.isActive,
      this.result,
      this.createdAt,
      this.updatedAt,
      this.updatedBy,
      this.createdBy,
      this.totalQuantity,
      this.testQuantity,
      this.nGQuantity,
      this.externalQuantity,
      this.featureQuantity});

  OQCResultModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    oqcInfoId = json['oqc_info_id'];
    inputDate = json['input_date'];
    isActive = json['is_active'];
    result = json['result'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    updatedBy = json['updated_by'];
    createdBy = json['created_by'];
    totalQuantity = json['total_quantity'];
    testQuantity = json['test_quantity'];
    nGQuantity = json['NG_quantity'];
    externalQuantity = json['external_quantity'];
    featureQuantity = json['feature_quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['oqc_info_id'] = oqcInfoId;
    data['input_date'] = inputDate;
    data['is_active'] = isActive;
    data['result'] = result;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['updated_by'] = updatedBy;
    data['created_by'] = createdBy;
    data['total_quantity'] = totalQuantity;
    data['test_quantity'] = testQuantity;
    data['NG_quantity'] = nGQuantity;
    data['external_quantity'] = externalQuantity;
    data['feature_quantity'] = featureQuantity;
    return data;
  }
}
