import 'package:get/get.dart';
import 'package:trainee/modules/features/menu/controllers/detail_menu_controller.dart';

class MenuBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DetailMenuController());
  }
}
