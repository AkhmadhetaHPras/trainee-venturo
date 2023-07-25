import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/detail_menu_controller.dart';
import '../../models/menu_response.dart';
import 'option_section.dart';

class ToppingSection extends StatelessWidget {
  const ToppingSection(
      {super.key, this.selectedValue, this.data, this.onOptionSelected});

  final Rx<Topping?>? selectedValue;
  final RxList<Topping>? data;
  final Function(Topping topping)? onOptionSelected;

  @override
  Widget build(BuildContext context) {
    return OptionSection<Topping>(
      icon: Icons.local_pizza_outlined,
      title: "Topping",
      selectedValue: selectedValue ?? DetailMenuController.to.selectedTopping,
      data: data ?? DetailMenuController.to.topping,
      onOptionSelected: onOptionSelected ??
          (topping) {
            DetailMenuController.to.selectedTopping(topping);
          },
    );
  }
}
