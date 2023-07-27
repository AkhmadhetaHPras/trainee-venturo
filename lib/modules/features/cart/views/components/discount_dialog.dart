import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:trainee/configs/themes/main_color.dart';
import 'package:trainee/shared/styles/google_text_style.dart';

import '../../../../global_controllers/cart_controller.dart';

class DiscountDialog extends StatelessWidget {
  const DiscountDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.r),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          28.verticalSpace,
          Text(
            'Info Diskon'.tr,
            style: GoogleTextStyle.fw600.copyWith(
              fontSize: 22.sp,
              color: MainColor.primary,
            ),
            textAlign: TextAlign.center,
          ),
          28.verticalSpace,
          Obx(
            () {
              if (CartController.to.discounts.isNotEmpty) {
                var wid = <Widget>[];
                final length = CartController.to.discounts.length;
                for (var i = 0; i < length; i++) {
                  final item = CartController.to.discounts[i];
                  wid.add(Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        item.nama ?? "",
                        style: GoogleTextStyle.fw400.copyWith(
                          fontSize: 16.sp,
                          color: MainColor.dark,
                        ),
                      ),
                      Text(
                        "${item.diskon.toString()} %",
                        style: GoogleTextStyle.fw700.copyWith(
                          fontSize: 16.sp,
                          color: MainColor.dark,
                        ),
                      ),
                    ],
                  ));
                }
                return Column(
                  children: wid,
                );
              } else {
                return const Center(
                  child: Text("Anda tidak memiliki diskon"),
                );
              }
            },
          ),
          28.verticalSpace,
          SizedBox(
            width: 168.w,
            child: ElevatedButton(
              onPressed: () => Get.back(),
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
                    'Oke',
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
