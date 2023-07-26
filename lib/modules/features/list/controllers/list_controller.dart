import 'package:get/get.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:trainee/modules/features/list/models/menu_response.dart';

import '../models/promo_response.dart';
import '../repositories/list_repository.dart';

class ListController extends GetxController {
  static ListController get to => Get.find<ListController>();
  late final ListRepository repository;
  final RxInt page = 0.obs;
  final RxList<MenuData> items = <MenuData>[].obs;
  final RxList<PromoData> promos = <PromoData>[].obs;
  final RxList<MenuData> selectedItems = <MenuData>[].obs;
  final RxBool canLoadMore = true.obs;
  final RxString selectedCategory = 'semua menu'.obs;
  final RxString keyword = ''.obs;
  final List<String> categories = [
    'Semua Menu',
    'Makanan',
    'Minuman',
  ];
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  @override
  void onInit() async {
    super.onInit();
    repository = ListRepository();
    await getPromos();
    await getListOfData();
  }

  void onRefresh() async {
    page(0);
    canLoadMore(true);
    final result = await getListOfData();
    if (result) {
      refreshController.refreshCompleted();
    } else {
      refreshController.refreshFailed();
    }
  }

  List<MenuData> get filteredList => items
      .where((element) =>
          element.nama!.toLowerCase().contains(keyword.value.toLowerCase()) &&
          (selectedCategory.value == 'semua menu' ||
              element.kategori == selectedCategory.value))
      .toList();

  List<MenuData> get foodList => filteredList
      .where((element) =>
          element.nama!.toLowerCase().contains(keyword.value.toLowerCase()) &&
          element.kategori == 'makanan')
      .toList();

  List<MenuData> get drinkList => filteredList
      .where((element) =>
          element.nama!.toLowerCase().contains(keyword.value.toLowerCase()) &&
          element.kategori == 'minuman')
      .toList();

  Future<bool> getListOfData() async {
    try {
      final result = await repository.getListOfData(
        offset: page.value * 5,
      );
      if (result['previous'] == null) {
        items.clear();
      }

      if (result['next'] == null) {
        canLoadMore(false);
        refreshController.loadNoData();
      }

      items.addAll(result['data']);
      page.value++;
      refreshController.loadComplete();
      return true;
    } catch (exception, stacktrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stacktrace,
      );

      refreshController.loadFailed();
      return false;
    }
  }

  Future getPromos() async {
    try {
      final promoResponse = await repository.getPromos();
      promos.clear();

      if (promoResponse?.data != null) {
        promos.addAll(promoResponse!.data!);
      }
    } catch (exception, stacktrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stacktrace,
      );
    }
  }
}
