import 'package:dio/dio.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../../../utils/services/http_service.dart';
import '../../../../utils/services/local_storage_service.dart';
import '../models/user.dart';

class ProfileRepository {
  Future<User?> getDetailProfile() async {
    try {
      var dio =
          HttpService.dioCall(token: await LocalStorageService.getToken());

      final id = await LocalStorageService.box.get('id');

      final response = await dio.get(
        'user/detail/$id',
      );

      if (response.statusCode == 200) {
        final responseData = response.data;
        return responseData['data'] == null
            ? null
            : User.fromJson(responseData['data']);
      } else {
        throw Exception('API Error');
      }
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      return null;
    }
  }

  Future<bool> updateProfile(
    String? nama,
    String? tglLahir,
    String? telepon,
    String? email,
    String? pin,
  ) async {
    try {
      var dio =
          HttpService.dioCall(token: await LocalStorageService.getToken());

      final id = await LocalStorageService.box.get('id');

      final Map<String, dynamic> requestData = {
        if (nama != null) 'nama': nama,
        if (tglLahir != null) 'tgl_lahir': tglLahir,
        if (telepon != null) 'telepon': telepon,
        if (email != null) 'email': email,
        if (pin != null) 'pin': pin,
      };

      final response = await dio.post(
        'user/update/$id',
        data: FormData.fromMap(requestData),
      );

      if (response.statusCode == 200) {
        final responseData = response.data;
        return responseData['status_code'] == 200 ? true : false;
      } else {
        throw Exception('API Error');
      }
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      return false;
    }
  }

  Future<bool> postPhotoProfile(String image64) async {
    try {
      var dio =
          HttpService.dioCall(token: await LocalStorageService.getToken());

      final id = await LocalStorageService.box.get('id');

      final response = await dio.post(
        'user/profil/$id',
        data: {
          "image": image64,
        },
      );

      if (response.statusCode == 200) {
        final responseData = response.data;
        return responseData['status_code'] == 200 ? true : false;
      } else {
        throw Exception('API Error');
      }
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      return false;
    }
  }

  Future<bool> postKtp(String image64) async {
    try {
      var dio =
          HttpService.dioCall(token: await LocalStorageService.getToken());

      final id = await LocalStorageService.box.get('id');

      final response = await dio.post(
        'user/ktp/$id',
        data: {
          "image": image64,
        },
      );

      if (response.statusCode == 200) {
        final responseData = response.data;
        return responseData['status_code'] == 200 ? true : false;
      } else {
        throw Exception('API Error');
      }
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      return false;
    }
  }

  Future<void> logOut() async {
    try {
      var dio =
          HttpService.dioCall(token: await LocalStorageService.getToken());

      final response = await dio.get(
        '/auth/logout',
      );

      if (response.statusCode == 200) {
        final responseData = response.data;

        if (responseData["status_code"] == 200) {
          await LocalStorageService.deleteAuth();
        }
      } else {
        print('Gagal logout. Status code: ${response.statusCode}');
      }
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
    }
  }
}
