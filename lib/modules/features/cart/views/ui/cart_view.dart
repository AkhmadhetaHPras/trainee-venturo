import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:trainee/configs/themes/main_color.dart';
import 'package:trainee/modules/features/cart/views/components/menu_cart_card.dart';
import 'package:trainee/modules/global_controllers/cart_controller.dart';
import 'package:trainee/shared/customs/custom_app_bar.dart';

import '../../../../../shared/styles/elevated_button_style.dart';
import '../../../../../shared/styles/google_text_style.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const CustomAppBar(
          icon: Icons.shopping_cart,
          title: "Pesanan",
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
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: MainColor.lightGrey,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(25.r),
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 25.w,
                      vertical: 25.h,
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Total Pesanan ",
                                style: GoogleTextStyle.fw600.copyWith(
                                    fontSize: 18, color: MainColor.dark),
                              ),
                              Obx(
                                () => Text(
                                  "(${CartController.to.cartItems.length} Menu) : ",
                                  style: GoogleTextStyle.fw400.copyWith(
                                      fontSize: 18, color: MainColor.dark),
                                ),
                              ),
                              Expanded(
                                child: Obx(
                                  () => Text(
                                    "Rp. ${CartController.to.getTotalPrice()}",
                                    style: GoogleTextStyle.fw700.copyWith(
                                      fontSize: 14,
                                      color: MainColor.primary,
                                    ),
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        const Divider(
                          color: MainColor.dark,
                          height: 1.5,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: InkWell(
                            onTap: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Icon(Icons.discount),
                                const SizedBox(
                                  width: 8,
                                ),
                                Obx(
                                  () => Text(
                                    "Diskon ${CartController.to.discount}%",
                                    style: GoogleTextStyle.fw600.copyWith(
                                        fontSize: 18, color: MainColor.dark),
                                  ),
                                ),
                                const Expanded(
                                  child: SizedBox(),
                                ),
                                Obx(
                                  () => Text(
                                    "Rp. ${CartController.to.discountPrice}",
                                    style: GoogleTextStyle.fw400.copyWith(
                                        fontSize: 14, color: MainColor.danger),
                                  ),
                                ),
                                const Icon(
                                  Icons.keyboard_arrow_right,
                                  color: MainColor.grey,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Divider(
                          color: MainColor.dark,
                          height: 1.5,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: InkWell(
                            onTap: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Icon(Icons.label_off_outlined),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  "Voucher",
                                  style: GoogleTextStyle.fw600.copyWith(
                                      fontSize: 18, color: MainColor.dark),
                                ),
                                const Expanded(
                                  child: SizedBox(),
                                ),
                                Text(
                                  "Pilih Voucher",
                                  style: GoogleTextStyle.fw400.copyWith(
                                      fontSize: 14, color: MainColor.dark),
                                ),
                                const Icon(
                                  Icons.keyboard_arrow_right,
                                  color: MainColor.grey,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Divider(
                          color: MainColor.dark,
                          height: 1.5,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: InkWell(
                            onTap: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Icon(Icons.currency_exchange_outlined),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  "Pembayaran",
                                  style: GoogleTextStyle.fw600.copyWith(
                                      fontSize: 18, color: MainColor.dark),
                                ),
                                const Expanded(
                                  child: SizedBox(),
                                ),
                                Text(
                                  "Pay Later",
                                  style: GoogleTextStyle.fw400.copyWith(
                                      fontSize: 14, color: MainColor.dark),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 16),
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
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.shopping_bag,
                          size: 35,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Total Pembayaran",
                                style: GoogleTextStyle.fw500.copyWith(
                                  fontSize: 12.sp,
                                ),
                              ),
                              Obx(
                                () => Text(
                                  "Rp. ${CartController.to.getGrandTotal()}",
                                  style: GoogleTextStyle.fw700.copyWith(
                                    fontSize: 20.sp,
                                    color: MainColor.primary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          style: EvelatedButtonStyle.mainRounded.copyWith(
                              minimumSize: MaterialStateProperty.all<Size>(
                            const Size(40, 40),
                          )),
                          onPressed: () {
                            CartController.to.verify();
                          },
                          child: Text(
                            "Pesan Sekarang",
                            style: GoogleTextStyle.fw800.copyWith(
                              fontSize: 14.sp,
                              color: MainColor.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
