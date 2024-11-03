class PQCFirstResult {
  String? id;
  String? pqcFirstInfoId;
  String? stageName;
  String? content;
  String? standard;
  String? method;
  String? conclusion;
  String? isActive;

  PQCFirstResult(
      {this.id,
      this.pqcFirstInfoId,
      this.stageName,
      this.content,
      this.standard,
      this.method,
      this.conclusion,
      this.isActive});

  PQCFirstResult.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pqcFirstInfoId = json['pqc_first_info_id'];
    stageName = json['stage_name'];
    content = json['content'];
    standard = json['standard'];
    method = json['method'];
    conclusion = json['conclusion'];
    isActive = json['is_active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['pqc_first_info_id'] = pqcFirstInfoId;
    data['stage_name'] = stageName;
    data['content'] = content;
    data['standard'] = standard;
    data['method'] = method;
    data['conclusion'] = conclusion;
    data['is_active'] = isActive;
    return data;
  }
}
