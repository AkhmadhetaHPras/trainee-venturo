import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:trainee/modules/features/menu/models/menu_response.dart';
import 'package:trainee/utils/services/local_storage_service.dart';

import '../../../../utils/services/http_service.dart';

class MenuRepository {
  Future<DetailMenuResponse> getDetailMenu(int id) async {
    try {
      var dio =
          HttpService.dioCall(token: await LocalStorageService.getToken());

      final response = await dio.get(
        'menu/detail/$id',
      );

      if (response.statusCode == 200) {
        final responseData = response.data;
        return DetailMenuResponse.fromJson(responseData);
      } else {
        throw Exception('API Error');
      }
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      return DetailMenuResponse(statusCode: 500, errors: ["API Error"]);
    }
  }
}
