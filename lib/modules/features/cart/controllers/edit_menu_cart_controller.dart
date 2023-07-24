import 'package:get/get.dart';

class EditMenuCartController extends GetxController {
  static EditMenuCartController get to => Get.find();
  final RxInt index = 0.obs;

  @override
  void onInit() {
    index.value = Get.arguments as int;
    super.onInit();
  }
}
