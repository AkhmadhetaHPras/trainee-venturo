import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:trainee/configs/routes/main_route.dart';
import 'package:trainee/shared/customs/bottom_navigation.dart';
import 'package:trainee/modules/features/list/controllers/list_controller.dart';

import '../components/menu_card.dart';
import '../components/menu_chip.dart';
import '../components/promo_card.dart';
import '../components/search_app_bar.dart';
import '../components/section_header.dart';

class ListItemView extends StatelessWidget {
  const ListItemView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: SearchAppBar(
          onChange: (value) => ListController.to.keyword(value),
        ),
        body: NestedScrollView(
          physics: const ClampingScrollPhysics(),
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverToBoxAdapter(child: 22.verticalSpace),
              // list of promo
              SliverToBoxAdapter(
                child: SectionHeader(
                  icon: Icons.discount,
                  title: 'Available Promos'.tr,
                ),
              ),
              SliverToBoxAdapter(child: 22.verticalSpace),
              SliverToBoxAdapter(
                child: SizedBox(
                  width: 1.sw,
                  height: 188.h,
                  child: Obx(
                    () => ListView.separated(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(horizontal: 25.w),
                      itemBuilder: (context, index) {
                        final promo = ListController.to.promos[index];
                        return PromoCard(
                          id: promo.idPromo!,
                          termCondition: promo.syaratKetentuan,
                          type: promo.type!,
                          enableShadow: false,
                          promoName: promo.nama!,
                          discountNominal: promo.diskon,
                          voucherNominal: promo.nominal,
                          thumbnailUrl: promo.foto ??
                              "https://javacode.landa.id/img/promo/gambar_62661b52223ff.png",
                        );
                      },
                      separatorBuilder: (context, index) => 26.horizontalSpace,
                      itemCount: ListController.to.promos.length,
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(child: 22.verticalSpace),
              // Row of categories
              SliverToBoxAdapter(
                child: SizedBox(
                  width: 1.sw,
                  height: 45.h,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: ListController.to.categories.length,
                    padding: EdgeInsets.symmetric(horizontal: 25.w),
                    itemBuilder: (context, index) {
                      final category = ListController.to.categories[index];
                      return Obx(() => MenuChip(
                            onTap: () {
                              ListController.to
                                  .selectedCategory(category.toLowerCase());
                            },
                            isSelected:
                                ListController.to.selectedCategory.value ==
                                    category.toLowerCase(),
                            text: category,
                          ));
                    },
                    separatorBuilder: (context, index) => 13.horizontalSpace,
                  ),
                ),
              ),
              SliverToBoxAdapter(child: 10.verticalSpace),
            ];
          },
          body: Obx(
            () => SmartRefresher(
              controller: ListController.to.refreshController,
              enablePullDown: true,
              onRefresh: ListController.to.onRefresh,
              enablePullUp: ListController.to.canLoadMore.isTrue ? true : false,
              onLoading: ListController.to.getListOfData,
              child: CustomScrollView(
                physics: const ClampingScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(child: 28.verticalSpace),
                  if (ListController.to.foodList.isNotEmpty) ...[
                    SliverToBoxAdapter(
                      child: SectionHeader(
                        icon: Icons.food_bank_outlined,
                        title: 'Food'.tr,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    SliverPadding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 25.w, vertical: 8.h),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final item = ListController.to.foodList[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Obx(
                                () => MenuCard(
                                  menu: item,
                                  isSelected: ListController.to.selectedItems
                                      .contains(item),
                                  onTap: () {
                                    // if (ListController.to.selectedItems
                                    //     .contains(item)) {
                                    //   ListController.to.selectedItems
                                    //       .remove(item);
                                    // } else {
                                    //   ListController.to.selectedItems.add(item);
                                    // }
                                    Get.toNamed(MainRoute.detailMenu,
                                        arguments: item.idMenu);
                                  },
                                ),
                              ),
                            );
                          },
                          childCount: ListController.to.foodList.length,
                        ),
                      ),
                    ),
                  ],
                  SliverToBoxAdapter(child: 17.verticalSpace),
                  if (ListController.to.drinkList.isNotEmpty) ...[
                    SliverToBoxAdapter(
                      child: SectionHeader(
                        icon: Icons.local_drink_outlined,
                        title: 'Drink'.tr,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    SliverPadding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 25.w, vertical: 8.h),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final item = ListController.to.drinkList[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Obx(
                                () => MenuCard(
                                  menu: item,
                                  isSelected: ListController.to.selectedItems
                                      .contains(item),
                                  onTap: () {
                                    // if (ListController.to.selectedItems
                                    //     .contains(item)) {
                                    //   ListController.to.selectedItems
                                    //       .remove(item);
                                    // } else {
                                    //   ListController.to.selectedItems.add(item);
                                    // }
                                    Get.toNamed(MainRoute.detailMenu,
                                        arguments: item.idMenu);
                                  },
                                ),
                              ),
                            );
                          },
                          childCount: ListController.to.drinkList.length,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: const BottomNavigation(),
      ),
    );
  }
}
