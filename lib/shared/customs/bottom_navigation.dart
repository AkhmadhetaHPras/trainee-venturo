import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:trainee/configs/routes/main_route.dart';
import 'package:trainee/configs/themes/main_color.dart';
import 'package:trainee/modules/global_controllers/bottom_navigation_controller.dart';
import 'package:trainee/shared/styles/google_text_style.dart';

class BottomNavigation extends StatelessWidget implements PreferredSizeWidget {
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 68.h,
      padding: EdgeInsets.symmetric(
        horizontal: 55.w,
      ),
      decoration: BoxDecoration(
        color: MainColor.dark,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30.r),
        ),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(111, 24, 24, 24),
            blurRadius: 15,
            spreadRadius: -1,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              BottomNavigationController.to.setActiveIndex(0);
              Get.offAllNamed(MainRoute.list);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Obx(
                  () => Icon(
                    Icons.home,
                    size: 34,
                    color: BottomNavigationController.to.activeIndex.value == 0
                        ? MainColor.white
                        : MainColor.grey,
                  ),
                ),
                Obx(
                  () => Text(
                    "Home",
                    style: GoogleTextStyle.fw700.copyWith(
                      color:
                          BottomNavigationController.to.activeIndex.value == 0
                              ? MainColor.white
                              : MainColor.grey,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              BottomNavigationController.to.setActiveIndex(1);
              Get.toNamed(MainRoute.order);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Obx(
                  () => Icon(
                    Icons.brunch_dining,
                    size: 34,
                    color: BottomNavigationController.to.activeIndex.value == 1
                        ? MainColor.white
                        : MainColor.grey,
                  ),
                ),
                Obx(
                  () => Text(
                    "Pesanan",
                    style: GoogleTextStyle.fw700.copyWith(
                      color:
                          BottomNavigationController.to.activeIndex.value == 1
                              ? MainColor.white
                              : MainColor.grey,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              BottomNavigationController.to.setActiveIndex(2);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Obx(
                  () => Icon(
                    Icons.account_circle_outlined,
                    size: 34,
                    color: BottomNavigationController.to.activeIndex.value == 2
                        ? MainColor.white
                        : MainColor.grey,
                  ),
                ),
                Obx(
                  () => Text(
                    "Profil",
                    style: GoogleTextStyle.fw700.copyWith(
                      color:
                          BottomNavigationController.to.activeIndex.value == 2
                              ? MainColor.white
                              : MainColor.grey,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
