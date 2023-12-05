import 'package:flutter/foundation.dart';
import 'package:qulip/apis/api_end_points.dart';
import 'package:qulip/apis/services/api.dart';
import 'package:qulip/apis/services/api_base_repository.dart';
import 'package:qulip/common/snack.dart';

class ApiRepo {
  static void printError(e) {
    debugPrint('\nError:\n$e');
  }

  static void loginWithMobile({
    required String mobile,
    required String password,
    required Function(bool success, dynamic response)? onComplete,
  }) async {
    const String url = Api.baseUrl + ApiEndPoints.login;
    final Map<String, dynamic> data = {
      'username': mobile,
      'password': password
    };
    try {
      final response = await DioHelper().post(
        url: url,
        data: data,
      );
      if (response['success'] == true) {
        onComplete?.call(true, response);
      } else {
        onComplete?.call(false, null);
        MySnackBar.errorSnackbar(response['message']);
      }
    } catch (e) {
      onComplete?.call(false, null);
    }
  }

  static void getPoints({
    required String phone,
    required Function(bool success, dynamic response)? onComplete,
  }) async {
    const String url = Api.baseUrl + ApiEndPoints.point;
    final Map<String, dynamic> data = {
      'phone': phone,
    };
    try {
      final response = await DioHelper().post(
        url: url,
        data: data,
      );
      if (response['success'] == true) {
        onComplete?.call(true, response);
      } else {
        onComplete?.call(false, null);
        MySnackBar.errorSnackbar(response['message']);
      }
    } catch (e) {
      onComplete?.call(false, null);
    }
  }
}
