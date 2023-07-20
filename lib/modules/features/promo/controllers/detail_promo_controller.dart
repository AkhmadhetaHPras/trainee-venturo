import 'package:get/get.dart';
import 'package:trainee/modules/features/list/models/promo_response.dart';

class DetailPromoController extends GetxController {
  static DetailPromoController get to => Get.find();
  final Rx<PromoData> promo = PromoData().obs;

  @override
  void onInit() {
    promo.value = Get.arguments as PromoData;
    super.onInit();
  }
}
