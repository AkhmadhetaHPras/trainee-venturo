import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:trainee/configs/themes/main_color.dart';
import 'package:trainee/modules/features/list/models/menu_response.dart';
import 'package:trainee/shared/styles/google_text_style.dart';

class MenuCard extends StatelessWidget {
  final MenuData menu;
  final bool isSelected;
  final void Function()? onTap;

  const MenuCard({
    Key? key,
    required this.menu,
    this.onTap,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10.r),
      child: Ink(
        padding: EdgeInsets.all(7.r),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: isSelected
                ? Theme.of(context).primaryColor
                : Colors.transparent,
            width: 2.w,
          ),
        ),
        child: Row(
          children: [
            // menu image
            Container(
              height: 90.h,
              width: 90.w,
              margin: EdgeInsets.only(right: 12.r),
              padding: EdgeInsets.all(5.r),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: Colors.grey[100],
              ),
              child: CachedNetworkImage(
                imageUrl: menu.foto ??
                    'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/240px-No_image_available.svg.png',
                useOldImageOnUrlChange: true,
                fit: BoxFit.contain,
                errorWidget: (context, url, error) => Image.network(
                  'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/240px-No_image_available.svg.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),

            // menu info
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    menu.nama!,
                    style: Get.textTheme.titleMedium,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  Text(
                    "Rp. ${menu.harga}".tr,
                    style: Get.textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(Icons.edit_note),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        'Add Notes'.tr,
                        style: GoogleTextStyle.fw500
                            .copyWith(fontSize: 12.sp, color: MainColor.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
