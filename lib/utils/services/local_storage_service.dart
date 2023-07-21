import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:trainee/modules/features/sign_in/models/sign_in_response.dart';
import 'package:trainee/modules/global_models/menu.dart';

class LocalStorageService extends GetxService {
  LocalStorageService._();
  static final box = Hive.box("venturo");

  /// Kode untuk setting localstorage sesuai dengan repository
  static Future<void> setAuth(SignInData signInData) async {
    await box.put("id", signInData.user.idUser);
    await box.put("name", signInData.user.nama);
    await box.put("photo", signInData.user.foto);
    await box.put("roles", signInData.user.roles);
    await box.put("token", signInData.token);
    await box.put("isLogin", true);

    /// Log id user
    await FirebaseAnalytics.instance.setUserId(
      id: signInData.user.idUser.toString(),
    );
  }

  static Future deleteAuth() async {
    if (box.get("isRememberMe") == false) {
      box.clear();
      box.put("isLogin", false);
    } else {
      box.put("isLogin", false);
    }
  }

  static Future isLogIn() async {
    return box.get('isLogin');
  }

  static Future getToken() async {
    return box.get('token');
  }

  // Method to save the cart data to Hive
  static Future<void> saveCartData(List<Menu> cartItems) async {
    await box.put('cartItems', cartItems);
  }

  // Method to retrieve the cart data from Hive
  static Future<List<Menu>> getCartData() async {
    final cartItems = box.get('cartItems', defaultValue: []);
    return List<Menu>.from(cartItems);
  }
}
