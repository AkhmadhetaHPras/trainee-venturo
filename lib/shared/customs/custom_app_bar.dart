import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:trainee/configs/themes/main_color.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.icon,
    required this.title,
    this.onBackButtonPressed,
    this.actions,
    this.titleWidget,
    this.enableBackButton,
    this.titleStyle,
  });

  final IconData? icon;
  final String title;
  final VoidCallback? onBackButtonPressed;
  final List<Widget>? actions;
  final Widget? titleWidget;
  final bool? enableBackButton;
  final TextStyle? titleStyle;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          if (icon != null)
            Icon(
              icon,
              size: 28.r,
              color: MainColor.primary,
            ),
          if (icon != null) 10.horizontalSpaceRadius,
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(title, style: titleStyle ?? Get.textTheme.titleMedium),
              if (titleWidget != null) 10.verticalSpace,
              if (titleWidget != null) titleWidget!,
            ],
          ),
        ],
      ),
      backgroundColor: Colors.white,
      elevation: 2,
      centerTitle: true,
      leading: enableBackButton == true
          ? IconButton(
              splashRadius: 30.r,
              icon: Icon(Icons.chevron_left, color: Colors.black, size: 36.r),
              onPressed:
                  onBackButtonPressed ?? () => Get.back(closeOverlays: true),
            )
          : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(30.r),
        ),
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
