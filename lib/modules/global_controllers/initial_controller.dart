import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../../configs/routes/main_route.dart';
import '../../utils/services/local_storage_service.dart';
import '../../utils/services/location_service.dart';
import '../features/initial/views/ui/get_location_screen.dart';

class InitialController extends GetxController {
  static InitialController get to => Get.find();

  /// Location
  RxString statusLocation = RxString('loading');
  RxString messageLocation = RxString('');
  Rxn<Position> position = Rxn<Position>();
  RxnString address = RxnString();

  /// User Data
  RxInt id = RxInt(0);
  RxString name = RxString('');
  RxString photo = RxString('');

  @override
  void onReady() async {
    super.onReady();

    bool isLocationAvailable = false;
    if (isLocationAvailable) {
      Get.offAllNamed(MainRoute.initial);
    } else {
      getLocation();
      LocationServices.streamService.listen((status) => getLocation());
    }

    id.value = await LocalStorageService.box.get("id") ?? 0;
    name.value = await LocalStorageService.box.get("name") ?? '';
    photo.value = await LocalStorageService.box.get("photo") ?? '';
  }

  Future<void> getLocation() async {
    if (Get.isDialogOpen == false) {
      Get.dialog(const GetLocationScreen(), barrierDismissible: false);
    }

    try {
      /// Mendapatkan Lokasi saat ini
      statusLocation.value = 'loading';
      final locationResult = await LocationServices.getCurrentPosition();

      if (locationResult.success) {
        /// Jika jarak lokasi cukup dekat, dapatkan informasi alamat
        position.value = locationResult.position;
        address.value = locationResult.address;
        statusLocation.value = 'success';

        await Future.delayed(const Duration(seconds: 1));
        Get.offAllNamed(MainRoute.list);
      } else {
        /// Jika jarak lokasi tidak cukup dekat, tampilkan pesan
        statusLocation.value = 'error';
        messageLocation.value = locationResult.message!;
      }
    } catch (e) {
      /// Jika terjadi kesalahan server
      statusLocation.value = 'error';
      messageLocation.value = 'Server error'.tr;
    }
  }
}
