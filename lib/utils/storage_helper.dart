
import 'package:get_storage/get_storage.dart';
import 'package:qulip/common/strings.dart';
import 'package:qulip/utils/log_utils.dart';

class StorageHelper {
  static final box = GetStorage();

  static Future<dynamic> read(String key) async {
    return await box.read(key);
  }

  static Future<void> write(String key, dynamic value) async {
    return await box.write(key, value);
  }

  static Future<void> erase() async {
    Log.logs(
      WordStrings.lblStorage,
      'Storege with Erased successfully',
    );
    return await box.erase();
  }

  static Future<void> logout() async {
    remove(StorageKeys.isLogin);
    remove(StorageKeys.userData);
    remove(StorageKeys.userId);
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
  static const String isLogin = "isLogin";
  static const String phoneNumber = "Phone Number";
  static const String password = "Password";
  static const String isRemember = "isRemember";
  static const String userId = "userId";

  static const String authToken = 'Authorization';
  static const String userData = 'userData';
  static const String point = 'points';
  static const String profileLink = 'profileLink';
}
