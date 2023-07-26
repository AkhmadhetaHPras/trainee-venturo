import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:trainee/configs/themes/main_color.dart';
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
              child: Obx(
                () => ListView.builder(
                  scrollDirection: Axis.vertical,
                  padding: EdgeInsets.symmetric(horizontal: 25.w),
                  itemBuilder: (context, index) {
                    final item = CartController.to.cartItems[index];
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.5.h),
                      child: Material(
                        borderRadius: BorderRadius.circular(10.r),
                        elevation: 2,
                        child: MenuCartCard(
                          menu: item,
                          index: index,
                        ),
                      ),
                    );
                  },
                  itemCount: CartController.to.cartItems.length,
                  itemExtent: 112.h,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
