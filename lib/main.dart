import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:trainee/configs/pages/main_page.dart';
import 'package:trainee/configs/routes/main_route.dart';
import 'package:trainee/configs/themes/main_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:trainee/shared/customs/bottom_navigation_observer.dart';
import 'package:trainee/utils/services/firebase_messaging_service.dart';
import 'configs/localization/localization.dart';
import 'firebase_options.dart';
import 'modules/global_binddings/global_binding.dart';
import 'modules/global_models/menu_cart.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Localstorage init
  await Hive.initFlutter();
  Hive.registerAdapter(MenuCartAdapter());
  await Hive.openBox("venturo");

  // firebase init
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // notif
  await FirebaseMessagingService.instance.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  log((await FirebaseMessagingService.instance.getToken()).toString());

  await FirebaseMessaging.instance.subscribeToTopic('order');

  await FirebaseMessagingService().initialize();
  FirebaseMessaging.onBackgroundMessage(
      FirebaseMessagingService.handleBackgroundNotif);
  // sentry init
  await SentryFlutter.init(
    (options) {
      options.dsn =
          'https://54d36924361e4cbf86384996e2538227@o4505525100609536.ingest.sentry.io/4505525102051328';
      options.tracesSampleRate = 1.0;
    },
    appRunner: () => runApp(const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(414, 896),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          title: 'Trainee Sekeleton',
          debugShowCheckedModeBanner: false,
          initialRoute: MainRoute.splash,
          navigatorObservers: [BottomNavigationObserver()],
          theme: mainTheme,
          defaultTransition: Transition.native,
          getPages: MainPage.main,
          initialBinding: GlobalBinding(),
          builder: EasyLoading.init(),
          translations: Localization(),
          locale: Localization.defaultLocale,
          fallbackLocale: Localization.fallbackLocale,
          supportedLocales: Localization.locales,
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
        );
      },
    );
  }
}
