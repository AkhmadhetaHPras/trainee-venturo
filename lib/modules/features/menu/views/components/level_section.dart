import 'package:flutter/material.dart';

import '../../controllers/detail_menu_controller.dart';
import '../../models/menu_response.dart';
import 'option_section.dart';

class LevelSection extends StatelessWidget {
  const LevelSection({super.key});

  @override
  Widget build(BuildContext context) {
    return OptionSection<Level>(
      icon: Icons.local_fire_department,
      title: "Level",
      selectedValue: DetailMenuController.to.selectedLevel,
      data: DetailMenuController.to.level,
      onOptionSelected: (level) {
        DetailMenuController.to.selectedLevel(level);
      },
    );
  }
}
