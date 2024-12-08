import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qms_app/data/local/login_session.dart';
import 'package:qms_app/models/user.dart';
import 'package:qms_app/presentation/category_manage/pages/template.dart';

class AuthenticationController extends GetxController {
  Future<bool> login(String username, String password) async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    try {
      final querySnapshot = await _firestore
          .collection('qms')
          .doc('user')
          .collection('items')
          .get();

      if (querySnapshot.docs.isEmpty) {
        Get.snackbar('Đăng nhập thất bại', 'Không có user nào',
            maxWidth: 300, backgroundColor: Colors.red);
        return false;
      } else {
        for (final user in querySnapshot.docs) {
          if (user['username'] == username) {
            if (user['password'] == password) {
              final userModel = UserModel.fromJson(user.data());
              LoginSession().saveUser(userModel);
              Get.snackbar(
                'Đăng nhập thành công',
                'Chào mừng ${user['name']}',
                maxWidth: 300,
                backgroundColor: Colors.green,
              );
              Future.delayed(const Duration(milliseconds: 300), () {
                Get.off(MinutesPage());
              });
              return true;
            } else {
              Get.snackbar('Đăng nhập thất bại', 'Mật khẩu không đúng',
                  maxWidth: 300, backgroundColor: Colors.red);
              return false;
            }
          }
        }
        Get.snackbar('Đăng nhập thất bại', 'Không tìm thấy người dùng',
            maxWidth: 300, backgroundColor: Colors.red);
        return false;
      }
    } catch (e) {
      Get.snackbar(
        'Đăng nhập thất bại',
        '$e',
        backgroundColor: Colors.red,
        maxWidth: 300,
      );
      return false;
    }
  }
}
