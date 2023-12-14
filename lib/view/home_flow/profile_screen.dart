import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qulip/common/assests.dart';
import 'package:qulip/common/colors.dart';
import 'package:qulip/common/snack.dart';
import 'package:qulip/common/strings.dart';
import 'package:qulip/common/widgets/my_text.dart';
import 'package:qulip/routes/app_routes.dart';
import 'package:qulip/utils/storage_helper.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  // final controller = Get.put(LoginController());
  String link = "";
  @override
  Widget build(BuildContext context) {
    StorageHelper.read(StorageKeys.userData)
        .then((value) => {link = value['link']});
    return Scaffold(
      appBar: AppBar(
        backgroundColor: stdwhite,
        foregroundColor: yasRed,
        centerTitle: true,
        title: const MyText(
          WordStrings.profileLblHome,
          fontFamily: FontFamilyConstant.sinkinSans,
          fontSize: 18,
          fontColor: yasRed,
        ),
      ),
      backgroundColor: transparentGrey,
      body: WebViewWidget(
          controller: WebViewController()
            ..setJavaScriptMode(JavaScriptMode.unrestricted)
            ..setBackgroundColor(const Color(0x00000000))
            ..setNavigationDelegate(
              NavigationDelegate(
                onProgress: (int progress) {
                  // Update loading bar.
                },
                onPageStarted: (String url) {},
                onPageFinished: (String url) {},
                onWebResourceError: (WebResourceError error) {},
                onNavigationRequest: (NavigationRequest request) {
                  if (request.url.startsWith(
                      "https://civiltw-c0bb2554960c.herokuapp.com/main")) {
                    MySnackBar.successSnackbar(
                        WordStrings.profileUpdateSuccess);
                    Get.toNamed(AppRoutes.homeScreen);
                    return NavigationDecision.prevent;
                  }
                  return NavigationDecision.navigate;
                },
              ),
            )
            ..loadRequest(Uri.parse(link))),
      // body: SingleChildScrollView(
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     mainAxisAlignment: MainAxisAlignment.start,
      //     children: [
      //       SizedBox(
      //         height: Get.height * 0.06,
      //       ),
      //       MyTextField(
      //         enabled: false,
      //         readOnly: true,
      //         fullBorder: true,
      //         hasFloatingLabel: false,
      //         controller: controller.txtProfileAccount,
      //         maxLength: 10,
      //         keyboard: TextInputType.text,
      //         labelText: WordStrings.profileAccountNoLbl,
      //         hintText: WordStrings.profileAccountNoLbl,
      //       ).paddingSymmetric(vertical: 10.h),
      //       MyTextField(
      //         fullBorder: true,
      //         hasFloatingLabel: false,
      //         controller: controller.txtPassword,
      //         maxLength: 10,
      //         keyboard: TextInputType.text,
      //         labelText: WordStrings.profilePasswordLbl,
      //         hintText: WordStrings.profilePasswordLbl,
      //       ).paddingSymmetric(vertical: 10.h),
      //       MyTextField(
      //         fullBorder: true,
      //         hasFloatingLabel: false,
      //         controller: controller.txtProfileName,
      //         maxLength: 10,
      //         keyboard: TextInputType.text,
      //         labelText: WordStrings.profileNameLbl,
      //         hintText: WordStrings.profileNameLbl,
      //       ).paddingSymmetric(vertical: 10.h),
      //       MyTextField(
      //         fullBorder: true,
      //         hasFloatingLabel: false,
      //         controller: controller.txtProfileEmail,
      //         maxLength: 10,
      //         keyboard: TextInputType.text,
      //         labelText: WordStrings.profileEmailLbl,
      //         hintText: WordStrings.profileEmailLbl,
      //       ).paddingSymmetric(vertical: 10.h),
      //       MyTextField(
      //         fullBorder: true,
      //         hasFloatingLabel: false,
      //         controller: controller.txtProfileAddress,
      //         maxLength: 10,
      //         keyboard: TextInputType.text,
      //         labelText: WordStrings.profileAddressLbl,
      //         hintText: WordStrings.profileAddressLbl,
      //       ).paddingSymmetric(vertical: 10.h),
      //       MyTextField(
      //         fullBorder: true,
      //         hasFloatingLabel: false,
      //         controller: controller.txtProfileAffiUId,
      //         maxLength: 10,
      //         keyboard: TextInputType.text,
      //         labelText: WordStrings.profileUnitId,
      //         hintText: WordStrings.profileUnitId,
      //       ).paddingSymmetric(vertical: 10.h),
      //       Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //         children: [
      //           const MyText(
      //             WordStrings.pointLblHome,
      //             fontWeight: FontWeight.normal,
      //             fontFamily: FontFamilyConstant.sinkinSansMedium,
      //             fontSize: 12,
      //             fontColor: yasRed,
      //           ),
      //           Obx(() => MyText(
      //                 "${controller.userData.value.points} ${WordStrings.pointLblHome}",
      //                 fontWeight: FontWeight.w600,
      //                 fontFamily: FontFamilyConstant.sinkinSansMedium,
      //                 fontSize: 14,
      //                 fontColor: yasRed,
      //               )),
      //         ],
      //       ).paddingSymmetric(vertical: 4.h),
      //       SizedBox(
      //         height: Get.height * 0.04,
      //       ),
      //       MyButton(
      //         label: WordStrings.btnSaveLbl,
      //         style: const TextStyle(
      //           color: whiteTxt,
      //           fontWeight: FontWeight.bold,
      //         ),
      //         decoration: const BoxDecoration(
      //           color: yasRed,
      //           borderRadius: BorderRadius.all(Radius.circular(5)),
      //           boxShadow: [
      //             BoxShadow(
      //               blurRadius: 6,
      //               color: Colors.black54,
      //             )
      //           ],
      //         ),
      //         height: Get.height * 0.05,
      //         borderRadius: 2,
      //         onTap: () async {},
      //       ).paddingSymmetric(vertical: 10),
      //       // MyButton(
      //       //   label: WordStrings.btnCancelLbl,
      //       //   style: const TextStyle(
      //       //     color: whiteTxt,
      //       //     fontWeight: FontWeight.bold,
      //       //   ),
      //       //   decoration: const BoxDecoration(
      //       //     color: yasRed,
      //       //     borderRadius: BorderRadius.all(Radius.circular(5)),
      //       //     boxShadow: [
      //       //       BoxShadow(
      //       //         blurRadius: 6,
      //       //         color: Colors.black54,
      //       //       )
      //       //     ],
      //       //   ),
      //       //   height: Get.height * 0.05,
      //       //   borderRadius: 2,
      //       //   onTap: () async {},
      //       // )
      //     ],
      //   ),
      // ).paddingSymmetric(horizontal: 24.w, vertical: 4.h),
    );
  }
}
