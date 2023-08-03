import 'dart:async';
import 'package:get/get.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:trainee/modules/features/order/controllers/order_controller.dart';

import '../../../../configs/themes/main_color.dart';
import '../models/order_detail.dart';
import '../repositories/order_repository.dart';

class DetailOrderController extends GetxController {
  static DetailOrderController get to => Get.find<DetailOrderController>();
  late final OrderRepository _orderRepository;

  // order data
  RxString orderDetailState = 'loading'.obs;
  Rxn<OrderDetail> order = Rxn();
  Timer? timer;
  late int orderId;

  @override
  void onInit() {
    super.onInit();
    _orderRepository = OrderRepository();
    orderId = int.parse(Get.parameters['orderId'] as String);

    getOrderDetail(orderId).then((value) {
      timer = Timer.periodic(
        const Duration(seconds: 10),
        (_) => getOrderDetail(orderId, isPeriodic: true),
      );
    });
  }

  @override
  void onClose() {
    timer?.cancel();
    super.onClose();
  }

  Future<void> getOrderDetail(int orderId, {bool isPeriodic = false}) async {
    if (!isPeriodic) {
      orderDetailState('loading');
    }
    try {
      final result = await _orderRepository.getOrderDetail(orderId);

      if (result.order != null) {
        orderDetailState('success');
        order(result);
      }
    } catch (exception, stacktrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stacktrace,
      );
      orderDetailState('error');
    }
  }

  List<Detail> get foodItems =>
      order.value?.detail!
          .where((element) => element.kategori == 'makanan')
          .toList() ??
      [];

  List<Detail> get drinkItems =>
      order.value?.detail!
          .where((element) => element.kategori == 'minuman')
          .toList() ??
      [];

  Future<void> cancelOrder() async {
    final response = await _orderRepository.cancelOrder(orderId);
    if (response) {
      Get.back();
      OrderController.to.onRefreshOnGoing();
      Get.snackbar(
        "Berhasil",
        "Pesanan berhasil dibatalkan",
        duration: const Duration(milliseconds: 1500),
        backgroundColor: MainColor.white,
        snackPosition: SnackPosition.TOP,
      );
    } else {
      Get.snackbar(
        "Gagal",
        "Pesanan gagal dibatalkan, terjadi kesalahan",
        duration: const Duration(milliseconds: 1500),
        backgroundColor: MainColor.white,
        snackPosition: SnackPosition.TOP,
      );
    }
  }
}
