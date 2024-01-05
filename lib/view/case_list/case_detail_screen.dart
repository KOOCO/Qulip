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
import 'package:qulip/routes/app_routes.dart';
import 'package:qulip/utils/storage_helper.dart';

class CaseDetailScreen extends StatelessWidget {
  CaseDetailScreen({super.key});

  final controller = Get.find<CaseListController>();
  // final signUrl = "".obs;

  @override
  Widget build(BuildContext context) {
    var index = Get.arguments;
    var modelData = controller.caseListNew[index];
    controller.isPDFExported.value = modelData.isPdfExported ?? false;
    controller.signUrl.value = modelData.signatureUrl ?? "";

    return Scaffold(
      appBar: AppBar(
        backgroundColor: stdwhite,
        foregroundColor: yasRed,
        centerTitle: true,
        title: MyText(
          modelData.caseLable!,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const MyText(
                  WordStrings.caseNoLbl,
                  fontFamily: FontFamilyConstant.sinkinSans,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontColor: yasRed,
                ),
                Flexible(
                  child: MyText(
                    modelData.caseName!,
                    fontFamily: FontFamilyConstant.sinkinSans,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    fontColor: yasRed,
                    textAlign: TextAlign.right,
                  ),
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
                  WordStrings.caseAddresslLbl,
                  fontFamily: FontFamilyConstant.sinkinSans,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontColor: yasRed,
                ),
                Flexible(
                  child: MyText(
                    modelData.caseAddress!,
                    fontFamily: FontFamilyConstant.sinkinSans,
                    fontWeight: FontWeight.w400,
                    maxLines: 2,
                    fontSize: 14,
                    textAlign: TextAlign.right,
                    fontColor: yasRed,
                  ),
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
                  WordStrings.caseDatelLbl,
                  fontFamily: FontFamilyConstant.sinkinSans,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontColor: yasRed,
                ),
                Flexible(
                  child: MyText(
                    modelData.caseDate!,
                    fontFamily: FontFamilyConstant.sinkinSans,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    fontColor: yasRed,
                    textAlign: TextAlign.right,
                  ),
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
                  WordStrings.caseEquipmentNamelLbl,
                  fontFamily: FontFamilyConstant.sinkinSans,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontColor: yasRed,
                ),
                Flexible(
                  child: MyText(
                    modelData.caseEquipmentNo!,
                    fontFamily: FontFamilyConstant.sinkinSans,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    fontColor: yasRed,
                    textAlign: TextAlign.right,
                  ),
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
                  WordStrings.caseWeatherlLbl,
                  fontFamily: FontFamilyConstant.sinkinSans,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontColor: yasRed,
                ),
                Flexible(
                  child: MyText(
                    modelData.caseWeather!,
                    fontFamily: FontFamilyConstant.sinkinSans,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    fontColor: yasRed,
                    textAlign: TextAlign.right,
                  ),
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
                  fontWeight: FontWeight.w600,
                  fontColor: yasRed,
                ),
                Obx(
                  () => controller.signUrl.value.isEmpty
                      ? InkWell(
                          onTap: () {
                            Get.toNamed(AppRoutes.signatureScreen,
                                arguments: modelData.caseLable);
                          },
                          child: const Icon(
                            Icons.edit,
                            color: yasRed,
                            size: 20,
                          ).paddingAll(4),
                        )
                      : Image.network(
                          controller.signUrl.value,
                          fit: BoxFit.fill,
                          width: 150,
                          height: 65,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) return child;
                            return SizedBox(
                              width: 150,
                              height: 65,
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: yasRed,
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              ),
                            );
                          },
                        ),
                )
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
                  onTap: () {
                    Get.toNamed(AppRoutes.surveyViewScreen, arguments: index);
                  },
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
                  onTap: () async {
                    Get.toNamed(AppRoutes.verticalViewScreen, arguments: index);
                  },
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
                  onTap: () async {
                    Get.toNamed(AppRoutes.horizontalViewScreen,
                        arguments: index);
                  },
                ).paddingSymmetric(horizontal: 20, vertical: 5),
              ],
            ).marginOnly(bottom: 15),
            Obx(
              () => Visibility(
                visible: controller.isPDFExported.value ? false : true,
                child: MyButton(
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
                  onTap: () async {
                    showWarningForExport(context,
                        WordStrings.viewExportDialogMsg, modelData.caseLable!);
                  },
                ).paddingAll(40),
              ),
            ),
          ],
        ).paddingSymmetric(horizontal: 14.w, vertical: 4.h),
      ),
    );
  }

  Future showWarningForExport(
          BuildContext context, String message, String caseId) async =>
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const MyText(
                  WordStrings.exitAppTitle,
                  fontSize: 18,
                  fontColor: yasRed,
                  fontWeight: FontWeight.bold,
                ),
                content: MyText(
                  message,
                  fontSize: 14,
                  fontColor: stdBlack,
                ),
                actions: [
                  Row(
                    children: [
                      MyButton(
                        label: WordStrings.btnYes,
                        style: const TextStyle(
                          color: whiteTxt,
                          fontWeight: FontWeight.bold,
                        ),
                        height: Get.height * 0.03,
                        width: Get.width * 0.2,
                        borderRadius: 2,
                        onTap: () {
                          controller.setLoading(true);
                          StorageHelper.read(StorageKeys.phoneNumber).then(
                              (value) => controller.getPoints(value, caseId));
                          Get.back();
                        },
                      )..paddingOnly(left: 4, right: 4),
                      const Spacer(),
                      MyButton(
                        label: WordStrings.btnNo,
                        style: const TextStyle(
                          color: whiteTxt,
                          fontWeight: FontWeight.bold,
                        ),
                        height: Get.height * 0.03,
                        width: Get.width * 0.2,
                        borderRadius: 2,
                        onTap: () {
                          controller.isPDFExported.value = false;
                          Get.back();
                        },
                      ).paddingOnly(left: 4, right: 4),
                    ],
                  ).paddingOnly(left: 10, right: 10, top: 4, bottom: 10),
                ],
              ));
}
