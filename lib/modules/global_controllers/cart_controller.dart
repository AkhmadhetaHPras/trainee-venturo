import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:trainee/modules/global_models/menu.dart';

import '../../configs/themes/main_color.dart';
import '../../utils/services/local_storage_service.dart';

class CartController extends GetxController {
  static CartController get to => Get.find();

  final RxList<Menu> cartItems = <Menu>[].obs;

  @override
  void onReady() async {
    super.onReady();
    await loadCartData();
    getTotalPrice();
  }

  // Method to add an item to the cart and save to Hive
  Future addToCart(Menu menu) async {
    EasyLoading.show(
      status: 'Sedang Diproses...',
      maskType: EasyLoadingMaskType.black,
      dismissOnTap: false,
    );
    cartItems.add(menu);
    await LocalStorageService.saveCartData(cartItems.toList());
    EasyLoading.dismiss();
    Get.snackbar(
      "Berhasil",
      "Menu telah ditambahkan ke keranjang",
      duration: const Duration(milliseconds: 1500),
      backgroundColor: MainColor.white,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  // Method to remove an item from the cart and save to Hive
  void removeFromCart(Menu menu) async {
    cartItems.remove(menu);
    await LocalStorageService.saveCartData(cartItems.toList());
  }

  // Method to update an item in the cart and save to Hive
  void updateCartItem(int index, Menu updatedMenu) async {
    if (index >= 0 && index < cartItems.length) {
      cartItems[index] = updatedMenu;
      await LocalStorageService.saveCartData(cartItems.toList());
    }
  }

  // Method to load cart data from Hive during initialization
  Future<void> loadCartData() async {
    final List<Menu> savedCartItems = await LocalStorageService.getCartData();
    cartItems.addAll(savedCartItems);
  }

  // Get the total price of items in the cart
  int getTotalPrice() {
    int totalPrice = 0;
    for (Menu menu in cartItems) {
      totalPrice += menu.harga * menu.jumlah;
    }
    return totalPrice;
  }
}
