import 'package:get/get.dart';
import 'package:trainee/modules/features/cart/controllers/edit_menu_cart_controller.dart';

class EditCartBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(EditMenuCartController());
  }
}
