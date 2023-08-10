import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:trainee/utils/services/local_storage_service.dart';

import '../../../../configs/routes/main_route.dart';
import '../../../global_controllers/global_controller.dart';
import '../reposiotries/counter_repository.dart';

class ConterController extends GetxController {
  static ConterController get to => Get.find();

  final CounterRepository _counterRepository = CounterRepository();

  @override
  void onInit() async {
    super.onInit();

    await GlobalController.to.checkConnection();
  }

  var count = 0.obs;
  increment() async {
    try {
      count++;
      // throw Exception('Error occurred');
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
    }
  }

  void logout(context) async {
    EasyLoading.show(
      status: 'Loading...'.tr,
      maskType: EasyLoadingMaskType.black,
      dismissOnTap: false,
    );

    GlobalController.to.checkConnection();

    if (GlobalController.to.isConnect.isTrue) {
      await _counterRepository.logOut();
      bool? isLoginStatus = await LocalStorageService.isLogIn();

      if (isLoginStatus == false) {
        EasyLoading.dismiss();
        Get.offAllNamed(MainRoute.signIn);
      } else {
        EasyLoading.dismiss();
        PanaraInfoDialog.show(
          context,
          title: "Error",
          message: "Gagal Logout",
          buttonText: "Coba lagi",
          onTapDismiss: () {
            Get.back();
          },
          panaraDialogType: PanaraDialogType.error,
          barrierDismissible: false,
        );
      }
    } else {
      Get.toNamed(MainRoute.noConnection);
    }
  }
}
