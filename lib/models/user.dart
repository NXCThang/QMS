class UserModel {
  int? id;
  String? password;
  String? username;
  String? name;

  UserModel({this.id, this.password, this.username, this.name});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    password = json['password'];
    username = json['username'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['password'] = this.password;
    data['username'] = this.username;
    data['name'] = this.name;
    return data;
  }
}
