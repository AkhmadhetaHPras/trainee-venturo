import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:trainee/configs/themes/main_color.dart';
import 'package:trainee/modules/features/cart/views/components/item_voucher.dart';
import 'package:trainee/modules/features/cart/views/components/menu_cart_card.dart';
import 'package:trainee/modules/global_controllers/cart_controller.dart';
import 'package:trainee/shared/customs/custom_app_bar.dart';

import '../../../../../shared/styles/elevated_button_style.dart';
import '../../../../../shared/styles/google_text_style.dart';

class ListVoucher extends StatelessWidget {
  const ListVoucher({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const CustomAppBar(
          icon: Icons.label_off_outlined,
          title: "Voucher",
        ),
        body: Column(
          children: [
            Expanded(
              child: Obx(() {
                if (CartController.to.vouchers.isEmpty) {
                  return const Center(
                      child: Text("Maaf anda tidak memiliki voucher"));
                } else {
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    padding: EdgeInsets.symmetric(horizontal: 25.w),
                    itemBuilder: (context, index) {
                      final item = CartController.to.vouchers[index];
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.5.h),
                        child: Material(
                          borderRadius: BorderRadius.circular(10.r),
                          elevation: 2,
                          child: ItemVoucher(
                            name: item.nama!,
                            info: item.infoVoucher!,
                          ),
                        ),
                      );
                    },
                    itemCount: CartController.to.vouchers.length,
                  );
                }
              }),
            ),
          ],
        ),
        bottomNavigationBar: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
            color: MainColor.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(25.r),
            ),
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(111, 24, 24, 24),
                blurRadius: 15,
                spreadRadius: -1,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: ElevatedButton(
            onPressed: () {
              Get.back();
            },
            style: EvelatedButtonStyle.mainRounded.copyWith(
              backgroundColor: MaterialStateProperty.all<Color>(
                MainColor.primary,
              ),
            ),
            child: Text(
              "Oke",
              style: GoogleTextStyle.fw700
                  .copyWith(fontSize: 16.sp, color: MainColor.white),
            ),
          ),
        ),
      ),
    );
  }
}
