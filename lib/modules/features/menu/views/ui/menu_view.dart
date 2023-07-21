import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:trainee/configs/themes/main_color.dart';
import 'package:trainee/modules/features/menu/views/components/level_section.dart';
import 'package:trainee/modules/features/menu/views/components/notes_section.dart';
import 'package:trainee/modules/features/menu/views/components/price_section.dart';
import 'package:trainee/modules/features/menu/views/components/topping_section.dart';
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
            const MenuImage(),
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
                          Material(
                            color: Colors.transparent,
                            child: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                  Icons.indeterminate_check_box_outlined),
                            ),
                          ),
                          const Text("1"),
                          Material(
                            color: Colors.transparent,
                            child: IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.add_box_outlined),
                            ),
                          ),
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
                        onPressed: () {},
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
