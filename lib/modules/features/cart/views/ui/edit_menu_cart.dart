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
        appBar: CustomAppBar(
          title: "Edit Menu",
          titleStyle: GoogleTextStyle.fw500
              .copyWith(fontSize: 20.sp, color: MainColor.black),
          enableBackButton: true,
        ),
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
                                      kategori: menu.kategori),
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
                                      kategori: menu.kategori),
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
                                  .deskripsi ??
                              "",
                          style: GoogleTextStyle.fw400.copyWith(
                            fontSize: 12.sp,
                            color: MainColor.dark,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 40),
                        child: Column(
                          children: [
                            const Divider(
                              color: MainColor.dark,
                              height: 1.5,
                            ),
                            PriceSection(
                              harga: CartController
                                  .to
                                  .cartItems[
                                      EditMenuCartController.to.index.value]
                                  .harga,
                            ),
                            const Divider(
                              color: MainColor.dark,
                              height: 1.5,
                            ),
                            Obx(
                              () => LevelSection(
                                selectedValue: EditMenuCartController
                                            .to.selectedLevel.value?.idDetail !=
                                        null
                                    ? EditMenuCartController.to.selectedLevel
                                    : null,
                                data: EditMenuCartController.to.level,
                                onOptionSelected: (level) {
                                  EditMenuCartController.to
                                      .selectedLevel(level);
                                },
                              ),
                            ),
                            const Divider(
                              color: MainColor.dark,
                              height: 1.5,
                            ),
                            Obx(
                              () => ToppingSection(
                                selectedValue: EditMenuCartController
                                        .to.selectedTopping.isNotEmpty
                                    ? EditMenuCartController.to.selectedTopping
                                    : null,
                                data: EditMenuCartController.to.topping,
                                onOptionSelected: (topping) {
                                  EditMenuCartController.to
                                      .addOrRemoveTopping(topping);
                                },
                                fromCart: true,
                              ),
                            ),
                            const Divider(
                              color: MainColor.dark,
                              height: 1.5,
                            ),
                            const NotesSection(
                              edit: true,
                            ),
                            const Divider(
                              color: MainColor.dark,
                              height: 1.5,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
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
              final menu = CartController
                  .to.cartItems[EditMenuCartController.to.index.value];
              CartController.to.updateCartItem(
                EditMenuCartController.to.index.value,
                MenuCart(
                    idMenu: menu.idMenu,
                    harga: menu.harga,
                    level: EditMenuCartController
                            .to.selectedLevel.value?.idDetail ??
                        menu.level,
                    topping:
                        EditMenuCartController.to.selectedTopping.isNotEmpty
                            ? menu.topping
                            : [],
                    jumlah: menu.jumlah,
                    nama: menu.nama,
                    catatan: EditMenuCartController.to.catatan.value,
                    deskripsi: menu.deskripsi,
                    foto: menu.foto,
                    kategori: menu.kategori),
              );

              Get.back();
            },
            style: EvelatedButtonStyle.mainRounded.copyWith(
              backgroundColor: MaterialStateProperty.all<Color>(
                MainColor.primary,
              ),
            ),
            child: Text(
              "Save",
              style: GoogleTextStyle.fw700
                  .copyWith(fontSize: 16.sp, color: MainColor.white),
            ),
          ),
        ),
      ),
    );
  }
}
