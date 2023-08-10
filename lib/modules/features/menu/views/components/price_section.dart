import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../configs/themes/main_color.dart';
import '../../../../../shared/styles/google_text_style.dart';
import '../../controllers/detail_menu_controller.dart';

class PriceSection extends StatelessWidget {
  PriceSection({super.key, this.harga});

  final int? harga;

  Widget textPriceWidget(String text) => Text(
        "Rp. $text".tr,
        style: GoogleTextStyle.fw700
            .copyWith(fontSize: 18, color: MainColor.primary),
      );

  final Widget obxPriceWidget = Obx(
    () => Text(
      "Rp. ${DetailMenuController.to.menu.value.harga}".tr,
      style: GoogleTextStyle.fw700
          .copyWith(fontSize: 18, color: MainColor.primary),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(Icons.money),
          const SizedBox(
            width: 8,
          ),
          Text(
            "Price".tr,
            style: GoogleTextStyle.fw600
                .copyWith(fontSize: 16, color: MainColor.dark),
          ),
          const Expanded(
            child: SizedBox(),
          ),
          harga == null ? obxPriceWidget : textPriceWidget(harga.toString())
        ],
      ),
    );
  }
}
