import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../configs/themes/main_color.dart';
import '../../../../../shared/styles/google_text_style.dart';
import '../../controllers/detail_menu_controller.dart';

class PriceSection extends StatelessWidget {
  const PriceSection({super.key});

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
            "Harga",
            style: GoogleTextStyle.fw600
                .copyWith(fontSize: 16, color: MainColor.dark),
          ),
          const Expanded(
            child: SizedBox(),
          ),
          Obx(
            () => Text(
              "Rp. ${DetailMenuController.to.menu.value.harga ?? 0}",
              style: GoogleTextStyle.fw700
                  .copyWith(fontSize: 18, color: MainColor.primary),
            ),
          )
        ],
      ),
    );
  }
}
