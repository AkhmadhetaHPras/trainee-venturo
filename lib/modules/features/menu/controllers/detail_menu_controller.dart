import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:trainee/modules/features/menu/repositories/menu_repository.dart';

import '../models/menu_response.dart';

class DetailMenuController extends GetxController {
  static DetailMenuController get to => Get.find();

  late final MenuRepository repository;

  final RxInt id = 0.obs;
  final Rx<Menu> menu = Menu().obs;
  final RxList<Topping> topping = <Topping>[].obs;
  final RxList<Level> level = <Level>[].obs;

  final Rx<Level?> selectedLevel = Level().obs;
  final RxList<Topping> selectedTopping = <Topping>[].obs;
  final RxInt quantity = 1.obs;
  late RxString catatan;
  late TextEditingController catatanTextController;

  @override
  void onInit() async {
    super.onInit();
    catatanTextController = TextEditingController();
    catatan = catatanTextController.text.obs;
    id.value = Get.arguments;
    repository = MenuRepository();
    await getDetailMenu();
  }

  @override
  void onClose() {
    super.onClose();
    catatanTextController.dispose();
  }

  List<int> getIdDetailsFromSelectedToppings() {
    List<int> idDetailsList =
        selectedTopping.map((topping) => topping.idDetail!).toList();

    return idDetailsList;
  }

  bool isToppingInSelectedList(int idDetail) {
    bool isFound =
        selectedTopping.any((topping) => topping.idDetail == idDetail);

    return isFound;
  }

  void addOrRemoveTopping(Topping topping) {
    if (isToppingInSelectedList(topping.idDetail!)) {
      selectedTopping.removeWhere((t) => t.idDetail == topping.idDetail);
    } else {
      selectedTopping.add(topping);
    }
  }

  Future getDetailMenu() async {
    try {
      final menuResponse = await repository.getDetailMenu(id.value);
      if (menuResponse.data != null) {
        final menuData = menuResponse.data?.menu;
        final topingData = menuResponse.data?.topping;
        final levelData = menuResponse.data?.level;

        menu.value = menuData!;
        topping.value = topingData!;
        level.value = levelData!;

        selectedLevel.value = level.isEmpty ? null : level.first;
        selectedTopping.clear();
        if (topping.isNotEmpty) {
          selectedTopping.add(topping.first);
        }
      }
    } catch (exception, stacktrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stacktrace,
      );
    }
  }

  addQty() {
    quantity.value += 1;
  }

  minQty() {
    if (quantity > 1) quantity.value -= 1;
  }
}
