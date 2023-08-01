import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:trainee/configs/themes/main_color.dart';
import 'package:trainee/modules/features/order/models/order_detail.dart';

import '../../../../../shared/styles/google_text_style.dart';
import '../../../cart/views/components/quantity_counter.dart';

class DetailOrderCard extends StatelessWidget {
  final Detail detailOrder;

  const DetailOrderCard(this.detailOrder, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ink(
      padding: EdgeInsets.all(7.r),
      decoration: BoxDecoration(
        color: MainColor.lightGrey,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: const [
          BoxShadow(
            color: Colors.black87,
            offset: Offset(0, 2),
            blurRadius: 8,
            spreadRadius: -1,
          ),
        ],
      ),
      child: Row(
        children: [
          /* Image */
          Container(
            height: 90.h,
            width: 90.w,
            margin: EdgeInsets.only(right: 12.w),
            padding: EdgeInsets.all(5.r),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: Colors.white,
            ),
            child: CachedNetworkImage(
              imageUrl: detailOrder.foto,
              fit: BoxFit.contain,
              errorWidget: (context, _, __) => CachedNetworkImage(
                imageUrl:
                    'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/240px-No_image_available.svg.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  detailOrder.nama,
                  style: Get.textTheme.titleMedium,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                Text(
                  'Rp ${detailOrder.harga}',
                  style: Get.textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(Icons.edit_note),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: Text(
                        detailOrder.catatan,
                        style: GoogleTextStyle.fw500.copyWith(
                          fontSize: 12.sp,
                          color: MainColor.dark,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            height: 75.r,
            padding: EdgeInsets.only(left: 12.w, right: 5.w),
            child: QuantityCounter(quantity: detailOrder.jumlah),
          ),
        ],
      ),
    );
  }
}
