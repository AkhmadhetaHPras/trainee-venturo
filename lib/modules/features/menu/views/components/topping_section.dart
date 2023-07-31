import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trainee/modules/features/menu/views/components/radio_section.dart';

import '../../controllers/detail_menu_controller.dart';
import '../../models/menu_response.dart';

class ToppingSection extends StatelessWidget {
  const ToppingSection(
      {super.key, this.selectedValue, this.data, this.onOptionSelected});

  final RxList<Topping>? selectedValue;
  final RxList<Topping>? data;
  final Function(Topping topping)? onOptionSelected;

  @override
  Widget build(BuildContext context) {
    return RadioSection(
      icon: Icons.local_pizza_outlined,
      title: "Topping",
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
