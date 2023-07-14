import 'package:get/get.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../../global_controllers/global_controller.dart';

class ConterController extends GetxController {
  static ConterController get to => Get.find();

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
}
