import 'package:get/get.dart';

class PaginatedController<T> {
  var currentPage = 0.obs;
  final int itemsPerPage = 10;
  var itemList = <T>[].obs;

  List<T> get paginatedItems {
    final startIndex = currentPage.value * itemsPerPage;
    final endIndex = startIndex + itemsPerPage;
    return itemList.sublist(
        startIndex, endIndex > itemList.length ? itemList.length : endIndex);
  }

  int get totalPages {
    return (itemList.length / itemsPerPage).ceil();
  }

  void nextPage() {
    if ((currentPage.value + 1) * itemsPerPage < itemList.length) {
      currentPage.value++;
    }
  }

  void previousPage() {
    if (currentPage.value > 0) {
      currentPage.value--;
    }
  }

  void setList(List<T> newList) {
    itemList.assignAll(newList);
    currentPage.value = 0;
  }
}
