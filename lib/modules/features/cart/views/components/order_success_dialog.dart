import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:trainee/configs/routes/main_route.dart';
import 'package:trainee/constants/cores/assets/image_constant.dart';
import 'package:trainee/modules/global_controllers/bottom_navigation_controller.dart';

class OrderSuccessDialog extends StatelessWidget {
  const OrderSuccessDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.r),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          28.verticalSpace,
          Image.asset(
            ImageConstant.icSuccessOrder,
            height: 100,
          ),
          28.verticalSpace,
          Text(
            'Orders are being Prepared'.tr,
            style: Get.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
          14.verticalSpace,
          Text.rich(
            TextSpan(children: [
              TextSpan(
                text: 'You can track your order in the '.tr,
                style: Get.textTheme.bodySmall!.copyWith(
                  color: Colors.black,
                ),
              ),
              TextSpan(
                text: 'Order Feature'.tr,
                style: Get.textTheme.bodySmall!.copyWith(
                  fontWeight: FontWeight.w800,
                  color: Colors.black,
                ),
              ),
            ]),
            textAlign: TextAlign.center,
          ),
          14.verticalSpace,
          SizedBox(
            width: 168.w,
            child: ElevatedButton(
              onPressed: () {
                BottomNavigationController.to.setActiveIndex(1);
                Get.toNamed(MainRoute.order);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                maximumSize: Size(
                  1.sw,
                  56.h,
                ),
                side: BorderSide(
                  color: Theme.of(context).primaryColorDark,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.r),
                ),
                elevation: 2,
                tapTargetSize: null,
                minimumSize: Size(
                  1.sw,
                  56.h,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Oke'.tr,
                    textAlign: TextAlign.center,
                    style: Get.textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                      fontSize: 14.sp,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
