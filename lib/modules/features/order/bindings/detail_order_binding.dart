import 'package:get/get.dart';

import '../controllers/order_detail_controller.dart';

class DetailOrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DetailOrderController());
  }
}
