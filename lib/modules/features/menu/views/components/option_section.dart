import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../configs/themes/main_color.dart';
import '../../../../../shared/styles/google_text_style.dart';
import '../../models/menu_response.dart';
import 'option_chip.dart';

class OptionSection<T extends CommonModel> extends StatelessWidget {
  final IconData icon;
  final String title;
  final Rx<T?> selectedValue;
  final List<T> data;
  final void Function(T)? onOptionSelected;

  const OptionSection({
    super.key,
    required this.icon,
    required this.title,
    required this.selectedValue,
    required this.data,
    required this.onOptionSelected,
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
                              "Choose $title",
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
                                            isSelected:
                                                selectedValue.value?.idDetail ==
                                                    datas.idDetail,
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
                    "Sorry".tr,
                    "No option available for ".tr + title.toLowerCase(),
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
              Obx(
                () => Text(
                  selectedValue.value?.keterangan ?? "-",
                  style: GoogleTextStyle.fw400
                      .copyWith(fontSize: 18, color: MainColor.dark),
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
