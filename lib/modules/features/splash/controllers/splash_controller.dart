import 'package:get/get.dart';
import 'package:trainee/configs/routes/main_route.dart';

class SplashController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    Future.delayed(const Duration(seconds: 1), () {
      Get.offAllNamed(MainRoute.initial);
    });
  }
}
