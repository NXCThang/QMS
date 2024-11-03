class IQCResultModel {
  String? id;
  String? criteriaName;
  String? max;
  String? min;
  String? unit;
  String? note;
  String? otherRequirement;
  String? quantity;
  String? testResult;
  String? conclusion;
  String? iqcReportId;

  IQCResultModel(
      {this.id,
      this.criteriaName,
      this.max,
      this.min,
      this.unit,
      this.note,
      this.otherRequirement,
      this.quantity,
      this.testResult,
      this.conclusion,
      this.iqcReportId});

  IQCResultModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    criteriaName = json['criteria_name'];
    max = json['max'];
    min = json['min'];
    unit = json['unit'];
    note = json['note'];
    otherRequirement = json['other_requirement'];
    quantity = json['quantity'];
    testResult = json['test_result'];
    conclusion = json['conclusion'];
    iqcReportId = json['iqc_report_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['criteria_name'] = criteriaName;
    data['max'] = max;
    data['min'] = min;
    data['unit'] = unit;
    data['note'] = note;
    data['other_requirement'] = otherRequirement;
    data['quantity'] = quantity;
    data['test_result'] = testResult;
    data['conclusion'] = conclusion;
    data['iqc_report_id'] = iqcReportId;
    return data;
  }
}
