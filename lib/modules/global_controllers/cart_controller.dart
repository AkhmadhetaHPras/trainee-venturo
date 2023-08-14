import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:trainee/configs/routes/main_route.dart';
import 'package:trainee/modules/features/cart/views/components/discount_dialog.dart';
import 'package:trainee/modules/global_models/voucher.dart';

import '../../utils/services/http_service.dart';
import '../../utils/services/local_storage_service.dart';
import '../features/cart/views/components/fingerprint_dialog.dart';
import '../features/cart/views/components/order_success_dialog.dart';
import '../features/cart/views/components/pin_dialog.dart';
import '../global_models/diskon.dart';
import '../global_models/menu_cart.dart';
import '../global_models/post_order.dart';
import '../global_repositories/cart_repository.dart';

class CartController extends GetxController {
  static CartController get to => Get.find();

  late final CartRepository repository;

  final RxList<MenuCart> cartItems = <MenuCart>[].obs;
  final RxList<VoucherData> vouchers = <VoucherData>[].obs;
  final Rx<VoucherData> selectedVoucher = VoucherData().obs;
  final RxInt discountPrice = 0.obs;
  final RxInt discount = 0.obs;
  RxList<DiskonData> discounts = <DiskonData>[].obs;

  @override
  void onReady() async {
    super.onReady();
    repository = CartRepository();
    await loadCartData();
    await getVouchers();
    getTotalPrice();
    await getDiscount();
    await getDiscountPrice();
  }

  // Method to add an item to the cart and save to Hive
  Future addToCart(MenuCart menu) async {
    EasyLoading.show(
      status: 'Loading...'.tr,
      maskType: EasyLoadingMaskType.black,
      dismissOnTap: false,
    );
    cartItems.add(menu);
    await LocalStorageService.saveCartData(cartItems.toList());
    EasyLoading.dismiss();
    Get.toNamed(MainRoute.cart);
  }

  // Method to remove an item from the cart and save to Hive
  void removeFromCart(MenuCart menu) async {
    cartItems.remove(menu);
    await LocalStorageService.saveCartData(cartItems.toList());
  }

  // Method to update an item in the cart and save to Hive
  void updateCartItem(int index, MenuCart updatedMenu) async {
    if (index >= 0 && index < cartItems.length) {
      cartItems[index] = updatedMenu;
      await LocalStorageService.saveCartData(cartItems.toList());
    }
  }

  // Method to load cart data from Hive during initialization
  Future<void> loadCartData() async {
    final List<MenuCart> savedCartItems =
        await LocalStorageService.getCartData();
    cartItems.addAll(savedCartItems);
  }

  List<MenuCart> get foodList =>
      cartItems.where((element) => element.kategori == 'makanan').toList().obs;

  List<MenuCart> get drinkList =>
      cartItems.where((element) => element.kategori == 'minuman').toList();

  Future getDiscount() async {
    discount.value = await repository.getDiscount();
  }

  Future getDiscountPrice() async {
    discountPrice.value = discount * getTotalPrice() ~/ 100;
  }

  // Get the total price of items in the cart
  int getTotalPrice() {
    int totalPrice = 0;
    for (MenuCart menu in cartItems) {
      totalPrice += menu.harga * menu.jumlah;
    }
    return totalPrice;
  }

  int getGrandTotal() {
    return getTotalPrice() -
        discountPrice.value -
        (selectedVoucher.value.idVoucher != null
            ? selectedVoucher.value.nominal!
            : 0);
  }

  int getPriceCut() {
    return discountPrice.value +
        (selectedVoucher.value.idVoucher != null
            ? selectedVoucher.value.nominal!
            : 0);
  }

  handleCheckboxChanged(int index, bool isChecked) {
    for (int i = 0; i < vouchers.length; i++) {
      if (i == index) {
        vouchers[i].checked = isChecked;
        if (isChecked) {
          selectedVoucher.value = vouchers[i];
        } else {
          selectedVoucher.value =
              VoucherData(); // Clear the selected voucher when unchecked
        }
      } else {
        vouchers[i].checked = false;
      }
    }
  }

