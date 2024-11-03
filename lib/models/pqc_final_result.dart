class PQCFinalResultModel {
  String? pqcFinalInfo;
  String? workOrderId;
  String? customerName;
  String? totalQuantity;
  String? note;
  String? requestStage;
  String? finalResult;
  String? approvalPerson;
  String? featureResult;
  String? externalResult;
  String? isActive;
  String? createdAt;
  String? createdBy;
  String? updatedAt;
  String? updatedBy;

  PQCFinalResultModel(
      {this.pqcFinalInfo,
      this.workOrderId,
      this.customerName,
      this.totalQuantity,
      this.note,
      this.requestStage,
      this.finalResult,
      this.approvalPerson,
      this.featureResult,
      this.externalResult,
      this.isActive,
      this.createdAt,
      this.createdBy,
      this.updatedAt,
      this.updatedBy});

  PQCFinalResultModel.fromJson(Map<String, dynamic> json) {
    pqcFinalInfo = json['pqc_final_info'];
    workOrderId = json['work_order_id'];
    customerName = json['customer_name'];
    totalQuantity = json['total_quantity'];
    note = json['note'];
    requestStage = json['request_stage'];
    finalResult = json['final_result'];
    approvalPerson = json['approval_person'];
    featureResult = json['feature_result'];
    externalResult = json['external_result'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    updatedAt = json['updated_at'];
    updatedBy = json['updated_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pqc_final_info'] = pqcFinalInfo;
    data['work_order_id'] = workOrderId;
    data['customer_name'] = customerName;
    data['total_quantity'] = totalQuantity;
    data['note'] = note;
    data['request_stage'] = requestStage;
    data['final_result'] = finalResult;
    data['approval_person'] = approvalPerson;
    data['feature_result'] = featureResult;
    data['external_result'] = externalResult;
    data['is_active'] = isActive;
    data['created_at'] = createdAt;
    data['created_by'] = createdBy;
    data['updated_at'] = updatedAt;
    data['updated_by'] = updatedBy;
    return data;
  }
}
