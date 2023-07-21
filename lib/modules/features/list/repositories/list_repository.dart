import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:trainee/modules/features/list/models/promo_response.dart';

import '../../../../utils/services/http_service.dart';
import '../../../../utils/services/local_storage_service.dart';
import '../models/menu_response.dart';

class ListRepository {
  // Dummy list of data
  final List<MenuData> data = [];

  // Get list of data
  Future<Map<String, dynamic>> getListOfData({int offset = 0}) async {
    int limit = 5 + offset;

    final menuResponse = await fetchMenuData();
    updateData(menuResponse);
    if (limit > data.length) limit = data.length;
    return {
      'data': data.getRange(offset, limit).toList(),
      'next': limit < data.length ? true : null,
      'previous': offset > 0 ? true : null,
    };
  }

  void updateData(MenuResponse response) {
    data.clear();
    if (response.data != null) {
      data.addAll(response.data!);
    }
  }

  Future<MenuResponse> fetchMenuData() async {
    try {
      var dio =
          HttpService.dioCall(token: await LocalStorageService.getToken());

      final response = await dio.get(
        '/menu/all',
      );

      if (response.statusCode == 200) {
        final data = MenuResponse.fromJson(response.data);
        return data;
      } else {
        throw Exception('API Error');
      }
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      return MenuResponse(
        statusCode: null,
        data: null,
        errors: ['An error occurred while fetching menu data.'],
      );
    }
  }

  Future<PromoResponse?> getPromos() async {
    try {
      var dio =
          HttpService.dioCall(token: await LocalStorageService.getToken());

      final response = await dio.get(
        '/promo/all',
      );

      if (response.statusCode == 200) {
        final data = PromoResponse.fromJson(response.data);
        return data;
      } else {
        throw Exception('API Error');
      }
    } catch (exception, stacktrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stacktrace,
      );
      return null;
    }
  }
}
