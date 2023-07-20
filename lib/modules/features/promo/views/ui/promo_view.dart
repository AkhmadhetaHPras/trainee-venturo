import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trainee/configs/themes/main_color.dart';
import 'package:trainee/modules/features/promo/controllers/detail_promo_controller.dart';
import 'package:trainee/modules/features/promo/views/components/detail_menu_app_bar.dart';
import 'package:trainee/modules/features/promo/views/components/discount_card.dart';
import 'package:trainee/modules/features/promo/views/components/voucher_card.dart';
import 'package:trainee/shared/styles/google_text_style.dart';

import '../../../../../shared/customs/bottom_navigation.dart';

class PromoView extends StatelessWidget {
  const PromoView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: const DetailPromoAppBar(),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24),
                child: DetailPromoController.to.promo.value.type! == "voucher"
                    ? VoucherCard(
                        nama: DetailPromoController.to.promo.value.nama!,
                        nominal: DetailPromoController.to.promo.value.nominal!,
                        thumbnail: DetailPromoController.to.promo.value.foto,
                      )
                    : DiscountCard(
                        nama: DetailPromoController.to.promo.value.nama!,
                        discount: DetailPromoController.to.promo.value.diskon!,
                        thumbnail: DetailPromoController.to.promo.value.foto,
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
                        "Nama Promo",
                        style: GoogleTextStyle.fw600.copyWith(
                          fontSize: 16.sp,
                          color: MainColor.dark,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Text(
                          DetailPromoController.to.promo.value.nama!,
                          style: GoogleTextStyle.fw700.copyWith(
                            fontSize: 20.sp,
                            color: MainColor.primary,
                          ),
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.list,
                            size: 30,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Syarat Dan Ketentuan",
                                  style: GoogleTextStyle.fw600.copyWith(
                                    fontSize: 16.sp,
                                    color: MainColor.dark,
                                  ),
                                ),
                                Html(
                                  data: DetailPromoController
                                      .to.promo.value.syaratKetentuan!,
                                  style: {
                                    "p": Style(
                                        fontSize: FontSize(12),
                                        margin: Margins.only(left: -8),
                                        fontWeight: FontWeight.w300,
                                        color: MainColor.dark,
                                        fontFamily: "Montserrat"),
                                  },
                                ),
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: const BottomNavigation(),
      ),
    );
  }
}
