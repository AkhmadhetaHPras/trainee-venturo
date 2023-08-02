import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:trainee/modules/features/order/models/order_detail.dart';

import '../../../../utils/services/http_service.dart';
import '../../../../utils/services/local_storage_service.dart';
import '../models/order.dart';

class OrderRepository {
  List<Order> ongoingOrder = [];

  Future<Map<String, dynamic>> getListOfDataOnGoing({int offset = 0}) async {
    int limit = 5 + offset;

    await fetchOrderData();
    if (limit > getOngoingOrder().length) limit = getOngoingOrder().length;
    return {
      'data': getOngoingOrder().getRange(offset, limit).toList(),
      'next': limit < getOngoingOrder().length ? true : null,
      'previous': offset > 0 ? true : null,
    };
  }

  Future<Map<String, dynamic>> getListOfDataHistory({int offset = 0}) async {
    int limit = 5 + offset;

    await fetchOrderData();
    if (limit > getOrderHistory().length) limit = getOrderHistory().length;
    return {
      'data': getOrderHistory().getRange(offset, limit).toList(),
      'next': limit < getOrderHistory().length ? true : null,
      'previous': offset > 0 ? true : null,
    };
  }

  Future<void> fetchOrderData() async {
    try {
      var dio =
          HttpService.dioCall(token: await LocalStorageService.getToken());

      var id = await LocalStorageService.box.get('id');
      final response = await dio.get(
        'order/user/$id',
      );

      if (response.statusCode == 200) {
        final responseData = response.data;
        if (responseData['data'] != null) {
          ongoingOrder.clear();
          for (var element in responseData['data']) {
            final dataOrder = Order.fromJson(element);
            ongoingOrder.add(dataOrder);
          }
        }
      } else {
        throw Exception('API Error');
      }
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
    }
  }

  List<Order> getOngoingOrder() {
    return ongoingOrder.reversed
        .where((element) => element.status < 3)
        .toList();
  }

  List<Order> getOrderHistory() {
    return ongoingOrder.where((element) => element.status >= 2).toList();
  }

  Future<OrderDetail> getOrderDetail(int idOrder) async {
    try {
      var dio =
          HttpService.dioCall(token: await LocalStorageService.getToken());

      final response = await dio.get(
        'order/detail/$idOrder',
      );

      if (response.statusCode == 200) {
        final responseData = response.data;
        if (responseData['data'] != null) {
          final orderHeader =
              OrderHeader.fromJson(responseData['data']['order']);

          var listMenuOrder = <Detail>[];
          for (var element in responseData['data']['detail']) {
            final orderListMenu = Detail.fromJson(element);
            listMenuOrder.add(orderListMenu);
          }
          return OrderDetail(order: orderHeader, detail: listMenuOrder);
        } else {
          return OrderDetail();
        }
      } else {
        throw Exception('API Error');
      }
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      return OrderDetail();
    }
  }
}
