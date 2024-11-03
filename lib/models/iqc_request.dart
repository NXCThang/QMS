class IQCRequestModel {
  String? id;
  String? poCode;
  String? dueDate;
  String? createdAt;
  String? updatedAt;

  IQCRequestModel(
      {this.id, this.poCode, this.dueDate, this.createdAt, this.updatedAt});

  IQCRequestModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    poCode = json['po_code'];
    dueDate = json['due_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['po_code'] = poCode;
    data['due_date'] = dueDate;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
