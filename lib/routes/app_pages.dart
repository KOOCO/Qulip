import 'package:get/get.dart';
import 'package:qulip/routes/app_routes.dart';
import 'package:qulip/view/case_create_survey/establish_case.dart';
import 'package:qulip/view/case_create_survey/survey_form_canvas_1.dart';
import 'package:qulip/view/case_create_survey/survey_form_step1.dart';
import 'package:qulip/view/home_flow/case_list/case_detail_screen.dart';
import 'package:qulip/view/home_flow/case_list/case_list_screen.dart';
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
    GetPage(
      name: AppRoutes.caseListScreen,
      page: () => CaseListScreen(),
    ),
    GetPage(
      name: AppRoutes.caseDetailsScreen,
      page: () => CaseDetailScreen(),
    ),
    GetPage(
      name: AppRoutes.caseCreateScreen,
      page: () => CreateCaseScreen(), //EstablishCaseScreen(),
    ),
    GetPage(
      name: AppRoutes.surveyForm1CreateScreen,
      page: () => SurveyFormStep1(),
    ),
    GetPage(
      name: AppRoutes.surveyForm2CreateScreen,
      page: () => SurveyCanvas(),
    ),
  ];
}
