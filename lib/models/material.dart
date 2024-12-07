class MaterialModel {
  int? id;
  String? materialName;
  String? materialCode;
  String? partNumber;
  int? quantity;
  String? provider;
  int? productId;
  int? warehouseId;

  MaterialModel(
      {this.id,
      this.materialName,
      this.materialCode,
      this.partNumber,
      this.quantity,
      this.provider,
      this.productId,
      this.warehouseId});

  MaterialModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    materialName = json['material_name'];
    materialCode = json['material_code'];
    partNumber = json['part_number'];
    quantity = json['quantity'];
    provider = json['provider'];
    productId = json['product_id'];
    warehouseId = json['warehouse_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['material_name'] = materialName;
    data['material_code'] = materialCode;
    data['part_number'] = partNumber;
    data['quantity'] = quantity;
    data['provider'] = provider;
    data['product_id'] = productId;
    data['warehouse_id'] = warehouseId;
    return data;
  }
}
