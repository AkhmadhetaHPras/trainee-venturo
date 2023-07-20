import 'package:get/get.dart';
import 'package:trainee/modules/features/promo/controllers/detail_promo_controller.dart';

class PromoBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DetailPromoController());
  }
}