  Future<void> verify() async {
    if (cartItems.isNotEmpty) {
// check supported auth type in device
      final LocalAuthentication localAuth = LocalAuthentication();
      final bool canCheckBiometrics = await localAuth.canCheckBiometrics;
      final bool isBiometricSupported = await localAuth.isDeviceSupported();

      if (canCheckBiometrics && isBiometricSupported) {
        // open fingerprint dialog if supported
        final String? authType = await showFingerprintDialog();

        if (authType == 'fingerprint') {
          // fingerprint auth flow
          final bool authenticated = await localAuth.authenticate(
            localizedReason: 'Please authenticate to confirm order'.tr,
            options: const AuthenticationOptions(
              biometricOnly: true,
            ),
          );

          // if succeed, order cart
          if (authenticated) {
            EasyLoading.show(
              status: 'Loading...'.tr,
              maskType: EasyLoadingMaskType.black,
              dismissOnTap: false,
            );
            if (await postOrder()) {
              EasyLoading.dismiss();
              showOrderSuccessDialog();
            }
          }
        } else if (authType == 'pin') {
          // pin auth flow
          await showPinDialog();
        }
      } else {
        await showPinDialog();
      }
    } else {
      Get.snackbar("Sorry".tr, "Add Menu to Cart Fisrt!".tr);
    }
  }

  Future<String?> showFingerprintDialog() async {
    // ensure all modal is closed before show fingerprint dialog
    Get.until(ModalRoute.withName(MainRoute.cart));
    final result = await Get.defaultDialog(
      title: '',
      titleStyle: const TextStyle(fontSize: 0),
      content: const FingerprintDialog(),
    );

    return result;
  }

  Future<void> showPinDialog() async {
    // ensure all modal is closed before show pin dialog
    Get.until(ModalRoute.withName(MainRoute.cart));

    const userPin = '123456';

    final bool? authenticated = await Get.defaultDialog(
      title: '',
      titleStyle: const TextStyle(fontSize: 0),
      content: const PinDialog(pin: userPin),
    );

    if (authenticated == true) {
      EasyLoading.show(
        status: 'Loading...'.tr,
        maskType: EasyLoadingMaskType.black,
        dismissOnTap: false,
      );
      // if succeed, order cart
      if (await postOrder()) {
        EasyLoading.dismiss();
        showOrderSuccessDialog();
      }
    } else if (authenticated != null) {
      // if failed 3 times, show order failed dialog
      Get.until(ModalRoute.withName(MainRoute.cart));
    }
  }

  Future<void> showOrderSuccessDialog() async {
    Get.until(ModalRoute.withName(MainRoute.cart));
    await Get.defaultDialog(
      title: '',
      titleStyle: const TextStyle(fontSize: 0),
      content: const OrderSuccessDialog(),
      barrierDismissible: false,
    );
  }

  Future<void> showDiscountDialog() async {
    Get.until(ModalRoute.withName(MainRoute.cart));
    await Get.defaultDialog(
      title: '',
      titleStyle: const TextStyle(fontSize: 0),
      content: const DiscountDialog(),
    );
  }

  Future getVouchers() async {
    final datas = await repository.getListVoucher();
    vouchers.clear();

    if (datas.data != null) {
      vouchers.addAll(datas.data!);
    }
  }

  Future<bool> postOrder() async {
    try {
      var dio =
          HttpService.dioCall(token: await LocalStorageService.getToken());

      final id = await LocalStorageService.box.get('id');
      final order = PostOrder(
          idUser: id,
          idVoucher: selectedVoucher.value.idVoucher,
          diskon: discount.value,
          potongan: getPriceCut(),
          totalBayar: getGrandTotal());

      var listMenuOrder = <MenuModel>[];
      for (var item in cartItems) {
        final menuOrder = MenuModel(
          idMenu: item.idMenu,
          harga: item.harga,
          topping: item.topping,
          jumlah: item.jumlah,
          catatan: item.catatan,
        );
        listMenuOrder.add(menuOrder);
      }

      final postModel = OrderDataModel(order: order, menu: listMenuOrder);
      final response = await dio.post('order/add', data: postModel);

      if (response.statusCode == 200) {
        final responseData = response.data;
        if (responseData['status_code'] == 200) {
          cartItems.clear();
          await LocalStorageService.box.put('cartItems', []);
          return true;
        } else {
          return false;
        }
      } else {
        throw Exception('API Error');
      }
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      return false;
    }
  }
}
