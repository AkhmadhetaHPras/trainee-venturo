import 'package:get/get.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:trainee/modules/global_models/diskon.dart';
import 'package:trainee/modules/global_models/voucher.dart';
import 'package:trainee/utils/services/local_storage_service.dart';

import '../../../../utils/services/http_service.dart';

class CartRepository {
  static RxList<DiskonData> discounts = <DiskonData>[].obs;

  Future<Voucher> getListVoucher() async {
    try {
      var dio =
          HttpService.dioCall(token: await LocalStorageService.getToken());

      var id = await LocalStorageService.box.get('id');
      final response = await dio.get(
        'voucher/user/$id',
      );

      if (response.statusCode == 200) {
        final responseData = response.data;
        return Voucher.fromJson(responseData);
      } else {
        throw Exception('API Error');
      }
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      return Voucher(statusCode: 500, errors: ["API Error"]);
    }
  }

  Future<int> getDiscount() async {
    try {
      var dio =
          HttpService.dioCall(token: await LocalStorageService.getToken());

      var id = await LocalStorageService.box.get('id');
      final response = await dio.get(
        'diskon/user/$id',
      );

      if (response.statusCode == 200) {
        final responseData = response.data;
        final diskonData = Diskon.fromJson(responseData);
        int totalDiskon = 0;
        if (diskonData.data != null) {
          discounts.clear();
          discounts.addAll(diskonData.data!);
          for (DiskonData diskonData in diskonData.data!) {
            totalDiskon += diskonData.diskon ?? 0;
          }
        }
        return totalDiskon;
      } else {
        throw Exception('API Error');
      }
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      return 0;
    }
  }
}
