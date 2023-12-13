import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qulip/common/assests.dart';
import 'package:qulip/common/colors.dart';
import 'package:qulip/common/widgets/my_text.dart';
import 'package:qulip/controller/establish_case_controller.dart';

class SurveyCanvas extends StatelessWidget {
  SurveyCanvas({super.key});

  final controller = Get.put(EstablishCaseController());
  DateTime sDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: stdwhite,
        foregroundColor: yasRed,
        centerTitle: true,
        title: const MyText(
          "Survey Form 2 - Canvas",
          fontFamily: FontFamilyConstant.sinkinSans,
          fontSize: 18,
          fontColor: yasRed,
        ),
      ),
      backgroundColor: stdwhite,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const MyText("Survey Form 2 - Canvas")
                .paddingSymmetric(vertical: 10.h),
          ],
        ).paddingOnly(top: 20.h).paddingSymmetric(horizontal: 20.w),
      ),
    );
  }
}
