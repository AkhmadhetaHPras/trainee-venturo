import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:trainee/configs/themes/main_color.dart';
import 'package:trainee/modules/features/profile/repositories/profile_repository.dart';
import 'package:trainee/shared/widgets/image_picker_dialog.dart';
import 'package:device_info_plus/device_info_plus.dart';

import '../../../../configs/localization/localization.dart';
import '../models/user.dart';
import '../views/components/language_bottom_sheet.dart';
import '../views/components/contact_info_bottom_sheet.dart';

class ProfileController extends GetxController {
  static ProfileController get to => Get.find();
  late final ProfileRepository repository;

  final Rx<File?> _imageFile = Rx<File?>(null);
  RxString deviceModel = ''.obs;
  RxString deviceVersion = ''.obs;
  RxBool isVerif = false.obs;
  RxString currentLang = Localization.currentLanguage.obs;
  Rx<User> user = User().obs;

  File? get imageFile => _imageFile.value;

  @override
  void onInit() async {
    super.onInit();
    repository = ProfileRepository();

    // get detail user
    user.value = await repository.getDetailProfile() ?? User();

    /// Load Device Info
    getDeviceInformation();
  }

  /// Pilih image untuk update photo
  Future<void> pickImage() async {
    /// Buka dialog untuk sumber gambar
    ImageSource? imageSource = await Get.defaultDialog(
      title: '',
      titleStyle: const TextStyle(fontSize: 0),
      content: const ImagePickerDialog(),
    );

    /// pengecekan sumber gambar
    if (imageSource == null) return;

    final pickedFile = await ImagePicker().pickImage(
      source: imageSource,
      maxWidth: 300,
      maxHeight: 300,
      imageQuality: 75,
    );

    /// setelah dipilih, akan terbuka crop gambar
    if (pickedFile != null) {
      _imageFile.value = File(pickedFile.path);
      final croppedFile = await ImageCropper()
          .cropImage(sourcePath: _imageFile.value!.path, aspectRatioPresets: [
        CropAspectRatioPreset.square
      ], uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Cropper'.tr,
          toolbarColor: MainColor.primary,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.square,
          lockAspectRatio: true,
        )
      ]);

      /// Jika gambar telah dipilih, maka akan dimasukkan ke variabel image file, karena ini masih menggunakan local file
      if (croppedFile != null) {
        _imageFile.value = File(croppedFile.path);
      }

      // Read bytes from the file
      List<int> imageBytes = await _imageFile.value!.readAsBytes();
      // Convert bytes to base64-encoded string
      String base64Format = base64.encode(imageBytes);

      await postUpdatePhoto(base64Format);
    }
  }

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File file = File(result.files.single.path!);

      /// Selanjutnya apa yang ingin diinginkan
      isVerif.value = true;
    }
  }

  Future getDeviceInformation() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    deviceModel.value = androidInfo.model;
    deviceVersion.value = androidInfo.version.release;
  }

  Future<void> updateLanguage() async {
    String? language = await Get.bottomSheet(
      const LanguageBottomSheet(),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30.r),
        ),
      ),
      isScrollControlled: true,
    );

    if (language != null) {
      Localization.changeLocale(language);
      currentLang(language);
    }
  }

  Future<void> updateUser({
    String? nama,
    DateTime? tglLahir,
    String? telepon,
    String? email,
    String? pin,
  }) async {
    final reqData = <String, String>{};

    if (nama != null) reqData["nama"] = nama;
    if (tglLahir != null) {
      reqData["tgl_lahir"] = DateFormat('yyy-MM-dd').format(tglLahir);
    }
    if (telepon != null) reqData["telepon"] = telepon;
    if (email != null) reqData["email"] = email;
    if (pin != null) reqData["pin"] = pin;

    // update user data
    if (await repository.updateProfile(
        nama, reqData["tgl_lahir"], telepon, email, pin)) {
      user.value = await repository.getDetailProfile() ?? User();
    } else {
      Get.snackbar("Terjadi Kesalahan", "Data Gagal Diperbaraui");
    }
  }

  Future<void> updateProfileName() async {
    String? nameInput = await Get.bottomSheet(
      ContactInfoBottomSheet(title: "Nama", name: user.value.nama ?? '-'),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30.r),
        ),
      ),
      isScrollControlled: true,
    );

    if (nameInput != null && nameInput.isNotEmpty) {
      await updateUser(nama: nameInput);
    }
  }

  Future<void> updateBirthDate() async {
    DateTime? birthDate = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime(DateTime.now().year - 21),
      firstDate: DateTime(DateTime.now().year - 100),
      lastDate: DateTime.now(),
    );

    if (birthDate != null) {
      await updateUser(tglLahir: birthDate);
    }
  }

  Future<void> updatePhoneNumber() async {
    String? phoneInput = await Get.bottomSheet(
      ContactInfoBottomSheet(
          title: "No. Telepon", phoneNumber: user.value.telepon ?? '-'),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30.r),
        ),
      ),
      isScrollControlled: true,
    );

    if (phoneInput != null && phoneInput.isNotEmpty) {
      await updateUser(telepon: phoneInput);
    }
  }

  Future<void> updateEmail() async {
    String? emailInput = await Get.bottomSheet(
      ContactInfoBottomSheet(title: "Email", email: user.value.email ?? '-'),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30.r),
        ),
      ),
      isScrollControlled: true,
    );

    if (emailInput != null && emailInput.isNotEmpty) {
      await updateUser(email: emailInput);
    }
  }

  Future<void> postUpdatePhoto(String image64) async {
    if (await repository.postPhotoProfile(image64)) {
      user.value = await repository.getDetailProfile() ?? User();
      Get.snackbar("Foto Profile", "Berhasil Mengganti Foto Profile");
    } else {
      Get.snackbar("Foto Profile", "Gagal Mengganti Foto Profile");
    }
  }
}
