import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qulip/common/assests.dart';
import 'package:qulip/common/colors.dart';
import 'package:qulip/common/strings.dart';
import 'package:qulip/common/widgets/my_text.dart';
import 'package:qulip/controller/profile_controller.dart';
import 'package:qulip/routes/app_pages.dart';
import 'package:qulip/routes/app_routes.dart';
import 'package:toggle_switch/toggle_switch.dart';

class CaseListScreen extends StatelessWidget {
  CaseListScreen({super.key});

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
          WordStrings.archivesLblHome,
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
          _forumTabBarItem(),
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

  Widget _forumTabBarItem() {
    return Expanded(
      child: ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) {
          return InkWell(
              onTap: () {
                Get.toNamed(AppRoutes.caseDetailsScreen);
              },
              child: _maincomment());
        },
      ),
    );
  }

  Widget _maincomment() {
    return Card(
      elevation: 4,
      child: Row(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const MyText(
                  'Case_123456',
                ).paddingSymmetric(horizontal: 4, vertical: 4),
                const Icon(
                  size: 15,
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ],
      ).paddingAll(10),
    );
  }
}
