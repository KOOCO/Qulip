import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:qulip/controller/login_controller.dart';
import 'package:qulip/firebase_options.dart';
import 'package:qulip/routes/app_pages.dart';
import 'package:qulip/routes/app_routes.dart';

Future<void> main() async {
  await GetStorage.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return ScreenUtilInit(
      builder: (context, child) => GetMaterialApp(
        themeMode: ThemeMode.light,
        debugShowCheckedModeBanner: false,
        getPages: AppPages.pages,
        title: '建物測量器',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        builder: (context, child) {
          SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
          ScreenUtil.init(context);
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: child!,
          );
        },
        initialRoute: AppRoutes.splashScreen, //AppRoutes.introScreen,
      ),
    );
  }
}
