import 'package:get/get.dart';
import 'package:qms_app/models/product.dart';
import 'package:qms_app/services/firebase_service.dart';

class ProductController extends GetxController {
  final RxList<ProductModel> productList = <ProductModel>[].obs;
  final RxList<ProductModel> searchList = <ProductModel>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getProductList();
  }

  Future<void> getProductList() async {
    productList.value = await FirebaseService().getList(
      table: 'product',
      fromJson: (data) => ProductModel.fromJson(data),
    );
  }

  Future<void> searchProduct(String keyword) async {
    isLoading.value = true;
    try {
      final results = await FirebaseService().searchProduct(
        table: 'product',
        field: 'id',
        keyword: keyword,
        fromJson: (data) => ProductModel.fromJson(data),
      );
      searchList.value = results;
      print(searchList.length);
    } finally {
      isLoading.value = false;
    }
  }
}
