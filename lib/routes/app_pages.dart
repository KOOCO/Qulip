import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:get/get.dart';
import 'package:qulip/routes/app_routes.dart';
import 'package:qulip/view/case_create_survey/create_flow/suvery_canvas.dart';
import 'package:qulip/view/case_create_survey/horizontal_form/horizontal_mesurment_1.dart';
import 'package:qulip/view/case_create_survey/horizontal_form/horizontal_mesurment_2.dart';
import 'package:qulip/view/case_create_survey/vertical_form/vertical_canvas_1.dart';
import 'package:qulip/view/case_create_survey/vertical_form/vertical_mesurment_1.dart';
import 'package:qulip/view/case_create_survey/create_flow/establish_case.dart';
import 'package:qulip/view/case_create_survey/create_flow/survey_form_step1.dart';
import 'package:qulip/view/case_create_survey/create_flow/survey_form_step2.dart';
import 'package:qulip/view/case_create_survey/view_canvas.dart';
import 'package:qulip/view/case_list/case_detail_screen.dart';
import 'package:qulip/view/case_list/case_list_screen.dart';
import 'package:qulip/view/case_list/case_signature.dart';
import 'package:qulip/view/case_list/horizontal_view_form.dart';
import 'package:qulip/view/case_list/pdf_view_screen.dart';
import 'package:qulip/view/case_list/survey_view_form.dart';
import 'package:qulip/view/case_list/vertical_view_form.dart';
import 'package:qulip/view/home_flow/home_screen.dart';
import 'package:qulip/view/home_flow/pdf_preview.dart';
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
      name: AppRoutes.surveyViewScreen,
      page: () => SurveyViewForm(),
    ),
    GetPage(
      name: AppRoutes.verticalViewScreen,
      page: () => VerticalViewScreen(),
    ),
    GetPage(
      name: AppRoutes.horizontalViewScreen,
      page: () => HorizontalViewScreen(),
    ),
    GetPage(
      name: AppRoutes.signatureScreen,
      page: () => const SignatureScreen(),
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
      page: () => SurveyFormStep2(),
    ),
    GetPage(
      name: AppRoutes.surveyFormVerticalScreen,
      page: () => VerticalMeasurement1(),
    ),
    GetPage(
      name: AppRoutes.horizontalCase1Screen,
      page: () => HorizontalMeasurement1(),
    ),
    GetPage(
      name: AppRoutes.horizontalCase2Screen,
      page: () => HorizontalMeasurement2(),
    ),
    GetPage(
      name: AppRoutes.pdfPreview,
      page: () => PdfPreviewPage(),
    ),
    GetPage(
      name: AppRoutes.pdfView,
      page: () => PdfViewPage(),
    ),
    GetPage(
      name: AppRoutes.surveyCanvasView,
      page: () => const SurveyCanvas(),
    ),
    GetPage(
      name: AppRoutes.verticalCanvas1View,
      page: () => VerticalCanvas1(),
    ),
    GetPage(
      name: AppRoutes.viewCanvasImage,
      page: () => ViewCanvas(),
    ),
  ];
}
