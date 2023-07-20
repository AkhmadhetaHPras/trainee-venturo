import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:trainee/configs/themes/main_color.dart';
import 'package:trainee/modules/features/list/views/components/menu_chip.dart';
import 'package:trainee/modules/features/menu/views/components/detail_menu_app_bar.dart';
import 'package:trainee/modules/features/menu/views/components/option_chip.dart';
import 'package:trainee/shared/customs/bottom_navigation.dart';
import 'package:trainee/shared/customs/text_form_field_custom.dart';
import 'package:trainee/shared/styles/google_text_style.dart';

import '../../../../../shared/styles/elevated_button_style.dart';
import '../../controllers/detail_menu_controller.dart';

class MenuView extends StatelessWidget {
  const MenuView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.grey[100],
        appBar: const DetailMenuAppBar(),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24),
                child: Obx(
                  () => CachedNetworkImage(
                    imageUrl: DetailMenuController.to.menu.value.foto ??
                        "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/240px-No_image_available.svg.png",
                    useOldImageOnUrlChange: true,
                    height: 180,
                    fit: BoxFit.contain,
                  ),
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
                                  Obx(
                                    () => Text(
                                      "Rp. ${DetailMenuController.to.menu.value.harga ?? 0}",
                                      style: GoogleTextStyle.fw700.copyWith(
                                          fontSize: 18,
                                          color: MainColor.primary),
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
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: InkWell(
                                onTap: DetailMenuController
                                        .to.topping.isNotEmpty
                                    ? () => showModalBottomSheet(
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(30.0),
                                            ),
                                          ),
                                          context: context,
                                          builder: (context) => Container(
                                            width: 1.sw,
                                            height: 150,
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 25.w,
                                              vertical: 25.h,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.vertical(
                                                top: Radius.circular(30.r),
                                              ),
                                              boxShadow: const [
                                                BoxShadow(
                                                  color: Color.fromARGB(
                                                      111, 24, 24, 24),
                                                  blurRadius: 15,
                                                  spreadRadius: -1,
                                                  offset: Offset(0, 1),
                                                ),
                                              ],
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 10.0),
                                                  child: Text(
                                                    "Pilih Level",
                                                    style: GoogleTextStyle.fw700
                                                        .copyWith(
                                                      fontSize: 18.sp,
                                                      color: MainColor.dark,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                    width: 1.sw,
                                                    height: 25,
                                                    child: ListView.builder(
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        itemCount:
                                                            DetailMenuController
                                                                .to
                                                                .level
                                                                .length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          final level =
                                                              DetailMenuController
                                                                  .to
                                                                  .level[index];
                                                          return Material(
                                                            color: Colors
                                                                .transparent,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      right:
                                                                          8.0),
                                                              child: Obx(
                                                                () =>
                                                                    OptionChip(
                                                                  isSelected: DetailMenuController
                                                                          .to
                                                                          .selectedLevel
                                                                          .value
                                                                          ?.idDetail ==
                                                                      level
                                                                          .idDetail,
                                                                  text: level
                                                                      .keterangan!,
                                                                  onTap: () {
                                                                    DetailMenuController
                                                                        .to
                                                                        .selectedLevel(
                                                                            level);
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        })),
                                              ],
                                            ),
                                          ),
                                        )
                                    : () {},
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
                                    Obx(
                                      () => Text(
                                        DetailMenuController.to.selectedLevel
                                                .value?.keterangan ??
                                            "-",
                                        style: GoogleTextStyle.fw400.copyWith(
                                            fontSize: 18,
                                            color: MainColor.dark),
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
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: Obx(
                                () => InkWell(
                                  onTap:
                                      DetailMenuController.to.topping.isNotEmpty
                                          ? () => showModalBottomSheet(
                                                shape:
                                                    const RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.vertical(
                                                    top: Radius.circular(30.0),
                                                  ),
                                                ),
                                                context: context,
                                                builder: (context) => Container(
                                                  width: 1.sw,
                                                  height: 150,
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 25.w,
                                                    vertical: 25.h,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.vertical(
                                                      top:
                                                          Radius.circular(30.r),
                                                    ),
                                                    boxShadow: const [
                                                      BoxShadow(
                                                        color: Color.fromARGB(
                                                            111, 24, 24, 24),
                                                        blurRadius: 15,
                                                        spreadRadius: -1,
                                                        offset: Offset(0, 1),
                                                      ),
                                                    ],
                                                  ),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                bottom: 10.0),
                                                        child: Text(
                                                          "Pilih Toping",
                                                          style: GoogleTextStyle
                                                              .fw700
                                                              .copyWith(
                                                            fontSize: 18.sp,
                                                            color:
                                                                MainColor.dark,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                          width: 1.sw,
                                                          height: 25,
                                                          child:
                                                              ListView.builder(
                                                                  scrollDirection:
                                                                      Axis
                                                                          .horizontal,
                                                                  itemCount:
                                                                      DetailMenuController
                                                                          .to
                                                                          .topping
                                                                          .length,
                                                                  itemBuilder:
                                                                      (context,
                                                                          index) {
                                                                    final toping =
                                                                        DetailMenuController
                                                                            .to
                                                                            .topping[index];
                                                                    return Material(
                                                                      color: Colors
                                                                          .transparent,
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.only(right: 8.0),
                                                                        child:
                                                                            Obx(
                                                                          () =>
                                                                              OptionChip(
                                                                            isSelected:
                                                                                DetailMenuController.to.selectedTopping.value?.idDetail == toping.idDetail,
                                                                            text:
                                                                                toping.keterangan!,
                                                                            onTap:
                                                                                () {
                                                                              DetailMenuController.to.selectedTopping(toping);
                                                                            },
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    );
                                                                  })),
                                                    ],
                                                  ),
                                                ),
                                              )
                                          : () {},
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
                                            fontSize: 16,
                                            color: MainColor.dark),
                                      ),
                                      const Expanded(
                                        child: SizedBox(),
                                      ),
                                      Obx(
                                        () => Text(
                                          DetailMenuController
                                                  .to
                                                  .selectedTopping
                                                  .value
                                                  ?.keterangan ??
                                              "-",
                                          style: GoogleTextStyle.fw400.copyWith(
                                              fontSize: 18,
                                              color: MainColor.dark),
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
                            ),
                            const Divider(
                              color: MainColor.dark,
                              height: 1.5,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: InkWell(
                                onTap: () => showModalBottomSheet(
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(30.0),
                                    ),
                                  ),
                                  context: context,
                                  builder: (context) => Container(
                                    width: double.infinity,
                                    height: 150,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 25.w,
                                      vertical: 25.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(30.r),
                                      ),
                                      boxShadow: const [
                                        BoxShadow(
                                          color:
                                              Color.fromARGB(111, 24, 24, 24),
                                          blurRadius: 15,
                                          spreadRadius: -1,
                                          offset: Offset(0, 1),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Buat Catatan",
                                          style: GoogleTextStyle.fw700.copyWith(
                                            fontSize: 18.sp,
                                            color: MainColor.dark,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: TextFormFieldCustom(
                                                controller: DetailMenuController
                                                    .to.catatanTextController,
                                                keyboardType:
                                                    TextInputType.text,
                                                initialValue:
                                                    DetailMenuController
                                                        .to.catatan.value,
                                                hint: "Catatan",
                                              ),
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                                Navigator.pop(context);

                                                DetailMenuController
                                                        .to.catatan.value =
                                                    DetailMenuController
                                                        .to
                                                        .catatanTextController
                                                        .text;
                                              },
                                              style: ElevatedButton.styleFrom(
                                                fixedSize: const Size(24, 24),
                                                shape: const CircleBorder(),
                                                backgroundColor:
                                                    MainColor.primary,
                                              ),
                                              child: const Icon(
                                                Icons.check_rounded,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
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
                                      child: Obx(
                                        () => Text(
                                          DetailMenuController.to.catatan.value,
                                          style: GoogleTextStyle.fw400.copyWith(
                                            fontSize: 18,
                                            color: MainColor.dark,
                                          ),
                                          textAlign: TextAlign.end,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
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
