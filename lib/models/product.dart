class ProductModel {
  int? id;
  String? productName;
  int? soId;
  int? isActive;

  ProductModel({this.id, this.productName, this.soId, this.isActive});

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productName = json['product_name'];
    soId = json['so_id'];
    isActive = json['is_active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['product_name'] = productName;
    data['so_id'] = soId;
    data['is_active'] = isActive;
    return data;
  }
}
