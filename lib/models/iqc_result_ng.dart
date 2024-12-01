class IQCResultNgModel {
  int? id;
  String? iqcReportId;
  String? iqcErrGroup;
  String? iqcErrName;
  int? quantity;
  String? ratio;

  IQCResultNgModel(
      {this.id,
      this.iqcReportId,
      this.iqcErrGroup,
      this.iqcErrName,
      this.quantity,
      this.ratio});

  IQCResultNgModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    iqcReportId = json['iqc_report_id'];
    iqcErrGroup = json['iqc_err_group'];
    iqcErrName = json['iqc_err_name'];
    quantity = json['quantity'];
    ratio = json['ratio'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['iqc_report_id'] = iqcReportId;
    data['iqc_err_group'] = iqcErrGroup;
    data['iqc_err_name'] = iqcErrName;
    data['quantity'] = quantity;
    data['ratio'] = ratio;
    return data;
  }
}
