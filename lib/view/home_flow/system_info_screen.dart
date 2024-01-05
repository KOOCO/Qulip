import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:qulip/common/assests.dart';
import 'package:qulip/common/colors.dart';
import 'package:qulip/common/strings.dart';
import 'package:qulip/common/widgets/my_button.dart';
import 'package:qulip/common/widgets/my_text.dart';
import 'package:qulip/controller/login_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class SystemInfoScreen extends StatelessWidget {
  SystemInfoScreen({super.key});

  final controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: stdwhite,
        foregroundColor: yasRed,
        centerTitle: true,
        title: const MyText(
          WordStrings.systemInfoLbl,
          fontFamily: FontFamilyConstant.sinkinSans,
          fontSize: 18,
          fontColor: yasRed,
        ),
      ),
      backgroundColor: transparentGrey,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: Get.height * 0.06,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const MyText(
                  WordStrings.versionLbl,
                  fontWeight: FontWeight.w400,
                  fontFamily: FontFamilyConstant.sinkinSansMedium,
                  fontSize: 14,
                  fontColor: stdgrey,
                ),
                FutureBuilder<PackageInfo>(
                  future: PackageInfo.fromPlatform(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.done:
                        return Align(
                          alignment: Alignment.bottomCenter,
                          child: MyText(
                            snapshot.data!.version,
                            fontWeight: FontWeight.normal,
                            fontFamily: FontFamilyConstant.sinkinSansMedium,
                            fontSize: 12,
                            fontColor: stdgrey,
                          ),
                          // Text(
                          //   'Version: ${snapshot.data!.version}',
                          // ),
                        );
                      default:
                        return const SizedBox();
                    }
                  },
                ),
              ],
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            const Divider(
              color: lightGrey,
              thickness: 1,
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyText(
                  WordStrings.copyRightLbl,
                  fontWeight: FontWeight.w400,
                  fontFamily: FontFamilyConstant.sinkinSansMedium,
                  fontSize: 14,
                  fontColor: stdgrey,
                ),
                MyText(
                  'Qulip Technology Inc.',
                  fontWeight: FontWeight.normal,
                  fontFamily: FontFamilyConstant.sinkinSansMedium,
                  fontSize: 12,
                  fontColor: stdgrey,
                )
              ],
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            const Divider(
              color: lightGrey,
              thickness: 1,
            ),
            Theme(
              data:
                  Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: const Column(
                children: [
                  ExpansionTile(
                    tilePadding: EdgeInsets.zero,
                    childrenPadding: EdgeInsets.zero,
                    trailing: Icon(
                      Icons.arrow_drop_down_outlined,
                      color: Colors.black,
                    ),
                    title: MyText(
                      WordStrings.specificationLbl,
                      fontWeight: FontWeight.normal,
                      fontFamily: FontFamilyConstant.sinkinSansMedium,
                      fontSize: 14,
                      fontColor: stdgrey,
                    ),
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: MyText(
                          WordStrings.specAndroidLbl,
                          fontWeight: FontWeight.normal,
                          fontFamily: FontFamilyConstant.sinkinSansMedium,
                          fontSize: 14,
                          fontColor: stdgrey,
                        ),
                        trailing: MyText(
                          '8.0 above versions',
                          fontWeight: FontWeight.normal,
                          fontFamily: FontFamilyConstant.sinkinSansMedium,
                          fontSize: 12,
                          fontColor: stdgrey,
                        ),
                      ),
                      Divider(
                        color: lightGrey,
                        thickness: 1,
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: MyText(
                          WordStrings.specSizeLbl,
                          fontWeight: FontWeight.normal,
                          fontFamily: FontFamilyConstant.sinkinSansMedium,
                          fontSize: 14,
                          fontColor: stdgrey,
                        ),
                        trailing: MyText(
                          'Above 10 inches',
                          fontWeight: FontWeight.normal,
                          fontFamily: FontFamilyConstant.sinkinSansMedium,
                          fontSize: 12,
                          fontColor: stdgrey,
                        ),
                      ),
                      Divider(
                        color: lightGrey,
                        thickness: 1,
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: MyText(
                          WordStrings.specCapacityLbl,
                          fontWeight: FontWeight.normal,
                          fontFamily: FontFamilyConstant.sinkinSansMedium,
                          fontSize: 14,
                          fontColor: stdgrey,
                        ),
                        trailing: MyText(
                          '128GB',
                          fontWeight: FontWeight.normal,
                          fontFamily: FontFamilyConstant.sinkinSansMedium,
                          fontSize: 12,
                          fontColor: stdgrey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: MyButton(
                height: Get.height * 0.04,
                width: Get.width * 0.35,
                label: WordStrings.checkUpdateLbl,
                style: const TextStyle(
                  fontSize: 12,
                  color: stdBlack,
                  fontWeight: FontWeight.w500,
                ),
                decoration: const BoxDecoration(
                  color: whiteTxt,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 6,
                      color: Colors.black26,
                    )
                  ],
                ),
                borderRadius: 2,
                onTap: () async {
                  if (Platform.isAndroid || Platform.isIOS) {
                    final appId = Platform.isAndroid
                        ? 'com.spotify.tv.android'
                        : 'id324684580';
                    final url = Uri.parse(
                      Platform.isAndroid
                          ? "market://details?id=$appId"
                          : "https://apps.apple.com/app/id$appId",
                    );
                    launchUrl(
                      url,
                      mode: LaunchMode.externalApplication,
                    );
                  }
                },
              ),
            )
          ],
        ),
      ).paddingSymmetric(horizontal: 24.w, vertical: 4.h),
    );
  }
}
