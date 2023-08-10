import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trainee/configs/routes/main_route.dart';
import 'package:trainee/configs/themes/main_color.dart';
import 'package:trainee/modules/global_controllers/global_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trainee/constants/cores/assets/image_constant.dart';

class NoConnectionView extends StatelessWidget {
  const NoConnectionView({super.key});
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  Widget build(BuildContext context) {
    analytics.setCurrentScreen(
      screenName: 'No Connection Screen',
      screenClassOverride: 'Trainee',
    );

    return Scaffold(
      appBar: null,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImageConstant.bgBlank),
            fit: BoxFit.cover,
          ),
        ),
        padding: EdgeInsets.symmetric(
          vertical: 35.h,
          horizontal: 35.w,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Image.asset(
              ImageConstant.noInet,
              height: 100.h,
              fit: BoxFit.fitHeight,
            ),
            SizedBox(height: 25.h),
            Text(
              "Oops no internet connection".tr,
              style: GoogleFonts.roboto(
                fontSize: 22.sp,
                fontWeight: FontWeight.w800,
                color: MainColor.primary,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10.h),
            Text(
              "Make sure your wifi or mobile data is connected, then press the retry button"
                  .tr,
              style: GoogleFonts.roboto(
                fontSize: 18.sp,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 25.h),
            SizedBox(
              width: 150,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: MainColor.primary,
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                onPressed: () {
                  GlobalController.to.checkConnectionInPage();
                  if (GlobalController.to.isConnect.value == true) {
                    Get.offNamed(MainRoute.initial);
                  } else {
                    Get.snackbar(
                      "Error Occurred".tr,
                      "Connection still not established".tr,
                    );
                  }
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Retry".tr,
                      style: GoogleFonts.roboto(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
