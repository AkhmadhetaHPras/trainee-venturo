import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
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

    await getListOnGoing();
    await getListHistory();
  }

  final RxInt pageOnGoing = 0.obs;
  final RxBool canLoadMoreOnGoing = true.obs;
  final RefreshController refreshOnGoingController =
      RefreshController(initialRefresh: false);

  final RxInt pageHistory = 0.obs;
  final RxBool canLoadMoreHistory = true.obs;
  final RefreshController refreshHistoryController =
      RefreshController(initialRefresh: false);

  RxList<Order> onGoingOrders = RxList();
  RxList<Order> historyOrders = RxList();
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

  void setDateFilter({String? category, DateTimeRange? range}) {
    selectedCategory(category);
    selectedDateRange(range);
  }

  List<Order> get filteredHistoryOrder {
    final historyOrderList = historyOrders.toList();
    print(historyOrderList.length);
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

  Future<bool> getListOnGoing() async {
    try {
      final result = await _orderRepository.getListOfDataOnGoing(
        offset: pageOnGoing.value * 5,
      );
      if (result['previous'] == null) {
        onGoingOrders.clear();
      }

      if (result['next'] == null) {
        canLoadMoreOnGoing(false);
        refreshOnGoingController.loadNoData();
      }

      final data =
          result['data'].where((element) => element.status != 4).toList();
      onGoingOrders.addAll(data.toList());
      pageOnGoing.value++;
      refreshOnGoingController.loadComplete();
      return true;
    } catch (exception, stacktrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stacktrace,
      );

      refreshOnGoingController.loadFailed();
      return false;
    }
  }

  void onRefreshOnGoing() async {
    pageOnGoing(0);
    canLoadMoreOnGoing(true);
    final result = await getListOnGoing();
    if (result) {
      refreshOnGoingController.refreshCompleted();
    } else {
      refreshOnGoingController.refreshFailed();
    }
  }

  Future<bool> getListHistory() async {
    try {
      final result = await _orderRepository.getListOfDataHistory(
        offset: pageHistory.value * 5,
      );
      if (result['previous'] == null) {
        historyOrders.clear();
      }

      if (result['next'] == null) {
        canLoadMoreHistory(false);
        refreshHistoryController.loadNoData();
      }
      historyOrders.addAll(result['data'].toList());
      pageHistory.value++;
      refreshHistoryController.loadComplete();
      return true;
    } catch (exception, stacktrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stacktrace,
      );

      refreshHistoryController.loadFailed();
      return false;
    }
  }

  Future<void> onRefreshHistory() async {
    pageHistory(0);
    canLoadMoreHistory(true);
    final result = await getListHistory();
    if (result) {
      refreshHistoryController.refreshCompleted();
    } else {
      refreshHistoryController.refreshFailed();
    }
  }

  Future<void> orderAgain(Order preOrder) async {}
}
