import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/detail_menu_controller.dart';

class MenuImage extends StatelessWidget {
  const MenuImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24),
        child: Obx(
          () => CachedNetworkImage(
            imageUrl: DetailMenuController.to.menu.value.foto ??
                "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/240px-No_image_available.svg.png",
            useOldImageOnUrlChange: true,
            height: 180,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
