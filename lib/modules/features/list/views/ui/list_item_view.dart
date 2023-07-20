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
                const SliverToBoxAdapter(
                  child: SectionHeader(
                    icon: Icons.discount,
                    title: 'Promo yang Tersedia',
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
                        separatorBuilder: (context, index) =>
                            26.horizontalSpace,
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
            body: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Obx(() {
                  final currentCategory =
                      ListController.to.selectedCategory.value;
                  return Container(
                    width: 1.sw,
                    height: 35.h,
                    color: Colors.grey[100],
                    margin: EdgeInsets.only(bottom: 10.h),
                    child: SectionHeader(
                      title: currentCategory == 'semua menu'
                          ? 'Semua Menu'
                          : currentCategory == 'makanan'
                              ? 'Makanan'
                              : 'Minuman',
                      icon: currentCategory == 'semua menu'
                          ? Icons.menu_book
                          : currentCategory == 'makanan'
                              ? Icons.food_bank
                              : Icons.local_drink,
                    ),
                  );
                }),
                Expanded(
                  child: Obx(
                    () => SmartRefresher(
                      controller: ListController.to.refreshController,
                      enablePullDown: true,
                      onRefresh: ListController.to.onRefresh,
                      enablePullUp:
                          ListController.to.canLoadMore.isTrue ? true : false,
                      onLoading: ListController.to.getListOfData,
                      child: ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 25.w),
                        itemBuilder: (context, index) {
                          final item = ListController.to.filteredList[index];
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.5.h),
                            child: Material(
                              borderRadius: BorderRadius.circular(10.r),
                              elevation: 2,
                              child: MenuCard(
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
                                  Get.toNamed(MainRoute.detailMenu);
                                },
                              ),
                            ),
                          );
                        },
                        itemCount: ListController.to.filteredList.length,
                        itemExtent: 112.h,
                      ),
                    ),
                  ),
                ),
              ],
            )),
        bottomNavigationBar: const BottomNavigation(),
      ),
    );
  }
}
