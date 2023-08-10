import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:trainee/configs/routes/main_route.dart';
import 'package:trainee/modules/features/list/models/promo_response.dart';

class PromoCard extends StatelessWidget {
  const PromoCard({
    super.key,
    this.enableShadow,
    required this.promoName,
    required this.type,
    this.discountNominal,
    this.voucherNominal,
    required this.thumbnailUrl,
    this.width,
    required this.id,
    this.termCondition,
  });

  final int id;
  final String type;
  final String? termCondition;
  final bool? enableShadow;
  final String promoName;
  final int? discountNominal;
  final int? voucherNominal;
  final String thumbnailUrl;
  final double? width;

  @override
  Widget build(BuildContext context) {
    final discount = [
      Text.rich(
        softWrap: true,
        textAlign: TextAlign.center,
        TextSpan(
          text: 'Discount'.tr,
          style: Get.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
          children: [
            TextSpan(
              text: ' $discountNominal %',
              style: Get.textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.w800,
                foreground: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = 1
                  ..color = Colors.white,
              ),
            ),
          ],
        ),
      ),
      Text(
        promoName,
        textAlign: TextAlign.center,
        style: Get.textTheme.labelMedium?.copyWith(
          color: Colors.white,
        ),
      ),
    ];

    final voucher = [
      Text(
        'Voucher'.tr,
        style: Get.textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w800,
          color: Colors.white,
        ),
      ),
      Text(
        'Rp. $voucherNominal'.tr,
        style: Get.textTheme.displaySmall?.copyWith(
          fontWeight: FontWeight.w800,
          fontSize: 32.sp,
          foreground: Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1
            ..color = Colors.white,
        ),
      ),
      Text(
        promoName,
        textAlign: TextAlign.center,
        style: Get.textTheme.labelMedium?.copyWith(
          color: Colors.white,
        ),
      ),
    ];

    return InkWell(
      onTap: () {
        Get.toNamed(
          MainRoute.detailPromo,
          arguments: PromoData(
            idPromo: id,
            syaratKetentuan: termCondition,
            nama: promoName,
            type: type,
            diskon: discountNominal,
            nominal: voucherNominal,
            foto: thumbnailUrl,
          ),
        );
      },
      borderRadius: BorderRadius.circular(15.r),
      child: Container(
        width: width ?? 282.w,
        height: 188.h,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(15.r),
          image: DecorationImage(
              image: CachedNetworkImageProvider(
                thumbnailUrl,
              ),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Theme.of(context).primaryColor.withAlpha(150),
                BlendMode.srcATop,
              )),
          boxShadow: [
            if (enableShadow == true)
              const BoxShadow(
                color: Color.fromARGB(115, 71, 70, 70),
                offset: Offset(0, 2),
                blurRadius: 8,
              ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: type == "voucher" ? voucher : discount,
          ),
        ),
      ),
    );
  }
}
