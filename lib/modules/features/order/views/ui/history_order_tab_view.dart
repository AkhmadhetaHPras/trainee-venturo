import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:flutter_conditional_rendering/conditional_switch.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:trainee/configs/routes/main_route.dart';
import 'package:trainee/configs/themes/main_color.dart';
import 'package:trainee/modules/global_controllers/cart_controller.dart';
import 'package:trainee/shared/styles/google_text_style.dart';

import '../../../../../constants/cores/assets/image_constant.dart';
import '../../controllers/order_controller.dart';
import '../components/date_picker.dart';
import '../components/dropdown_status.dart';
import '../components/order_item_card.dart';

class OrderHistoryTabView extends StatelessWidget {
  const OrderHistoryTabView({super.key});
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  Widget build(BuildContext context) {
    analytics.setCurrentScreen(
      screenName: 'Order History Screen',
      screenClassOverride: 'Trainee',
    );

    return Scaffold(
      body: Obx(
        () => SmartRefresher(
          controller: OrderController.to.refreshHistoryController,
          enablePullDown: true,
          onRefresh: OrderController.to.onRefreshHistory,
          enablePullUp:
              OrderController.to.canLoadMoreHistory.isTrue ? true : false,
          onLoading: OrderController.to.getListHistory,
          child: OrderController.to.historyOrders.isNotEmpty
              ? ConditionalSwitch.single(
                  context: context,
                  valueBuilder: (context) =>
                      OrderController.to.orderHistoryState.value,
                  caseBuilders: {},
                  fallbackBuilder: (context) => CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 25.w, vertical: 25.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: DropdownStatus(
                                  items: OrderController.to.dateFilterStatus,
                                  selectedItem:
                                      OrderController.to.selectedCategory.value,
                                  onChanged: (value) => OrderController.to
                                      .setDateFilter(category: value),
                                ),
                              ),
                              22.horizontalSpaceRadius,
                              Expanded(
                                child: DatePicker(
                                  selectedDate: OrderController
                                      .to.selectedDateRange.value,
                                  onChanged: (value) => OrderController.to
                                      .setDateFilter(range: value),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Conditional.single(
                        context: context,
                        conditionBuilder: (context) =>
                            OrderController.to.filteredHistoryOrder.isNotEmpty,
                        widgetBuilder: (context) => SliverPadding(
                          padding: EdgeInsets.symmetric(horizontal: 25.w),
                          sliver: SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) => Padding(
                                padding: EdgeInsets.only(bottom: 16.r),
                                child: OrderItemCard(
                                  order: OrderController
                                      .to.filteredHistoryOrder[index],
                                  onOrderAgain: () {
                                    final orderMenu = OrderController
                                        .to.filteredHistoryOrder[index].menu;
                                    for (var element in orderMenu) {
                                      CartController.to
                                          .addToCart(element.toMenuCart());
                                    }

                                    Get.offNamed(MainRoute.order);
                                    Get.toNamed(MainRoute.cart);
                                  },
                                  onTap: () => Get.toNamed(
                                    '${MainRoute.order}/${OrderController.to.filteredHistoryOrder[index].idOrder}',
                                  ),
                                ),
                              ),
                              childCount: OrderController
                                  .to.filteredHistoryOrder.length,
                            ),
                          ),
                        ),
                        fallbackBuilder: (context) => const SliverToBoxAdapter(
                          child: SizedBox(),
                        ),
                      ),
                    ],
                  ),
                )
              : Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(ImageConstant.bgBlank),
                      fit: BoxFit.fitHeight,
                      alignment: Alignment.center,
                    ),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 30.r),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        ImageConstant.icNoteAction,
                      ),
                      Text(
                        "Start making orders\nThe food you ordered will appear here so you can find your favorites again!"
                            .tr,
                        style: GoogleTextStyle.fw400.copyWith(
                          fontSize: 22.sp,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
        ),
      ),
      bottomNavigationBar: Obx(() {
        if (OrderController.to.historyOrders.isNotEmpty) {
          return Container(
            width: 1.sw,
            height: 60.h,
            padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 15.h),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(30.r),
                )),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Order'.tr,
                  style: GoogleTextStyle.fw700.copyWith(fontSize: 18.sp),
                ),
                5.horizontalSpace,
                Obx(() => Text(
                      'Rp ${OrderController.to.totalHistoryOrder}',
                      style: GoogleTextStyle.fw700.copyWith(
                        fontSize: 18.sp,
                        color: MainColor.primary,
                      ),
                    )),
              ],
            ),
          );
        } else {
          return const SizedBox();
        }
      }),
    );
  }
}
