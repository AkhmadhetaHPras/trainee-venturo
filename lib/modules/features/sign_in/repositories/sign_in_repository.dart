import 'dart:convert';

import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:trainee/modules/features/profile/models/user.dart';
import 'package:trainee/modules/features/sign_in/models/sign_in_response.dart';
import 'package:trainee/utils/services/local_storage_service.dart';

import '../../../../utils/services/http_service.dart';

class SignInRepository {
  Future<void> loginUser(String email, String password) async {
    try {
      var dio = HttpService.dioCall();

      final response = await dio.post(
        '/auth/login',
        data: jsonEncode({
          "email": email,
          "password": password,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = response.data;
        final signInResponse = SignInResponse.fromJson(responseData);
        if (signInResponse.data != null) {
          await LocalStorageService.setAuth(signInResponse.data!);
        }
      } else {
        print('Gagal login. Status code: ${response.statusCode}');
      }
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
    }
  }

  Future<void> loginUserGoogle(String email, String nama) async {
    try {
      var dio = HttpService.dioCall();

      final response = await dio.post(
        '/auth/login',
        data: jsonEncode({
          "email": email,
          "nama": nama,
          "is_google": 1,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = response.data;

        final signInResponse = SignInResponse.fromJson(responseData);

        if (signInResponse.data != null) {
          await LocalStorageService.setAuth(signInResponse.data!);
        }
      } else {
        print('Gagal login. Status code: ${response.statusCode}');
      }
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
    }
  }

  Future<void> setPin() async {
    try {
      var dio =
          HttpService.dioCall(token: await LocalStorageService.getToken());

      final id = await LocalStorageService.box.get('id');

      final response = await dio.get(
        'user/detail/$id',
      );

      if (response.statusCode == 200) {
        final responseData = response.data;
        if (responseData['data'] != null) {
          await LocalStorageService.setPin(
              User.fromJson(responseData['data']).pin ?? "111111");
        }
      } else {
        throw Exception('API Error');
      }
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
    }
  }
}
