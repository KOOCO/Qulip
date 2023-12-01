import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qulip/common/assests.dart';
import 'package:qulip/common/colors.dart';
import 'package:qulip/common/strings.dart';
import 'package:qulip/common/widgets/my_text.dart';
import 'package:qulip/controller/profile_controller.dart';
import 'package:toggle_switch/toggle_switch.dart';

class CaseDetailScreen extends StatelessWidget {
  CaseDetailScreen({super.key});

  final controller = Get.put(ProfileController());
  // List<String> list = ["Himadri", "Viral", "Sunny", "Ruhi", "Ridham"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: stdwhite,
        foregroundColor: yasRed,
        centerTitle: true,
        title: const MyText(
          WordStrings.caseDetailLbl,
          fontFamily: FontFamilyConstant.sinkinSans,
          fontSize: 18,
          fontColor: yasRed,
        ),
      ),
      backgroundColor: transparentGrey,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _forumTabBar().paddingSymmetric(vertical: 14.h),
        ],
      ).paddingSymmetric(horizontal: 14.w, vertical: 4.h),
    );
  }

  Widget _forumTabBar() {
    const Color activeColor = yasRed;
    const Color deActiveColor = lightGrey;

    return ToggleSwitch(
      minWidth: Get.width,
      fontSize: 16.0,
      initialLabelIndex: 0,
      activeBgColor: const [activeColor],
      activeFgColor: stdwhite,
      inactiveBgColor: deActiveColor,
      inactiveFgColor: stdBlack,
      totalSwitches: 3,
      borderWidth: 1,
      cornerRadius: 20.0,
      labels: const [
        WordStrings.allLbl,
        WordStrings.sixMonthLbl,
        WordStrings.threeMonthLbl
      ],
      onToggle: (index) {
        print('switc to: $index');
      },
    );
  }
}
