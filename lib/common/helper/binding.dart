import 'package:get/get.dart';
import 'package:qms_app/common/sidebar/controller/sidebar_c.dart';

class Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => SideBarController(),
    );
  }
}
