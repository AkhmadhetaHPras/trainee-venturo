import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:trainee/configs/routes/main_route.dart';
import 'package:trainee/configs/themes/main_color.dart';
import 'package:trainee/modules/global_controllers/cart_controller.dart';
import 'package:trainee/shared/customs/custom_app_bar.dart';
import 'package:trainee/shared/styles/google_text_style.dart';

import '../../../../../shared/styles/elevated_button_style.dart';
import '../../../../global_models/voucher.dart';
import '../components/date_period.dart';

class DetailVoucher extends StatelessWidget {
  const DetailVoucher({super.key});

  @override
  Widget build(BuildContext context) {
    final VoucherData voucher = Get.arguments['data'];
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: CustomAppBar(
          title: "Detail Voucher",
          titleStyle: GoogleTextStyle.fw500.copyWith(
            fontSize: 20.sp,
            color: MainColor.black,
          ),
          enableBackButton: true,
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24),
                child: Container(
                  width: double.infinity,
                  height: 180,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.r),
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(voucher.infoVoucher ??
                          "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/240px-No_image_available.svg.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: 30.w,
                  vertical: 25.h,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(30.r),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        voucher.nama!,
                        style: GoogleTextStyle.fw700.copyWith(
                          fontSize: 20.sp,
                          color: MainColor.primary,
                        ),
                      ),
                      Text(
                        voucher.catatan ?? "",
                        style: GoogleTextStyle.fw400.copyWith(
                          fontSize: 12,
                          color: MainColor.dark,
                        ),
                      ),
                      const Divider(
                        color: MainColor.dark,
                        height: 1.5,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.calendar_month,
                            size: 30,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: 110,
                            child: Text(
                              "Expired Date",
                              style: GoogleTextStyle.fw600.copyWith(
                                fontSize: 18.sp,
                                color: MainColor.dark,
                              ),
                              overflow: TextOverflow.fade,
                            ),
                          ),
                          const Expanded(child: SizedBox()),
                          DatePeriod(
                            periodeMulai: voucher.periodeMulai!,
                            periodeSelesai: voucher.periodeSelesai!,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
            color: MainColor.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(25.r),
            ),
            boxShadow: const [
              BoxShadow(
                color: MainColor.dark,
                blurRadius: 15,
                spreadRadius: -1,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: ElevatedButton(
            onPressed: () {
              CartController.to.selectedVoucher(voucher);
              Get.offAndToNamed(MainRoute.cart);
            },
            style: EvelatedButtonStyle.mainRounded.copyWith(
              backgroundColor: MaterialStateProperty.all<Color>(
                MainColor.primary,
              ),
            ),
            child: Text(
              "Choose Voucher",
              style: GoogleTextStyle.fw700
                  .copyWith(fontSize: 16.sp, color: MainColor.white),
            ),
          ),
        ),
      ),
    );
  }
}
