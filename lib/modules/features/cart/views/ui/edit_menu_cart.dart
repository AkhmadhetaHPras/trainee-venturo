import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:trainee/configs/themes/main_color.dart';
import 'package:trainee/modules/features/cart/controllers/edit_menu_cart_controller.dart';
import 'package:trainee/modules/features/cart/views/components/quantity_counter.dart';
import 'package:trainee/modules/features/menu/views/components/level_section.dart';
import 'package:trainee/modules/features/menu/views/components/notes_section.dart';
import 'package:trainee/modules/features/menu/views/components/price_section.dart';
import 'package:trainee/modules/features/menu/views/components/topping_section.dart';
import 'package:trainee/modules/global_controllers/cart_controller.dart';
import 'package:trainee/shared/customs/bottom_navigation.dart';
import 'package:trainee/shared/customs/custom_app_bar.dart';
import 'package:trainee/shared/styles/google_text_style.dart';

import '../../../../../shared/styles/elevated_button_style.dart';
import '../../../../global_models/menu_cart.dart';
import '../../../menu/views/components/menu_image.dart';

class EditMenuCartView extends StatelessWidget {
  const EditMenuCartView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.grey[100],
        appBar: const CustomAppBar(icon: Icons.menu_book, title: "Edit Menu"),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(
              () => MenuImage(
                image: CartController
                    .to.cartItems[EditMenuCartController.to.index.value].foto,
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: 25.w,
                  vertical: 10.h,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(30.r),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Obx(
                            () => Text(
                              CartController
                                  .to
                                  .cartItems[
                                      EditMenuCartController.to.index.value]
                                  .nama,
                              style: GoogleTextStyle.fw700.copyWith(
                                fontSize: 20.sp,
                                color: MainColor.primary,
                              ),
                            ),
                          ),
                          const Expanded(child: SizedBox()),
                          Obx(
                            () => QuantityCounter(
                              quantity: CartController
                                  .to
                                  .cartItems[
                                      EditMenuCartController.to.index.value]
                                  .jumlah,
                              onIncrement: () {
                                final menu = CartController.to.cartItems[
                                    EditMenuCartController.to.index.value];
                                CartController.to.updateCartItem(
                                  EditMenuCartController.to.index.value,
                                  MenuCart(
                                    idMenu: menu.idMenu,
                                    harga: menu.harga,
                                    level: menu.level,
                                    topping: menu.topping,
                                    jumlah: menu.jumlah + 1,
                                    nama: menu.nama,
                                    catatan: menu.catatan,
                                    deskripsi: menu.deskripsi,
                                    foto: menu.foto,
                                  ),
                                );
                              },
                              onDecrement: () {
                                final menu = CartController.to.cartItems[
                                    EditMenuCartController.to.index.value];
                                CartController.to.updateCartItem(
                                  EditMenuCartController.to.index.value,
                                  MenuCart(
                                    idMenu: menu.idMenu,
                                    harga: menu.harga,
                                    level: menu.level,
                                    topping: menu.topping,
                                    jumlah: menu.jumlah - 1,
                                    nama: menu.nama,
                                    catatan: menu.catatan,
                                    deskripsi: menu.deskripsi,
                                    foto: menu.foto,
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      Obx(
                        () => Text(
                          CartController
                                  .to
                                  .cartItems[
                                      EditMenuCartController.to.index.value]
                                  .catatan ??
                              "",
                          style: GoogleTextStyle.fw400.copyWith(
                            fontSize: 12.sp,
                            color: MainColor.dark,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 40),
                        child: Column(
                          children: [
                            Divider(
                              color: MainColor.dark,
                              height: 1.5,
                            ),
                            PriceSection(),
                            Divider(
                              color: MainColor.dark,
                              height: 1.5,
                            ),
                            LevelSection(
                                // selectedValue: ,
                                // data: ,
                                // onOptionSelected: ,
                                ),
                            Divider(
                              color: MainColor.dark,
                              height: 1.5,
                            ),
                            ToppingSection(),
                            Divider(
                              color: MainColor.dark,
                              height: 1.5,
                            ),
                            NotesSection(),
                            Divider(
                              color: MainColor.dark,
                              height: 1.5,
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          final menu = CartController.to
                              .cartItems[EditMenuCartController.to.index.value];
                          CartController.to.updateCartItem(
                            EditMenuCartController.to.index.value,
                            MenuCart(
                              idMenu: menu.idMenu,
                              harga: menu.harga,
                              level: menu.level,
                              topping: menu.topping,
                              jumlah: menu.jumlah,
                              nama: menu.nama,
                              catatan: menu.catatan,
                              deskripsi: menu.deskripsi,
                              foto: menu.foto,
                            ),
                          );
                        },
                        style: EvelatedButtonStyle.mainRounded.copyWith(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            MainColor.primary,
                          ),
                        ),
                        child: Text(
                          "Simpan",
                          style: GoogleTextStyle.fw700.copyWith(
                              fontSize: 16.sp, color: MainColor.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: const BottomNavigation(),
      ),
    );
  }
}
