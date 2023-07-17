import 'package:get/get.dart';
import 'package:trainee/configs/routes/main_route.dart';
import 'package:trainee/modules/global_controllers/global_controller.dart';
import 'package:trainee/utils/services/local_storage_service.dart';

class SplashController extends GetxController {
  @override
  void onReady() async {
    super.onReady();

    GlobalController.to.checkConnection();

    bool? isLoginStatus = await LocalStorageService.isLogIn();

    Future.delayed(const Duration(seconds: 1), () {
      if (isLoginStatus == true) {
        Get.offAllNamed(MainRoute.initLocation);
      } else {
        Get.offAllNamed(MainRoute.signIn);
      }
    });
  }
}
