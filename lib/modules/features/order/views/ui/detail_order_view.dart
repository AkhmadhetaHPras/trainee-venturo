import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:flutter_conditional_rendering/conditional_switch.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:trainee/configs/themes/main_color.dart';
import 'package:trainee/shared/customs/custom_app_bar.dart';
import 'package:trainee/shared/styles/google_text_style.dart';

import '../../../cart/views/components/tile_option.dart';
import '../../../list/views/components/section_header.dart';
import '../../controllers/order_detail_controller.dart';
import '../components/order_list_sliver.dart';
import '../components/order_tracker.dart';

class DetailOrderView extends StatelessWidget {
  const DetailOrderView({super.key});
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  Widget build(BuildContext context) {
    analytics.setCurrentScreen(
      screenName: 'Detail Order Screen',
      screenClassOverride: 'Trainee',
    );

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Pesanan',
        titleStyle: GoogleTextStyle.fw700.copyWith(
          fontSize: 20.sp,
          color: MainColor.black,
        ),
        icon: Icons.shopping_bag_outlined,
        enableBackButton: true,
        onBackButtonPressed: () => Get.back(),
        actions: [
          Obx(
            () => Conditional.single(
              context: context,
              conditionBuilder: (context) =>
                  DetailOrderController.to.order.value?.order?.status == 0,
              widgetBuilder: (context) => Padding(
                padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 10.w),
                child: TextButton(
                  onPressed: () {
                    Get.dialog(
                      AlertDialog(
                        title: const Text('Konfirmasi'),
                        content: const Text(
                            'Apakah Anda yakin ingin membatalkan pesanan ini?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: const Text('Batal'),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              Get.back();
                              await DetailOrderController.to.cancelOrder();
                            },
                            child: const Text('Ya'),
                          ),
                        ],
                      ),
                    );
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                  ),
                  child: Text(
                    'Batal'.tr,
                    style: Get.textTheme.labelLarge
                        ?.copyWith(color: MainColor.danger),
                  ),
                ),
              ),
              fallbackBuilder: (context) => const SizedBox(),
            ),
          ),
        ],
      ),
      body: Obx(
        () => ConditionalSwitch.single(
          context: context,
          valueBuilder: (context) =>
              DetailOrderController.to.orderDetailState.value,
          caseBuilders: {},
          fallbackBuilder: (context) => CustomScrollView(
            physics: const ClampingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(child: 28.verticalSpace),
              if (DetailOrderController.to.foodItems.isNotEmpty) ...[
                SliverToBoxAdapter(
                  child: SectionHeader(
                    icon: Icons.food_bank_outlined,
                    title: 'Makanan',
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                SliverPadding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 25.w, vertical: 8.h),
                  sliver: OrderListSliver(
                    orders: DetailOrderController.to.foodItems,
                  ),
                )
              ],
              SliverToBoxAdapter(child: 17.verticalSpace),
              if (DetailOrderController.to.drinkItems.isNotEmpty) ...[
                SliverToBoxAdapter(
                  child: SectionHeader(
                    icon: Icons.local_drink_outlined,
                    title: 'Minuman',
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                SliverPadding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 25.w, vertical: 8.h),
                  sliver: OrderListSliver(
                    orders: DetailOrderController.to.drinkItems,
                  ),
                )
              ],
            ],
          ),
        ),
      ),
      bottomNavigationBar: Obx(
        () => Conditional.single(
          context: context,
          conditionBuilder: (context) =>
              DetailOrderController.to.orderDetailState.value == 'success',
          widgetBuilder: (context) => Container(
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(30.r),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 25.h, horizontal: 22.w),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Total order tile
                      TileOption(
                        title: 'Total pesanan',
                        subtitle:
                            '(${DetailOrderController.to.order.value?.detail?.length} Menu):',
                        message:
                            'Rp ${DetailOrderController.to.order.value?.order?.totalBayar ?? '0'}',
                        titleStyle:
                            GoogleTextStyle.fw600.copyWith(fontSize: 18.sp),
                        messageStyle: GoogleTextStyle.fw600.copyWith(
                          fontSize: 18.sp,
                          color: MainColor.primary,
                        ),
                      ),
                      Divider(color: Colors.black45, height: 2.h),

                      // Discount tile
                      Conditional.single(
                        context: context,
                        conditionBuilder: (context) =>
                            DetailOrderController
                                    .to.order.value?.order?.diskon ==
                                1 &&
                            (DetailOrderController
                                        .to.order.value?.order?.potongan ==
                                    null
                                ? false
                                : DetailOrderController
                                        .to.order.value!.order!.potongan >
                                    0),
                        widgetBuilder: (context) => TileOption(
                          icon: Icons.discount_outlined,
                          iconSize: 24.r,
                          title: 'Discount',
                          message:
                              'Rp ${DetailOrderController.to.order.value?.order?.potongan ?? '0'}',
                          titleStyle:
                              GoogleTextStyle.fw600.copyWith(fontSize: 18.sp),
                          messageStyle: GoogleTextStyle.fw600.copyWith(
                            fontSize: 18.sp,
                            color: MainColor.danger,
                          ),
                        ),
                        fallbackBuilder: (context) => const SizedBox(),
                      ),
                      Divider(color: Colors.black54, height: 2.h),

                      // Vouchers tile
                      Conditional.single(
                        context: context,
                        conditionBuilder: (context) =>
                            DetailOrderController
                                .to.order.value?.order?.idVoucher !=
                            0,
                        widgetBuilder: (context) => TileOption(
                          icon: Icons.discount,
                          iconSize: 24.r,
                          title: 'Voucher'.tr,
                          message:
                              'Rp ${DetailOrderController.to.order.value?.order?.potongan ?? '0'}',
                          messageSubtitle: DetailOrderController
                              .to.order.value?.order?.namaVoucher,
                          titleStyle:
                              GoogleTextStyle.fw600.copyWith(fontSize: 18.sp),
                          messageStyle: GoogleTextStyle.fw600.copyWith(
                            fontSize: 18.sp,
                            color: MainColor.danger,
                          ),
                        ),
                        fallbackBuilder: (context) => const SizedBox(),
                      ),
                      Divider(color: MainColor.danger, height: 2.h),

                      // Payment options tile
                      TileOption(
                        icon: Icons.payment_outlined,
                        iconSize: 24.r,
                        title: 'Pembayaran'.tr,
                        message: 'Pay Later',
                        titleStyle:
                            GoogleTextStyle.fw600.copyWith(fontSize: 18.sp),
                        messageStyle:
                            GoogleTextStyle.fw600.copyWith(fontSize: 18.sp),
                      ),

                      Divider(color: Colors.black54, height: 2.h),

                      // total payment
                      TileOption(
                        iconSize: 24.r,
                        title: 'Total pembayaran'.tr,
                        message:
                            'Rp ${DetailOrderController.to.order.value?.order?.totalBayar ?? '0'}',
                        titleStyle:
                            GoogleTextStyle.fw600.copyWith(fontSize: 18.sp),
                        messageStyle: GoogleTextStyle.fw600
                            .copyWith(fontSize: 18.sp)
                            .copyWith(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w600),
                      ),
                      Divider(color: Colors.black54, height: 2.h),
                      24.verticalSpace,

                      // order status track
                      const OrderTracker(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          fallbackBuilder: (context) => const SizedBox(),
        ),
      ),
    );
  }
}
