import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trainee/modules/features/cart/controllers/edit_menu_cart_controller.dart';
import 'package:trainee/modules/features/menu/views/components/radio_section.dart';

import '../../controllers/detail_menu_controller.dart';
import '../../models/menu_response.dart';

class ToppingSection extends StatelessWidget {
  const ToppingSection(
      {super.key,
      this.selectedValue,
      this.data,
      this.onOptionSelected,
      this.fromCart = false});

  final RxList<Topping>? selectedValue;
  final RxList<Topping>? data;
  final Function(Topping topping)? onOptionSelected;
  final bool fromCart;

  @override
  Widget build(BuildContext context) {
    if (fromCart) {
      return RadioSection(
        icon: Icons.local_pizza_outlined,
        title: "Topping".tr,
        selectedValue: data == null
            ? EditMenuCartController.to.selectedTopping
            : (selectedValue == null ? <Topping>[].obs : selectedValue!),
        data: data ?? EditMenuCartController.to.topping,
        onOptionSelected: onOptionSelected ??
            (topping) {
              EditMenuCartController.to.addOrRemoveTopping(topping);
            },
        fromCart: true,
      );
    } else {
      return RadioSection(
        icon: Icons.local_pizza_outlined,
        title: "Topping".tr,
        selectedValue: data == null
            ? DetailMenuController.to.selectedTopping
            : (selectedValue == null ? <Topping>[].obs : selectedValue!),
        data: data ?? DetailMenuController.to.topping,
        onOptionSelected: onOptionSelected ??
            (topping) {
              DetailMenuController.to.addOrRemoveTopping(topping);
            },
      );
    }
  }
}
