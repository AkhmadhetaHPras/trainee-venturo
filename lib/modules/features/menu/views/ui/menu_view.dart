import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:trainee/configs/themes/main_color.dart';
import 'package:trainee/modules/features/cart/views/components/quantity_counter.dart';
import 'package:trainee/modules/features/menu/views/components/level_section.dart';
import 'package:trainee/modules/features/menu/views/components/notes_section.dart';
import 'package:trainee/modules/features/menu/views/components/price_section.dart';
import 'package:trainee/modules/features/menu/views/components/topping_section.dart';
import 'package:trainee/modules/global_controllers/cart_controller.dart';
import 'package:trainee/modules/global_models/menu_cart.dart';
import 'package:trainee/shared/customs/bottom_navigation.dart';
import 'package:trainee/shared/customs/custom_app_bar.dart';
import 'package:trainee/shared/styles/google_text_style.dart';

import '../../../../../shared/styles/elevated_button_style.dart';
import '../../controllers/detail_menu_controller.dart';
import '../components/menu_image.dart';

class MenuView extends StatelessWidget {
  const MenuView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.grey[100],
        appBar: const CustomAppBar(icon: Icons.menu_book, title: "Detail Menu"),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(
              () => MenuImage(
                image: DetailMenuController.to.menu.value.foto,
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
                              DetailMenuController.to.menu.value.nama ??
                                  "Nama Menu",
                              style: GoogleTextStyle.fw700.copyWith(
                                fontSize: 20.sp,
                                color: MainColor.primary,
                              ),
                            ),
                          ),
                          const Expanded(child: SizedBox()),
                          Obx(
                            () => QuantityCounter(
                              quantity: DetailMenuController.to.quantity.value,
                              onIncrement: () {
                                DetailMenuController.to.addQty();
                              },
                              onDecrement: () {
                                DetailMenuController.to.minQty();
                              },
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      Obx(
                        () => Text(
                          DetailMenuController.to.menu.value.deskripsi ?? "",
                          style: GoogleTextStyle.fw400.copyWith(
                            fontSize: 12.sp,
                            color: MainColor.dark,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Padding(
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
                            LevelSection(),
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
                        onPressed: () async {
                          await CartController.to.addToCart(
                            MenuCart(
                              idMenu:
                                  DetailMenuController.to.menu.value.idMenu!,
                              nama: DetailMenuController.to.menu.value.nama!,
                              harga: DetailMenuController.to.menu.value.harga!,
                              deskripsi:
                                  DetailMenuController.to.menu.value.deskripsi,
                              foto: DetailMenuController.to.menu.value.foto ??
                                  "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/240px-No_image_available.svg.png",
                              level: DetailMenuController
                                      .to.selectedLevel.value?.idDetail ??
                                  0,
                              topping: [
                                DetailMenuController
                                        .to.selectedTopping.value?.idDetail ??
                                    0
                              ],
                              jumlah: DetailMenuController.to.quantity.value,
                              catatan:
                                  DetailMenuController.to.catatan.value.isEmpty
                                      ? null
                                      : DetailMenuController.to.catatan.value,
                              kategori:
                                  DetailMenuController.to.menu.value.kategori!,
                            ),
                          );
                        },
                        style: EvelatedButtonStyle.mainRounded.copyWith(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            MainColor.primary,
                          ),
                        ),
                        child: Text(
                          "Tambahkan Ke Pesanan",
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
