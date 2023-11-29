import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:qulip/common/strings.dart';
import 'package:qulip/models/login_model.dart';
import 'package:qulip/utils/log_utils.dart';

class StorageHelper {
  static final box = GetStorage();

  static Future<dynamic> read(String key) async {
    return await box.read(key);
  }

  static Future<void> write(String key, dynamic value) async {
    return await box.write(key, value);
  }

  static Future<void> updateUserInfo(User user) async {
    Log.logs(
      WordStrings.lblStorage,
      '${StorageKeys.userData} stored with ${user.toJson().toString()} successfully',
    );

    return await box.write(StorageKeys.userData, jsonEncode(user.toJson()));
  }

  static Future<User> getUserInfo() async {
    return User.fromJson(jsonDecode(await box.read(StorageKeys.userData)));
  }

  static Future<void> erase() async {
    Log.logs(
      WordStrings.lblStorage,
      'Storege with Erased successfully',
    );
    return await box.erase();
  }

  static Future<void> remove(String key) async {
    Log.logs(
      WordStrings.lblStorage,
      'Storege with removed successfully',
    );
    return await box.remove(key);
  }
}

class StorageKeys {
  static const String phoneNumber = "Phone Number";
  static const String password = "Password";

  static const String authToken = 'Authorization';
  static const String userData = 'userData';
  static const String intro = 'intro';
  static const String isVerified = 'verified';
  static const String profilePic = 'profilePic';
  static const String userId = 'userId';
  static const String dateFormat = 'dateFormat';
  static const String selectedCategory = 'selectedCategory';

  static const String searchType = 'searchType';
  static const String searchState = 'searchState';
  static const String searchCity = 'searchCity';
  static const String searchSubCity = 'searchSubCity';
}
