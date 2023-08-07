import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MenuImage extends StatelessWidget {
  const MenuImage({
    super.key,
    this.image,
  });

  final String? image;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24),
        child: CachedNetworkImage(
          imageUrl: image ??
              "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/240px-No_image_available.svg.png",
          useOldImageOnUrlChange: true,
          height: 180,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
