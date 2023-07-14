import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trainee/constants/cores/assets/image_constant.dart';

import '../../../../../configs/routes/main_route.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  Widget build(BuildContext context) {
    analytics.setCurrentScreen(
      screenName: 'Splash Screen',
      screenClassOverride: 'Trainee',
    );

    Timer(
      const Duration(seconds: 1),
      () => Get.offNamed(MainRoute.initial),
    );

    return Scaffold(
      body: Center(
        child: Image.asset(
          ImageConstant.logo,
          width: MediaQuery.of(context).size.width / 2,
          height: MediaQuery.of(context).size.height / 3,
        ),
      ),
    );
  }
}
