import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:trainee/modules/features/order/repositories/order_repository.dart';

import '../models/order.dart';

class OrderController extends GetxController {
  static OrderController get to => Get.find<OrderController>();
  late final OrderRepository _orderRepository;

  @override
  void onInit() async {
    super.onInit();
    _orderRepository = OrderRepository();

    await _orderRepository.fetchOrderData();

    getOngoingOrders();
    getOrderHistories();
  }

  RxList<Order> onGoingOrders = RxList();
  RxList<Order> historyOrders = RxList();
  RxString onGoingOrderState = 'loading'.obs;
  RxString orderHistoryState = 'loading'.obs;

  Rx<String> selectedCategory = 'all'.obs;

  Map<String, String> get dateFilterStatus => {
        'all': 'Semua Status'.tr,
        'completed': 'Selesai'.tr,
        'canceled': 'Dibatalkan'.tr,
      };

  Rx<DateTimeRange> selectedDateRange = DateTimeRange(
    start: DateTime.now().subtract(const Duration(days: 30)),
    end: DateTime.now(),
  ).obs;

  Future<void> getOngoingOrders() async {
    onGoingOrderState('loading');
    try {
      final result = _orderRepository.getOngoingOrder();
      final data = result.where((element) => element.status != 4).toList();
      onGoingOrders(data.reversed.toList());
      onGoingOrderState('success');
    } catch (exception, stacktrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stacktrace,
      );
      onGoingOrderState('error');
    }
  }

  Future<void> getOrderHistories() async {
    orderHistoryState('loading');

    try {
      final result = _orderRepository.getOrderHistory();
      historyOrders(result.reversed.toList());
      orderHistoryState('success');
    } catch (exception, stacktrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stacktrace,
      );
      orderHistoryState('error');
    }
  }

  void setDateFilter({String? category, DateTimeRange? range}) {
    selectedCategory(category);
    selectedDateRange(range);
  }

  List<Order> get filteredHistoryOrder {
    final historyOrderList = historyOrders.toList();

    if (selectedCategory.value == 'canceled') {
      historyOrderList.removeWhere((element) => element.status != 4);
    } else if (selectedCategory.value == 'completed') {
      historyOrderList.removeWhere((element) => element.status != 3);
    }

    historyOrderList.removeWhere((element) =>
        DateTime.parse(element.tanggal)
            .isBefore(selectedDateRange.value.start) ||
        DateTime.parse(element.tanggal).isAfter(selectedDateRange.value.end));

    historyOrderList.sort((a, b) =>
        DateTime.parse(b.tanggal).compareTo(DateTime.parse(a.tanggal)));

    return historyOrderList;
  }

  String get totalHistoryOrder {
    final total = filteredHistoryOrder.where((e) => e.status == 3).fold(
        0, (previousValue, element) => previousValue + element.totalBayar);

    return total.toString();
  }
}
