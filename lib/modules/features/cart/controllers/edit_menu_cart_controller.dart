import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../menu/models/menu_response.dart';
import '../../menu/repositories/menu_repository.dart';

class EditMenuCartController extends GetxController {
  static EditMenuCartController get to => Get.find();

  late final MenuRepository repository;

  final RxInt index = 0.obs;
  final RxInt id = 0.obs;
  final RxList<int> idToppingDatas = <int>[].obs;
  final RxInt idLevelFirst = 0.obs;

  final Rx<Menu> menu = Menu().obs;
  final RxList<Topping> topping = <Topping>[].obs;
  final RxList<Level> level = <Level>[].obs;

  final Rx<Level?> selectedLevel = Level().obs;
  final RxList<Topping> selectedTopping = <Topping>[].obs;

  late RxString catatan;
  late TextEditingController catatanTextController;

  @override
  void onInit() async {
    super.onInit();
    repository = MenuRepository();
    index.value = Get.arguments['index'] as int;
    id.value = Get.arguments['idMenu'] as int;
    idToppingDatas.value = Get.arguments['toppings'];
    idLevelFirst.value = Get.arguments['level'] as int;

    catatanTextController =
        TextEditingController(text: Get.arguments['catatan'] as String);

    catatan = catatanTextController.text.obs;

    await getDetailMenu();
    findToppingWithIdDetail();
    findLevelWithIdDetail();
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
      }
    } catch (exception, stacktrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stacktrace,
      );
    }
  }

  void findToppingWithIdDetail() {
    selectedTopping.clear();
    for (int idDetail in idToppingDatas) {
      // Find the Topping object that matches the current idDetail
      Topping toppingToAdd = topping.firstWhere((t) => t.idDetail == idDetail,
          orElse: () => Topping());

      if (toppingToAdd.idDetail != null) {
        selectedTopping.add(toppingToAdd);
      }
    }
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

  void findLevelWithIdDetail() {
    final Level selected = level.firstWhere(
        (element) => element.idDetail == idLevelFirst.value,
        orElse: () => Level());

    selectedLevel.value = selected;
  }
}
