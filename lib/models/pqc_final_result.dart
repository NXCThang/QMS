class PQCFinalResultModel {
  int? id;
  int? workOrderId;
  String? customerName;
  int? totalQuantity;
  String? note;
  String? requestStage;
  int? finalResult;
  String? approvalPerson;
  int? featureResult;
  int? externalResult;
  int? isActive;
  String? createdAt;
  String? createdBy;
  String? updatedAt;
  String? updatedBy;
  int? testQuantity;

  PQCFinalResultModel(
      {this.id,
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
      this.updatedBy,
      this.testQuantity});

  PQCFinalResultModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
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
    testQuantity = json['test_quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['work_order_id'] = this.workOrderId;
    data['customer_name'] = this.customerName;
    data['total_quantity'] = this.totalQuantity;
    data['note'] = this.note;
    data['request_stage'] = this.requestStage;
    data['final_result'] = this.finalResult;
    data['approval_person'] = this.approvalPerson;
    data['feature_result'] = this.featureResult;
    data['external_result'] = this.externalResult;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['updated_at'] = this.updatedAt;
    data['updated_by'] = this.updatedBy;
    data['test_quantity'] = this.testQuantity;
    return data;
  }
}
