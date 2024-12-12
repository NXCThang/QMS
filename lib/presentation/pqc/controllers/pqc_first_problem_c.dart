import 'package:get/get.dart';
import 'package:qms_app/common/components/paginated_c.dart';
import 'package:qms_app/models/pqc_first_problem.dart';
import 'package:qms_app/services/firebase_service.dart';

class PqcFirstProblemController extends GetxController {
  final RxList<PQCFirstProblemModel> pqcFirstProblemList =
      <PQCFirstProblemModel>[].obs;
  final RxBool isLoading = true.obs;
  final RxList<PQCFirstProblemModel> temporaryList =
      <PQCFirstProblemModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getpqcFirstProblemList();
  }

  Future<void> getpqcFirstProblemList() async {
    try {
      isLoading.value = true;
      pqcFirstProblemList.value = await FirebaseService().getList(
        table: 'pqc_first_problem',
        fromJson: (data) => PQCFirstProblemModel.fromJson(data),
      );
      pqcFirstProblemList.sort((a, b) => (a.id ?? 0).compareTo(b.id ?? 0));
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addPQCFirstProblem(PQCFirstProblemModel problem) async {
    try {
      isLoading.value = true;
      await FirebaseService().addItem(
          table: 'pqc_first_problem',
          documentId: (pqcFirstProblemList.length + 1).toString(),
          data: problem.toJson());
      await getpqcFirstProblemList();
    } finally {
      isLoading.value = false;
    }
  }
}
