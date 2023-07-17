import 'package:sentry_flutter/sentry_flutter.dart';

import '../../../../utils/services/http_service.dart';
import '../../../../utils/services/local_storage_service.dart';

class CounterRepository {
  Future<void> logOut() async {
    try {
      var dio =
          HttpService.dioCall(token: await LocalStorageService.getToken());

      final response = await dio.get(
        '/auth/logout',
      );

      if (response.statusCode == 200) {
        final responseData = response.data;

        if (responseData["status_code"] == 200) {
          await LocalStorageService.deleteAuth();
        }
      } else {
        print('Gagal logout. Status code: ${response.statusCode}');
      }
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
    }
  }
}
