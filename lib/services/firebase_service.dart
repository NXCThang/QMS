import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qms_app/models/iqc_report.dart';

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
    required Map<String, dynamic> data,
  }) async {
    try {
      await _firestore
          .collection('qms')
          .doc(table)
          .collection('items')
          .add(data);
      print("Item added successfully.");
    } catch (e) {
      print("Error adding item: $e");
    }
  }

  Future<void> deleteItem({
    required String table,
    required String documentId,
  }) async {
    try {
      await _firestore
          .collection('qms')
          .doc(table)
          .collection('items')
          .doc(documentId)
          .delete();
      print("Item deleted successfully.");
    } catch (e) {
      print("Error deleting item: $e");
    }
  }

  Future<void> updateItem({
    required String table,
    required String documentId,
    required Map<String, dynamic> data,
  }) async {
    try {
      await _firestore
          .collection('qms')
          .doc(table)
          .collection('items')
          .doc(documentId)
          .update(data);
      print("Item updated successfully.");
    } catch (e) {
      print("Error updating item: $e");
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
}
