import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:trainee/modules/features/cart/controllers/edit_menu_cart_controller.dart';
import 'package:trainee/modules/features/menu/controllers/detail_menu_controller.dart';
import 'package:trainee/modules/features/menu/models/menu_response.dart';

import '../../../../../configs/themes/main_color.dart';
import '../../../../../shared/styles/google_text_style.dart';
import 'option_chip.dart';

class RadioSection extends StatelessWidget {
  final IconData icon;
  final String title;
  final RxList<Topping> selectedValue;
  final List<Topping> data;
  final void Function(Topping)? onOptionSelected;
  final bool fromCart;

  const RadioSection({
    super.key,
    required this.icon,
    required this.title,
    required this.selectedValue,
    required this.data,
    required this.onOptionSelected,
    this.fromCart = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Obx(
        () => InkWell(
          onTap: data.isNotEmpty
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
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(30.r),
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Text(
                              "Pilih $title",
                              style: GoogleTextStyle.fw700.copyWith(
                                fontSize: 18.sp,
                                color: MainColor.dark,
                              ),
                            ),
                          ),
                          SizedBox(
                              width: 1.sw,
                              height: 25,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: data.length,
                                  itemBuilder: (context, index) {
                                    final datas = data[index];
                                    return Material(
                                      color: Colors.transparent,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
                                        child: Obx(
                                          () => OptionChip(
                                            isSelected: fromCart
                                                ? EditMenuCartController.to
                                                    .isToppingInSelectedList(
                                                        datas.idDetail!)
                                                : DetailMenuController.to
                                                    .isToppingInSelectedList(
                                                        datas.idDetail!),
                                            text: datas.keterangan!,
                                            onTap: () {
                                              onOptionSelected!(datas);
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
              : () {
                  Get.snackbar(
                    "Maaf",
                    "Tidak tersedia pilihan ${title.toLowerCase()}",
                    duration: const Duration(milliseconds: 1500),
                    backgroundColor: MainColor.white,
                    snackPosition: SnackPosition.BOTTOM,
                  );
                },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon),
              const SizedBox(
                width: 8,
              ),
              Text(
                title,
                style: GoogleTextStyle.fw600
                    .copyWith(fontSize: 16, color: MainColor.dark),
              ),
              const Expanded(
                child: SizedBox(),
              ),
              SizedBox(
                width: 150,
                child: Obx(
                  () => Text(
                    selectedValue.isEmpty
                        ? "-"
                        : selectedValue.displayWithCommaDelimiter(),
                    style: GoogleTextStyle.fw400
                        .copyWith(fontSize: 18, color: MainColor.dark),
                    textAlign: TextAlign.end,
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
    );
  }
}
