import 'dart:io';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:trainee/configs/themes/main_color.dart';
import 'package:trainee/modules/features/sign_in/controllers/sign_in_controller.dart';
import 'package:trainee/modules/features/sign_in/views/components/form_sign_in_component.dart';
import 'package:trainee/shared/styles/google_text_style.dart';
import 'package:trainee/shared/styles/elevated_button_style.dart';
import 'package:trainee/constants/cores/assets/image_constant.dart';

import '../../../../../configs/routes/main_route.dart';
import '../components/social_sign_in_button_component.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  Widget build(BuildContext context) {
    /// Google analytics untuk tracking user di setiap halaman
    if (Platform.isAndroid) {
      /// Tracking bahwa dia masuk screen sign in di device android
      analytics.setCurrentScreen(
        screenName: 'Sign In Screen',
        screenClassOverride: 'Android',
      );
    } else if (Platform.isIOS) {
      /// Tracking bahwa dia masuk screen sign in di device ios
      analytics.setCurrentScreen(
        screenName: 'Sign In Screen',
        screenClassOverride: 'IOS',
      );
    } else if (Platform.isMacOS) {
      /// Tracking bahwa dia masuk screen sign in di device macos
      analytics.setCurrentScreen(
        screenName: 'Sign In Screen',
        screenClassOverride: 'MacOS',
      );
    }

    if (kIsWeb) {
      /// Tracking bahwa dia masuk screen sign in di device web
      analytics.setCurrentScreen(
        screenName: 'Sign In Screen',
        screenClassOverride: 'Web',
      );
    }

    return Scaffold(
      appBar: null,
      extendBody: false,
      backgroundColor: MainColor.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(45),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 30.h),
              GestureDetector(
                onDoubleTap: () => SignInController.to.flavorSeting(),
                child: Image.asset(
                  ImageConstant.logo,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: 40.h),
              Text(
                'Masuk untuk melanjutkan!',
                style: GoogleTextStyle.fw600.copyWith(
                  fontSize: 22.sp,
                  color: MainColor.black,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40.h),
              const FormSignInComponent(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      Get.toNamed(MainRoute.forgotPassword);
                    },
                    child: Text(
                      "Forgot Password",
                      style: GoogleTextStyle.fw400.copyWith(
                        fontSize: 14.sp,
                        color: MainColor.black,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              ElevatedButton(
                style: EvelatedButtonStyle.mainRounded,
                onPressed: () => SignInController.to.validateForm(context),
                child: Text(
                  "Masuk",
                  style: GoogleTextStyle.fw800.copyWith(
                    fontSize: 14.sp,
                    color: MainColor.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 40.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                    child: Divider(
                      color: Colors.black,
                      height: 1.5,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      'atau',
                      style: GoogleTextStyle.fw400.copyWith(
                        fontSize: 14.sp,
                        color: MainColor.black,
                      ),
                    ),
                  ),
                  const Expanded(
                    child: Divider(
                      color: Colors.black,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              SocialSignInButtonComponent(
                buttonText: "Google",
                iconAssetPath: ImageConstant.icGoogle,
                backgroundColor: MainColor.white,
                fontColor: MainColor.black,
                onPressed: () => SignInController.to.signInWithGoogle(context),
              ),
              const SizedBox(
                height: 17,
              ),
              SocialSignInButtonComponent(
                buttonText: "Apple",
                iconAssetPath: ImageConstant.icApple,
                backgroundColor: MainColor.black,
                fontColor: MainColor.white,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
