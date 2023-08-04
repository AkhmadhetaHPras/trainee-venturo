import 'package:get/get.dart';

class BottomNavigationController extends GetxController {
  static BottomNavigationController get to => Get.find();

  // Active menu item index
  final RxInt activeIndex = 0.obs;

  // Function to update the active menu item index
  void setActiveIndex(int index) {
    activeIndex.value = index;
  }
}
