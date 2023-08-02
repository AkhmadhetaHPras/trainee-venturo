import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:flutter_conditional_rendering/conditional_switch.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:trainee/configs/themes/main_color.dart';
import 'package:trainee/modules/features/order/models/order.dart';
import 'package:trainee/modules/features/order/views/components/primary_button_with_title.dart';
import 'package:trainee/shared/styles/google_text_style.dart';

import 'outlined_title_button.dart';

class OrderItemCard extends StatelessWidget {
  const OrderItemCard({
    super.key,
    required this.order,
    this.onTap,
    this.onOrderAgain,
    this.onGiveReview,
  });

  final Order order;
  final VoidCallback? onTap;
  final VoidCallback? onOrderAgain;
  final ValueChanged<int>? onGiveReview;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10.r),
      child: Ink(
        padding: EdgeInsets.all(7.r),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: const [
            BoxShadow(
              offset: Offset(0, 2),
              blurRadius: 8,
              spreadRadius: -1,
              color: Colors.black87,
            ),
          ],
        ),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Flexible(
                flex: 3,
                child: Hero(
                  tag: 'order-${order.idOrder}',
                  child: Container(
                    width: 124.w,
                    constraints: BoxConstraints(
                      minHeight: 124.h,
                      maxWidth: 124.w,
                    ),
                    padding: EdgeInsets.all(10.r),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: Colors.grey[300],
                    ),
                    child: CachedNetworkImage(
                      imageUrl: order.menu.isNotEmpty
                          ? order.menu.first.foto
                          : 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/240px-No_image_available.svg.png',
                      fit: BoxFit.contain,
                      height: 75.h,
                      width: 75.w,
                      errorWidget: (context, _, __) => CachedNetworkImage(
                        imageUrl:
                            'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/240px-No_image_available.svg.png',
                        fit: BoxFit.contain,
                        height: 75.h,
                        width: 75.w,
                      ),
                    ),
                  ),
                ),
              ),
              12.horizontalSpace,
              Flexible(
                flex: 8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    5.verticalSpace,

                    // order status
                    Row(
                      children: [
                        if (order.status == 0)
                          Icon(
                            Icons.access_time,
                            color: MainColor.yellow,
                            size: 16.r,
                          ),
                        if (order.status == 1)
                          Icon(
                            Icons.access_time,
                            color: MainColor.yellow,
                            size: 16.r,
                          ),
                        if (order.status == 2)
                          Icon(
                            Icons.access_time,
                            color: MainColor.yellow,
                            size: 16.r,
                          ),
                        if (order.status == 3)
                          Icon(
                            Icons.check,
                            color: MainColor.green,
                            size: 16.r,
                          ),
                        if (order.status == 4)
                          Icon(
                            Icons.close,
                            color: MainColor.danger,
                            size: 16.r,
                          ),
                        5.horizontalSpaceRadius,
                        Expanded(
                          child: ConditionalSwitch.single<int>(
                            context: context,
                            valueBuilder: (context) => order.status,
                            caseBuilders: {
                              0: (context) => Text(
                                    'Dalam antrian'.tr,
                                    style: GoogleTextStyle.fw500.copyWith(
                                        color: MainColor.yellow,
                                        fontSize: 12.sp),
                                  ),
                              1: (context) => Text(
                                    'Sedang disiapkan'.tr,
                                    style: GoogleTextStyle.fw500.copyWith(
                                        color: MainColor.yellow,
                                        fontSize: 12.sp),
                                  ),
                              2: (context) => Text(
                                    'Siap'.tr,
                                    style: GoogleTextStyle.fw500.copyWith(
                                        color: MainColor.yellow,
                                        fontSize: 12.sp),
                                  ),
                              3: (context) => Text(
                                    'Selesai'.tr,
                                    style: GoogleTextStyle.fw500.copyWith(
                                        color: MainColor.green,
                                        fontSize: 12.sp),
                                  ),
                              4: (context) => Text(
                                    'Dibatalkan'.tr,
                                    style: GoogleTextStyle.fw500.copyWith(
                                        color: MainColor.danger,
                                        fontSize: 12.sp),
                                  ),
                            },
                            fallbackBuilder: (context) => const SizedBox(),
                          ),
                        ),
                        Text(
                          DateFormat(
                            'dd MMMM yyyy',
                            Get.locale?.countryCode,
                          ).format(DateTime.parse(order.tanggal)),
                          style: GoogleTextStyle.fw500
                              .copyWith(color: MainColor.grey, fontSize: 12.sp),
                        ),
                      ],
                    ),
                    14.verticalSpace,

                    // Menu title
                    Text(
                      order.menu.map((e) => e.nama).join(', '),
                      style: GoogleTextStyle.fw500.copyWith(
                        fontSize: 18.sp,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                    ),
                    5.verticalSpace,

                    // Price
                    Row(
                      children: [
                        Text(
                          'Rp ${order.totalBayar}',
                          style: GoogleTextStyle.fw500.copyWith(
                            fontSize: 14.sp,
                            color: MainColor.primary,
                          ),
                        ),
                        5.horizontalSpace,
                        Text(
                          '(${order.menu.length} Menu)',
                          style: GoogleTextStyle.fw500
                              .copyWith(color: MainColor.grey),
                        ),
                      ],
                    ),

                    // Action Button
                    Conditional.single(
                      context: context,
                      conditionBuilder: (context) =>
                          order.status == 3 || order.status == 4,
                      widgetBuilder: (context) => Wrap(
                        spacing: 15.r,
                        children: [
                          if (order.status == 3)
                            Padding(
                              padding: EdgeInsets.only(top: 10.r, bottom: 5.r),
                              child: OutlinedTitleButton.compact(
                                text: 'Give review'.tr,
                                onPressed: () =>
                                    onGiveReview?.call(order.idOrder),
                              ),
                            ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 10.r,
                                bottom: 5.r,
                                right: order.status == 3 ? 0.r : 0.3.sw),
                            child: PrimaryButtonWithTitle.compact(
                              title: 'Order again'.tr,
                              onPressed: onOrderAgain,
                            ),
                          ),
                        ],
                      ),
                      fallbackBuilder: (context) => const SizedBox(),
                    ),
                  ],
                ),
              ),
              5.horizontalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
