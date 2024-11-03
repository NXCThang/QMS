class PQCFirstProblemModel {
  String? id;
  String? checkDate;
  String? problem;
  String? solution;
  String? pqcFirstInfoId;

  PQCFirstProblemModel(
      {this.id,
      this.checkDate,
      this.problem,
      this.solution,
      this.pqcFirstInfoId});

  PQCFirstProblemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    checkDate = json['check_date'];
    problem = json['problem'];
    solution = json['solution'];
    pqcFirstInfoId = json['pqc_first_info_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['check_date'] = checkDate;
    data['problem'] = problem;
    data['solution'] = solution;
    data['pqc_first_info_id'] = pqcFirstInfoId;
    return data;
  }
}
