import 'package:get/route_manager.dart';
import 'package:trainee/configs/routes/main_route.dart';
import 'package:trainee/modules/features/cart/bindings/edit_cart_binding.dart';
import 'package:trainee/modules/features/cart/views/ui/cart_view.dart';
import 'package:trainee/modules/features/cart/views/ui/detail_voucher.dart';
import 'package:trainee/modules/features/cart/views/ui/edit_menu_cart.dart';
import 'package:trainee/modules/features/cart/views/ui/list_voucher.dart';
import 'package:trainee/modules/features/counter/binddings/conter_bindding.dart';
import 'package:trainee/modules/features/counter/views/ui/conter_view.dart';
import 'package:trainee/modules/features/initial/bindings/location_binding.dart';
import 'package:trainee/modules/features/menu/bindings/menu_binding.dart';
import 'package:trainee/modules/features/menu/views/ui/menu_view.dart';
import 'package:trainee/modules/features/profile/bindings/profile_binding.dart';
import 'package:trainee/modules/features/profile/views/ui/profile_view.dart';
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
import '../../modules/features/order/bindings/detail_order_binding.dart';
import '../../modules/features/order/bindings/order_binding.dart';
import '../../modules/features/order/views/ui/detail_order_view.dart';
import '../../modules/features/order/views/ui/order_view.dart';
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
    GetPage(
      name: MainRoute.cartEditMenu,
      page: () => const EditMenuCartView(),
      binding: EditCartBinding(),
    ),
    GetPage(
      name: MainRoute.chooseVoucher,
      page: () => const ListVoucher(),
    ),
    GetPage(
      name: MainRoute.detailVoucher,
      page: () => const DetailVoucher(),
    ),
    GetPage(
      name: MainRoute.order,
      page: () => const OrderView(),
      binding: OrderBinding(),
    ),
    GetPage(
      name: MainRoute.orderDetail,
      page: () => const DetailOrderView(),
      binding: DetailOrderBinding(),
    ),
    GetPage(
      name: MainRoute.profile,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
  ];
}
