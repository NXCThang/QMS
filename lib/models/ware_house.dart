class WareHouseModel {
  num? id;
  String? warehouseName;
  String? warehouseType;

  WareHouseModel({this.id, this.warehouseName, this.warehouseType});

  WareHouseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    warehouseName = json['warehouse_name'];
    warehouseType = json['warehouse_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['warehouse_name'] = warehouseName;
    data['warehouse_type'] = warehouseType;
    return data;
  }
}
