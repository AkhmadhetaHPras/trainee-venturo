import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:trainee/configs/routes/main_route.dart';

import '../../../../../constants/cores/assets/image_constant.dart';
import '../../../../../shared/styles/google_text_style.dart';
import '../../controllers/order_controller.dart';
import '../components/order_item_card.dart';

class OnGoingOrderTabView extends StatelessWidget {
  const OnGoingOrderTabView({super.key});
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  Widget build(BuildContext context) {
    analytics.setCurrentScreen(
      screenName: 'Ongoing Order Screen',
      screenClassOverride: 'Trainee',
    );

    return Obx(
      () => SmartRefresher(
        controller: OrderController.to.refreshOnGoingController,
        enablePullDown: true,
        onRefresh: OrderController.to.onRefreshOnGoing,
        enablePullUp:
            OrderController.to.canLoadMoreOnGoing.isTrue ? true : false,
        onLoading: OrderController.to.getListOnGoing,
        child: OrderController.to.onGoingOrders.isNotEmpty
            ? ListView.separated(
                padding: EdgeInsets.all(25.r),
                itemBuilder: (context, index) => OrderItemCard(
                  order: OrderController.to.onGoingOrders[index],
                  onTap: () {
                    Get.toNamed(
                      '${MainRoute.order}/${OrderController.to.onGoingOrders[index].idOrder}',
                    );
                  },
                  onOrderAgain: () {},
                ),
                separatorBuilder: (context, index) => 16.verticalSpace,
                itemCount: OrderController.to.onGoingOrders.length,
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
                      "Already ordered?\nTrack your order here".tr,
                      style: GoogleTextStyle.fw400.copyWith(
                        fontSize: 22.sp,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
