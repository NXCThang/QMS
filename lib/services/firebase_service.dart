import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<T>> getList<T>({
    required String table,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    try {
      final querySnapshot = await _firestore
          .collection('qms')
          .doc(table)
          .collection('items')
          .get();

      List<T> list = querySnapshot.docs.map((e) => fromJson(e.data())).toList();
      print(list.length);
      return list;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<void> addItem({
    required String table,
    required String documentId,
    required Map<String, dynamic> data,
  }) async {
    try {
      await _firestore
          .collection('qms')
          .doc(table)
          .collection('items')
          .doc(documentId) // Sử dụng documentId để chỉ định ID tài liệu
          .set(data); // Sử dụng set() để thêm dữ liệu
      Get.back();
      Future.microtask(() {
        Get.snackbar('Thông báo', 'Thêm thành công',
            backgroundColor: Colors.green);
      });
      print("Item added successfully with ID: $documentId");
    } catch (e) {
      Get.back();
      Future.microtask(() {
        Get.snackbar('Thông báo', 'Thêm thất bại', backgroundColor: Colors.red);
      });
      print("Error adding item: $e");
    }
  }

  Future<void> deleteItem({
    required String table,
    required String field,
    required String documentId,
  }) async {
    try {
      final querySnapshot = await _firestore
          .collection('qms')
          .doc(table)
          .collection('items')
          .get();
      for (var doc in querySnapshot.docs) {
        if (doc.data()[field].toString() == documentId) {
          await _firestore
              .collection('qms')
              .doc(table)
              .collection('items')
              .doc(doc.id)
              .delete();
          Get.back();
          Future.microtask(() {
            Get.snackbar('Thông báo', 'Xóa thành công',
                backgroundColor: Colors.green);
          });
        }
      }
      print("Item(s) deleted successfully.");
    } catch (e) {
      print("Error deleting item(s): $e");
      Get.back();
      Future.microtask(() {
        Get.snackbar('Thông báo', 'Xóa thất bại', backgroundColor: Colors.red);
      });
    }
  }

  Future<void> updateItem({
    required String table,
    required String field, // Trường cần so sánh
    required String documentId, // Giá trị để so sánh
    required Map<String, dynamic> data, // Dữ liệu để cập nhật
  }) async {
    try {
      print(data);
      final querySnapshot = await _firestore
          .collection('qms')
          .doc(table)
          .collection('items')
          .get();

      for (var doc in querySnapshot.docs) {
        if (doc.id == documentId) {
          await _firestore
              .collection('qms')
              .doc(table)
              .collection('items')
              .doc(documentId)
              .update(data);
          Get.back();
          Future.microtask(() {
            Get.snackbar('Thông báo', 'Cập nhật thành công',
                backgroundColor: Colors.green);
          });
        }
      }

      print("Item(s) updated successfully.");
    } catch (e) {
      Get.back();
      Future.microtask(() {
        Get.snackbar('Thông báo', 'Cập nhật thất bại',
            backgroundColor: Colors.red);
      });
      print("Error updating item(s): $e");
    }
  }

  Future<List<T>> searchProduct<T>({
    required String table,
    required String field,
    required String keyword,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    try {
      final querySnapshot = await _firestore
          .collection('qms')
          .doc(table)
          .collection('items')
          .where(field, isGreaterThanOrEqualTo: keyword)
          .where(field, isLessThanOrEqualTo: keyword + '\uf8ff')
          .get();

      return querySnapshot.docs.map((e) => fromJson(e.data())).toList();
    } catch (e) {
      print("Error searching product: $e");
      return [];
    }
  }

  /// Tìm kiếm và trả về danh sách kết quả
  Future<List<T>> searchList<T>({
    required String table,
    required String field,
    required dynamic value,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    try {
      final querySnapshot = await _firestore
          .collection('qms')
          .doc(table)
          .collection('items')
          .where(field, isEqualTo: value)
          .get();

      return querySnapshot.docs.map((e) => fromJson(e.data())).toList();
    } catch (e) {
      print("Error searching list in $table: $e");
      return [];
    }
  }

  /// Tìm kiếm và trả về một đối tượng duy nhất
  Future<T?> searchOne<T>({
    required String table,
    required String field,
    required dynamic value,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    try {
      final querySnapshot = await _firestore
          .collection('qms')
          .doc(table)
          .collection('items')
          .where(field, isEqualTo: value)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        return fromJson(querySnapshot.docs.first.data());
      }
      return null;
    } catch (e) {
      print("Error searching one in $table: $e");
      return null;
    }
  }
}
