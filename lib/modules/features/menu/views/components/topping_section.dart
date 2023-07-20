import 'package:flutter/material.dart';

import '../../controllers/detail_menu_controller.dart';
import '../../models/menu_response.dart';
import 'option_section.dart';

class ToppingSection extends StatelessWidget {
  const ToppingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return OptionSection<Topping>(
      icon: Icons.local_pizza_outlined,
      title: "Topping",
      selectedValue: DetailMenuController.to.selectedTopping,
      data: DetailMenuController.to.topping,
      onOptionSelected: (topping) {
        DetailMenuController.to.selectedTopping(topping);
      },
    );
  }
}
