import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:qulip/apis/services/api_params.dart';
import 'package:qulip/apis/services/api_utils.dart';
import 'package:qulip/common/snack.dart';
import 'package:qulip/common/strings.dart';
import 'package:qulip/utils/storage_helper.dart';

class DioHelper<T> {
  Future<T> get({
    required String url,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return {
        paramSatatusCode: codeNoInternet,
        paramMessage: apiUtils.getNetworkError(),
      } as T;
    }
    final token = await StorageHelper.read(WordStrings.accessToken);
    try {
      final response = await apiUtils.get(
        url: url,
        queryParameters: queryParameters,
        options: Options(headers: {'V-ID': token}),
      );
      return response.data;
    } catch (e) {
      return {
        paramSatatusCode: codeError,
        paramMessage: apiUtils.handleError(e),
      } as T;
    }
  }

  Future<T> post({
    required String url,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return {
        paramSatatusCode: codeNoInternet,
        paramMessage: apiUtils.getNetworkError(),
      } as T;
    }
    try {
      final response = await apiUtils.post(
        url: url,
        data: data,
        queryParameters: queryParameters,
        options: Options(
            headers: {'V-ID': WordStrings.apiKey, 'V-Sign': getVSignIn(data)}),
      );
      if (response.data['code'] != codeSucces) {
        MySnackBar.errorSnackbar(response.data['message']);
      }
      return response.data;
    } catch (e) {
      return {
        paramSatatusCode: codeError,
        paramMessage: apiUtils.handleError(e),
      } as T;
    }
  }

  String getVSignIn(params) {
    final dataF =
        '${json.encode(params).replaceAll(",", ":")}${WordStrings.apiKey}';
    var key = utf8.encode(WordStrings.apiSecret);
    var bytes = utf8.encode(dataF);

    var hmacSha256 = Hmac(sha256, key); // HMAC-SHA256
    var digest = hmacSha256.convert(bytes);

    // print("HMAC digest data: ${dataF}");
    // print("HMAC digest as bytes: ${digest.bytes}");
    // print("HMAC digest as hex string: $digest");

    return digest.toString();
  }
}
