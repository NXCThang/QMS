import 'package:hive/hive.dart';
import 'package:qms_app/models/user.dart';

class LoginSession {
  final Box _userBox = Hive.box('userBox');

  void saveUser(UserModel user) {
    _userBox.put('user', user.toJson());
  }

  UserModel? getUser() {
    final userMap = _userBox.get('user');
    if (userMap != null) {
      return UserModel.fromJson(Map<String, dynamic>.from(userMap));
    }
    return null;
  }

  void deleteUser() {
    _userBox.delete('user');
  }
}
