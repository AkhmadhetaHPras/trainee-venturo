import 'package:get/route_manager.dart';
import 'package:trainee/configs/routes/main_route.dart';
import 'package:trainee/modules/features/cart/views/ui/cart_view.dart';
import 'package:trainee/modules/features/counter/binddings/conter_bindding.dart';
import 'package:trainee/modules/features/counter/views/ui/conter_view.dart';
import 'package:trainee/modules/features/initial/bindings/location_binding.dart';
import 'package:trainee/modules/features/menu/bindings/menu_binding.dart';
import 'package:trainee/modules/features/menu/views/ui/menu_view.dart';
import 'package:trainee/modules/features/promo/bindings/promo_binding.dart';
import 'package:trainee/modules/features/promo/views/ui/promo_view.dart';
import 'package:trainee/modules/features/splash/bindings/splash_binding.dart';

import '../../modules/features/forgot_password/bindings/forgot_password_binding.dart';
import '../../modules/features/forgot_password/bindings/otp_binding.dart';
import '../../modules/features/forgot_password/views/ui/forgot_password_view.dart';
import '../../modules/features/forgot_password/views/ui/otp_view.dart';
import '../../modules/features/initial/views/ui/get_location_screen.dart';
import '../../modules/features/list/bindings/list_binding.dart';
import '../../modules/features/list/views/ui/list_item_view.dart';
import '../../modules/features/no_connection/views/ui/no_connection_view.dart';
import '../../modules/features/sign_in/bindings/sing_in_binding.dart';
import '../../modules/features/sign_in/views/ui/sign_in_view.dart';
import '../../modules/features/splash/views/ui/splash_view.dart';

abstract class MainPage {
  static final main = [
    /// Setup
    GetPage(
      name: MainRoute.initial,
      page: () => const ConterView(),
      binding: ConterBindding(),
    ),
    GetPage(
      name: MainRoute.splash,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: MainRoute.noConnection,
      page: () => const NoConnectionView(),
    ),
    GetPage(
      name: MainRoute.signIn,
      page: () => const SignInView(),
      binding: SignInBindding(),
    ),
    GetPage(
      name: MainRoute.forgotPassword,
      page: () => const ForgotPasswordView(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: MainRoute.otpInput,
      page: () => const OtpView(),
      binding: OtpBinding(),
    ),
    GetPage(
      name: MainRoute.initLocation,
      page: () => const GetLocationScreen(),
      binding: LocationBinding(),
    ),
    GetPage(
      name: MainRoute.list,
      page: () => const ListItemView(),
      binding: ListBinding(),
    ),
    GetPage(
      name: MainRoute.detailMenu,
      page: () => const MenuView(),
      binding: MenuBinding(),
    ),
    GetPage(
      name: MainRoute.detailPromo,
      page: () => const PromoView(),
      binding: PromoBinding(),
    ),
    GetPage(
      name: MainRoute.cart,
      page: () => const CartView(),
    ),
  ];
}
