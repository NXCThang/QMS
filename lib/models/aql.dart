class AQLModel {
  num? id;
  num? checkLimit;
  num? acceptanceLimit;
  num? ngLimit;
  String? note;

  AQLModel(
      {this.id,
      this.checkLimit,
      this.acceptanceLimit,
      this.ngLimit,
      this.note});

  AQLModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    checkLimit = json['check_limit'];
    acceptanceLimit = json['acceptance_limit'];
    ngLimit = json['ng_limit'];
    note = json['note'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['check_limit'] = checkLimit;
    data['acceptance_limit'] = acceptanceLimit;
    data['ng_limit'] = ngLimit;
    data['note'] = note;
    return data;
  }
}
