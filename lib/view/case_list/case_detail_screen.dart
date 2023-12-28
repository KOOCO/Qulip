import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qulip/common/assests.dart';
import 'package:qulip/common/colors.dart';
import 'package:qulip/common/strings.dart';
import 'package:qulip/common/widgets/my_button.dart';
import 'package:qulip/common/widgets/my_button_with_icon.dart';
import 'package:qulip/common/widgets/my_text.dart';
import 'package:qulip/controller/case_list_controller.dart';

class CaseDetailScreen extends StatelessWidget {
  CaseDetailScreen({super.key});

  final controller = Get.put(CaseListController());
  // List<String> list = ["Himadri", "Viral", "Sunny", "Ruhi", "Ridham"];

  @override
  Widget build(BuildContext context) {
    controller.getData();
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyText(
                  WordStrings.caseNoLbl,
                  fontFamily: FontFamilyConstant.sinkinSans,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  fontColor: yasRed,
                ),
                MyText(
                  "A123",
                  fontFamily: FontFamilyConstant.sinkinSans,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  fontColor: yasRed,
                ),
              ],
            ).paddingOnly(top: 15, bottom: 15),
            Divider(
              height: 1,
              thickness: 1,
              color: Colors.grey.shade400,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyText(
                  WordStrings.caseAddresslLbl,
                  fontFamily: FontFamilyConstant.sinkinSans,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  fontColor: yasRed,
                ),
                MyText(
                  "48, Parasmani Society",
                  fontFamily: FontFamilyConstant.sinkinSans,
                  fontWeight: FontWeight.w400,
                  maxLines: 2,
                  fontSize: 14,
                  fontColor: yasRed,
                ),
              ],
            ).paddingOnly(top: 15, bottom: 15),
            Divider(
              height: 1,
              thickness: 1,
              color: Colors.grey.shade400,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyText(
                  WordStrings.caseDatelLbl,
                  fontFamily: FontFamilyConstant.sinkinSans,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  fontColor: yasRed,
                ),
                MyText(
                  "12/Dec/2023",
                  fontFamily: FontFamilyConstant.sinkinSans,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  fontColor: yasRed,
                ),
              ],
            ).paddingOnly(top: 15, bottom: 15),
            Divider(
              height: 1,
              thickness: 1,
              color: Colors.grey.shade400,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyText(
                  WordStrings.caseEquipmentNamelLbl,
                  fontFamily: FontFamilyConstant.sinkinSans,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  fontColor: yasRed,
                ),
                MyText(
                  "TOPCONE LBL",
                  fontFamily: FontFamilyConstant.sinkinSans,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  fontColor: yasRed,
                ),
              ],
            ).paddingOnly(top: 15, bottom: 15),
            Divider(
              height: 1,
              thickness: 1,
              color: Colors.grey.shade400,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyText(
                  WordStrings.caseWeatherlLbl,
                  fontFamily: FontFamilyConstant.sinkinSans,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  fontColor: yasRed,
                ),
                MyText(
                  "Clear",
                  fontFamily: FontFamilyConstant.sinkinSans,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  fontColor: yasRed,
                ),
              ],
            ).paddingOnly(top: 15, bottom: 15),
            Divider(
              height: 1,
              thickness: 1,
              color: Colors.grey.shade400,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const MyText(
                  WordStrings.signatureLbl,
                  fontFamily: FontFamilyConstant.sinkinSans,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  fontColor: yasRed,
                ),
                const Icon(
                  Icons.edit,
                  color: yasRed,
                  size: 20,
                ).paddingAll(4)
              ],
            ).paddingOnly(top: 15, bottom: 15),
            Divider(
              height: 1,
              thickness: 1,
              color: Colors.grey.shade400,
            ).paddingOnly(bottom: 25),
            Column(
              children: [
                MyButtonWithIcon(
                  image: AssetImages.surveyLogo,
                  label: WordStrings.surveyformLblCaseDetails,
                  style: const TextStyle(
                    fontSize: 14,
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
                  height: Get.height * 0.06,
                  borderRadius: 2,
                  onTap: () async {},
                ).paddingSymmetric(horizontal: 20, vertical: 5),
                MyButtonWithIcon(
                  image: AssetImages.verticalLogo,
                  label: WordStrings.verticalMeasurementLblCaseDetails,
                  style: const TextStyle(
                    fontSize: 14,
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
                  height: Get.height * 0.06,
                  borderRadius: 2,
                  onTap: () async {},
                ).paddingSymmetric(horizontal: 20, vertical: 5),
                MyButtonWithIcon(
                  image: AssetImages.horizontalLogo,
                  label: WordStrings.horizontalMeasurementLblCaseDetails,
                  style: const TextStyle(
                    fontSize: 14,
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
                  height: Get.height * 0.06,
                  borderRadius: 2,
                  onTap: () async {},
                ).paddingSymmetric(horizontal: 20, vertical: 5),
              ],
            ).marginOnly(bottom: 15),
            MyButton(
              label: WordStrings.btnExprotLbl,
              style: const TextStyle(
                color: whiteTxt,
                fontWeight: FontWeight.bold,
              ),
              decoration: const BoxDecoration(
                color: yasRed,
                borderRadius: BorderRadius.all(Radius.circular(5)),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 6,
                    color: Colors.black54,
                  )
                ],
              ),
              height: Get.height * 0.05,
              borderRadius: 2,
              onTap: () async {},
            ).paddingAll(40),
          ],
        ).paddingSymmetric(horizontal: 14.w, vertical: 4.h),
      ),
    );
  }
}
