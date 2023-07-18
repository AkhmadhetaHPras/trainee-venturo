import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trainee/configs/themes/main_color.dart';
import 'package:trainee/modules/features/menu/views/components/detail_menu_app_bar.dart';
import 'package:trainee/shared/customs/bottom_navigation.dart';
import 'package:trainee/shared/styles/google_text_style.dart';

import '../../../../../shared/styles/elevated_button_style.dart';

class MenuView extends StatelessWidget {
  const MenuView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: const DetailMenuAppBar(),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24),
                child: CachedNetworkImage(
                  imageUrl:
                      'https://cdn0-production-images-kly.akamaized.net/nCnoX1vVAzsRn12Ibj9oGoNPYU4=/0x0:1000x563/1200x675/filters:quality(75):strip_icc():format(jpeg)/kly-media-production/medias/4412036/original/071886300_1683000407-shutterstock_2135077751.jpg',
                  useOldImageOnUrlChange: true,
                  height: 180,
                  fit: BoxFit.contain,
                ),
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
                    children: [
                      Row(
                        children: [
                          Text(
                            "Chicken Katsu",
                            style: GoogleTextStyle.fw700.copyWith(
                              fontSize: 20.sp,
                              color: MainColor.primary,
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
                      Text(
                        "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                        style: GoogleTextStyle.fw400.copyWith(
                          fontSize: 12.sp,
                          color: MainColor.dark,
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
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Icon(Icons.money),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    "Harga",
                                    style: GoogleTextStyle.fw600.copyWith(
                                        fontSize: 16, color: MainColor.dark),
                                  ),
                                  const Expanded(
                                    child: SizedBox(),
                                  ),
                                  Text(
                                    "Rp. 10.000",
                                    style: GoogleTextStyle.fw700.copyWith(
                                        fontSize: 18, color: MainColor.primary),
                                  )
                                ],
                              ),
                            ),
                            const Divider(
                              color: MainColor.dark,
                              height: 1.5,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Icon(Icons.local_fire_department),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    "Level",
                                    style: GoogleTextStyle.fw600.copyWith(
                                        fontSize: 16, color: MainColor.dark),
                                  ),
                                  const Expanded(
                                    child: SizedBox(),
                                  ),
                                  Text(
                                    "1",
                                    style: GoogleTextStyle.fw400.copyWith(
                                        fontSize: 18, color: MainColor.dark),
                                  ),
                                  const Icon(
                                    Icons.keyboard_arrow_right,
                                    color: MainColor.grey,
                                  ),
                                ],
                              ),
                            ),
                            const Divider(
                              color: MainColor.dark,
                              height: 1.5,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Icon(Icons.local_pizza_outlined),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    "Toping",
                                    style: GoogleTextStyle.fw600.copyWith(
                                        fontSize: 16, color: MainColor.dark),
                                  ),
                                  const Expanded(
                                    child: SizedBox(),
                                  ),
                                  Text(
                                    "Mozarella",
                                    style: GoogleTextStyle.fw400.copyWith(
                                        fontSize: 18, color: MainColor.dark),
                                  ),
                                  const Icon(
                                    Icons.keyboard_arrow_right,
                                    color: MainColor.grey,
                                  ),
                                ],
                              ),
                            ),
                            const Divider(
                              color: MainColor.dark,
                              height: 1.5,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Icon(Icons.edit_note),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    "Catatan",
                                    style: GoogleTextStyle.fw600.copyWith(
                                        fontSize: 16, color: MainColor.dark),
                                  ),
                                  const Expanded(
                                    child: SizedBox(),
                                  ),
                                  SizedBox(
                                    width: 150,
                                    child: Text(
                                      "lorem ipsum dolor sit you dan",
                                      style: GoogleTextStyle.fw400.copyWith(
                                        fontSize: 18,
                                        color: MainColor.dark,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const Icon(
                                    Icons.keyboard_arrow_right,
                                    color: MainColor.grey,
                                  ),
                                ],
                              ),
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
