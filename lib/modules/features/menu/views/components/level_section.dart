import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/detail_menu_controller.dart';
import '../../models/menu_response.dart';
import 'option_section.dart';

class LevelSection extends StatelessWidget {
  const LevelSection(
      {super.key, this.selectedValue, this.data, this.onOptionSelected});

  final Rx<Level?>? selectedValue;
  final RxList<Level>? data;
  final Function(Level level)? onOptionSelected;

  @override
  Widget build(BuildContext context) {
    return OptionSection<Level>(
      icon: Icons.local_fire_department,
      title: "Level",
      selectedValue: data == null
          ? DetailMenuController.to.selectedLevel
          : (selectedValue == null ? Level().obs : selectedValue!),
      data: data ?? DetailMenuController.to.level,
      onOptionSelected: onOptionSelected ??
          (level) {
            DetailMenuController.to.selectedLevel(level);
          },
    );
  }
}
