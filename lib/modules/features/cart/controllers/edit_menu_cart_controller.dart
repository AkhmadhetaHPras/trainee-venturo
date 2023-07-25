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
  final RxInt idToppingFirst = 0.obs;
  final RxInt idLevelFirst = 0.obs;

  final Rx<Menu> menu = Menu().obs;
  final RxList<Topping> topping = <Topping>[].obs;
  final RxList<Level> level = <Level>[].obs;

  final Rx<Level?> selectedLevel = Level().obs;
  final Rx<Topping?> selectedTopping = Topping().obs;

  late RxString catatan;
  late TextEditingController catatanTextController;

  @override
  void onInit() async {
    super.onInit();
    repository = MenuRepository();
    index.value = Get.arguments[0] as int;
    id.value = Get.arguments[1] as int;
    idToppingFirst.value = Get.arguments[2] as int;
    idLevelFirst.value = Get.arguments[3] as int;

    catatanTextController =
        TextEditingController(text: Get.arguments[4] as String);

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
    final Topping selected = topping.firstWhere(
        (element) => element.idDetail == idToppingFirst.value,
        orElse: () => Topping());

    selectedTopping.value = selected;
  }

  void findLevelWithIdDetail() {
    final Level selected = level.firstWhere(
        (element) => element.idDetail == idLevelFirst.value,
        orElse: () => Level());

    selectedLevel.value = selected;
  }
}
