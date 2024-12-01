import 'package:get/get.dart';
import 'package:qms_app/common/components/paginated_c.dart';
import 'package:qms_app/models/aql.dart';
import 'package:qms_app/services/firebase_service.dart';

class AQLController extends GetxController {
  final RxList<AQLModel> aqlList = <AQLModel>[].obs;
  final RxBool isLoading = false.obs;
  final PaginatedController<AQLModel> paginatedController =
      PaginatedController<AQLModel>();

  @override
  void onInit() {
    super.onInit();
    getAQLList();
  }

  Future<void> getAQLList() async {
    isLoading.value = true;
    try {
      aqlList.value = await FirebaseService().getList(
        table: 'aql',
        fromJson: (data) => AQLModel.fromJson(data),
      );
      aqlList.sort((a, b) => (a.id ?? 0).compareTo(b.id ?? 0));
      paginatedController.setList(aqlList);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addAql(AQLModel result) async {
    await FirebaseService().addItem(
        table: 'aql',
        documentId: (aqlList.length + 1).toString(),
        data: result.toJson());
    getAQLList();
  }

  Future<void> deleteAql(String id) async {
    await FirebaseService()
        .deleteItem(table: 'aql', field: 'id', documentId: id);
    getAQLList();
  }

  Future<void> updateAql(AQLModel result) async {
    await FirebaseService().updateItem(
        table: 'aql',
        field: 'id',
        documentId: result.id.toString(),
        data: result.toJson());
    getAQLList();
  }
}
