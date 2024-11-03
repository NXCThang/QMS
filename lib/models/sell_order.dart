class SellOrder {
  String? id;
  String? soCode;
  String? soName;
  String? customerName;
  String? isActive;
  String? quantity;

  SellOrder(
      {this.id,
      this.soCode,
      this.soName,
      this.customerName,
      this.isActive,
      this.quantity});

  SellOrder.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    soCode = json['so_code'];
    soName = json['so_name'];
    customerName = json['customer_name'];
    isActive = json['is_active'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['so_code'] = soCode;
    data['so_name'] = soName;
    data['customer_name'] = customerName;
    data['is_active'] = isActive;
    data['quantity'] = quantity;
    return data;
  }
}
