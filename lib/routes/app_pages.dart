import 'package:get/get.dart';
import 'package:qulip/routes/app_routes.dart';
import 'package:qulip/view/home_flow/home_screen.dart';
import 'package:qulip/view/home_flow/profile_screen.dart';
import 'package:qulip/view/home_flow/system_info_screen.dart';
import 'package:qulip/view/login_flow/login_screen.dart';
import 'package:qulip/view/login_flow/signup_screen.dart';
import 'package:qulip/view/login_flow/splash_screen.dart';

class AppPages {
  static final List<GetPage> pages = [
    // Common flow
    GetPage(
      name: AppRoutes.splashScreen,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: AppRoutes.loginScreen,
      page: () => LoginScreen(),
    ),
    GetPage(
      name: AppRoutes.signupScreen,
      page: () => const SignupScreen(),
    ),
    GetPage(
      name: AppRoutes.homeScreen,
      page: () => HomeScreen(),
    ),
    GetPage(
      name: AppRoutes.profileScreen,
      page: () => ProfileScreen(),
    ),
    GetPage(
      name: AppRoutes.sysInfoScreen,
      page: () => SystemInfoScreen(),
    ),
  ];
}
