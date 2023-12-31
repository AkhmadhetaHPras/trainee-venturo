import 'package:get/route_manager.dart';
import 'package:trainee/configs/routes/main_route.dart';
import 'package:trainee/modules/features/counter/binddings/conter_bindding.dart';
import 'package:trainee/modules/features/counter/views/ui/conter_view.dart';
import 'package:trainee/modules/features/splash/bindings/splash_binding.dart';

import '../../modules/features/forgot_password/bindings/forgot_password_binding.dart';
import '../../modules/features/forgot_password/views/ui/forgot_password_view.dart';
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
  ];
}
