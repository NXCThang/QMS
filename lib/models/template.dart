class TemplateModel {
  num? id;
  String? templateCode;
  String? templateName;
  String? createdAt;
  num? isActive;
  String? templateType;

  TemplateModel(
      {this.id,
      this.templateCode,
      this.templateName,
      this.createdAt,
      this.isActive,
      this.templateType});

  TemplateModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    templateCode = json['template_code'];
    templateName = json['template_name'];
    createdAt = json['created_at'];
    isActive = json['is_active'];
    templateType = json['template_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['template_code'] = templateCode;
    data['template_name'] = templateName;
    data['created_at'] = createdAt;
    data['is_active'] = isActive;
    data['template_type'] = templateType;
    return data;
  }
}
