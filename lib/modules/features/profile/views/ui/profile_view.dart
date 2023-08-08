import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:trainee/constants/cores/assets/image_constant.dart';
import 'package:trainee/shared/customs/bottom_navigation.dart';
import 'package:trainee/shared/customs/custom_app_bar.dart';
import 'package:trainee/shared/styles/google_text_style.dart';

import '../../../../../configs/themes/main_color.dart';
import '../../../../../shared/styles/elevated_button_style.dart';
import '../../controllers/profile_controller.dart';
import '../components/tile_option.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Profile",
        titleStyle: GoogleTextStyle.fw600
            .copyWith(color: MainColor.primary, fontSize: 20.sp),
        titleWidget: Container(
          height: 3.h,
          width: 65,
          color: MainColor.primary,
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(ImageConstant.bgBlank),
              fit: BoxFit.fitHeight,
              alignment: Alignment.center),
        ),
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 25.r),
          children: [
            /// Profile Icon
            Center(
              child: Container(
                width: 170.r,
                height: 170.r,
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(shape: BoxShape.circle),
                child: Stack(
                  children: [
                    Obx(
                      () => Conditional.single(
                        context: context,
                        conditionBuilder: (context) =>
                            ProfileController.to.imageFile != null,
                        widgetBuilder: (context) => Image.file(
                          ProfileController.to.imageFile!,
                          width: 170.r,
                          height: 170.r,
                          fit: BoxFit.cover,
                        ),
                        fallbackBuilder: (context) => Image.asset(
                          ImageConstant.bgProfile,
                          width: 170.r,
                          height: 170.r,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Material(
                        color: MainColor.primary,
                        child: InkWell(
                          onTap: ProfileController.to.pickImage,
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.only(top: 10.r, bottom: 15.r),
                            child: Text(
                              "Change".tr,
                              style: Get.textTheme.labelMedium!
                                  .copyWith(color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            21.verticalSpacingRadius,
            // Info KTP
            Obx(
              () => Conditional.single(
                context: context,
                conditionBuilder: (context) =>
                    ProfileController.to.isVerif.value != false,
                widgetBuilder: (context) => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.check,
                      color: Colors.green,
                      size: 20.r,
                    ),
                    7.horizontalSpaceRadius,
                    Text(
                      ' Your have verified your ID card'.tr,
                      style: Get.textTheme.labelMedium!
                          .copyWith(color: MainColor.primary),
                    )
                  ],
                ),
                fallbackBuilder: (context) => InkWell(
                  onTap: ProfileController.to.pickFile,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        ImageConstant.icKtp,
                      ),
                      7.horizontalSpaceRadius,
                      Text(
                        'Verify your ID card now!'.tr,
                        style: Get.textTheme.labelMedium!
                            .copyWith(color: MainColor.primary),
                      )
                    ],
                  ),
                ),
              ),
            ),

            22.verticalSpacingRadius,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20.w),
                    child: Text(
                      'Info Akun'.tr,
                      style: GoogleTextStyle.fw600
                          .copyWith(color: MainColor.primary, fontSize: 20.sp),
                    ),
                  ),
                  14.verticalSpacingRadius,
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.r),
                      color: Colors.grey[100],
                    ),
                    child: Column(
                      children: [
                        Obx(
                          () => TileOption(
                            title: 'Nama'.tr,
                            message:
                                ProfileController.to.user.value.nama ?? '-',
                            onTap: () {
                              ProfileController.to.updateProfileName();
                            },
                          ),
                        ),
                        Divider(color: Colors.black45, height: 0.5.h),
                        Obx(
                          () => TileOption(
                            title: 'Tanggal Lahir'.tr,
                            message:
                                ProfileController.to.user.value.tglLahir ?? '-',
                            onTap: () {
                              ProfileController.to.updateBirthDate();
                            },
                          ),
                        ),
                        Divider(color: Colors.black45, height: 0.5.h),
                        Obx(
                          () => TileOption(
                            title: 'No. Telepon'.tr,
                            message:
                                ProfileController.to.user.value.telepon ?? '-',
                            onTap: () {
                              ProfileController.to.updatePhoneNumber();
                            },
                          ),
                        ),
                        Divider(color: Colors.black45, height: 0.5.h),
                        Obx(
                          () => TileOption(
                            title: 'Email'.tr,
                            message:
                                ProfileController.to.user.value.email ?? '-',
                            onTap: () {
                              ProfileController.to.updateEmail();
                            },
                          ),
                        ),
                        Divider(color: Colors.black45, height: 0.5.h),
                        Obx(
                          () => TileOption(
                            title: 'Ubah PIN'.tr,
                            message: ProfileController.to.user.value.pin ?? "-",
                            onTap: () {},
                          ),
                        ),
                        Divider(color: Colors.black45, height: 0.5.h),
                        Obx(
                          () => TileOption(
                            title: 'Ganti Bahasa'.tr,
                            message: ProfileController.to.currentLang.value,
                            onTap: ProfileController.to.updateLanguage,
                          ),
                        ),
                      ],
                    ),
                  ),
                  14.verticalSpacingRadius,
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 6.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.r),
                      color: Colors.grey[100],
                    ),
                    child: Column(
                      children: [
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {},
                            child: Row(
                              children: [
                                // Icon
                                SvgPicture.asset(
                                  ImageConstant.icRating,
                                  height: 20.h,
                                  width: 20.w,
                                ),
                                9.horizontalSpaceRadius,
                                // title text
                                Text(
                                  "Penilaian",
                                  style: GoogleTextStyle.fw600.copyWith(
                                    fontSize: 16.sp,
                                  ),
                                ),
                                40.horizontalSpaceRadius,
                                Expanded(
                                    child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {},
                                      style: EvelatedButtonStyle.mainRounded
                                          .copyWith(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                          MainColor.primary,
                                        ),
                                        shape: MaterialStateProperty.all<
                                            OutlinedBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(144.r),
                                            side: const BorderSide(
                                              color: Colors
                                                  .white, // White color for the border
                                            ),
                                          ),
                                        ),
                                        minimumSize:
                                            MaterialStateProperty.all<Size>(
                                          const Size(double.infinity, 35),
                                        ),
                                      ),
                                      child: Text(
                                        "Nilai Sekarang",
                                        style: GoogleTextStyle.fw500.copyWith(
                                          fontSize: 14.sp,
                                          color: MainColor.white,
                                        ),
                                      ),
                                    )
                                  ],
                                )),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  27.verticalSpacingRadius,
                  Padding(
                    padding: EdgeInsets.only(left: 20.w),
                    child: Text(
                      'Info Lainnya'.tr,
                      style: GoogleTextStyle.fw600
                          .copyWith(color: MainColor.primary, fontSize: 20.sp),
                    ),
                  ),
                  14.verticalSpacingRadius,
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 25.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.r),
                      color: Colors.grey[100],
                    ),
                    child: Column(
                      children: [
                        TileOption(
                          title: 'Info Perangkat'.tr,
                          message: 'Iphone 15',
                          onTap: () {},
                        ),
                        Divider(color: Colors.black45, height: 0.5.h),
                        TileOption(
                          title: 'Versi'.tr,
                          message: 'Gear 5',
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavigation(),
    );
  }
}
