import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qulip/common/colors.dart';
import 'package:qulip/common/strings.dart';
import 'package:qulip/common/widgets/my_fill_button.dart';
import 'package:qulip/common/widgets/my_text.dart';
import 'package:qulip/utils/text_style_helper.dart';

class DialogBox {
  static dynamic updateDailog({
    required String title,
    required String message,
    required VoidCallback onTap,
  }) {
    Get.defaultDialog(
      title: title,
      middleText: message,
      barrierDismissible: false,
      onWillPop: () async {
        return false;
      },
      actions: [
        MyFillButton(
          onPressed: onTap,
          text: 'Update',
          height: 30.h,
        ),
      ],
    );
  }

  static void showCenterDialog({
    required BuildContext context,
    required Widget child,
    EdgeInsetsGeometry? margin,
    Decoration? decoration,
    bool barrierDismissible = false,
  }) {
    Get.dialog(
      Dialog(
        insetPadding: const EdgeInsets.all(20),
        backgroundColor: Colors.transparent,
        child: Container(
          clipBehavior: Clip.hardEdge,
          margin: margin,
          decoration: decoration ??
              BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
          child: child,
        ),
      ),
      barrierDismissible: barrierDismissible,
    );
  }

  static void showBottomDialog({
    required BuildContext context,
    required Widget child,
    BorderRadiusGeometry? borderRadius,
  }) {
    showGeneralDialog(
      barrierLabel: '',
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 600),
      context: context,
      pageBuilder: (context, anim1, anim2) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            //height: height,
            clipBehavior: Clip.hardEdge,
            //margin: MediaQuery.of(context).viewInsets,
            margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom + 15,
              left: 10,
              right: 10,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: borderRadius ?? BorderRadius.circular(30),
            ),
            child: child,
          ),
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position: Tween(
            begin: const Offset(0, 1),
            end: const Offset(0, 0),
          ).animate(anim1),
          child: child,
        );
      },
    );
  }

  static void showMultiSelectDialog({
    required BuildContext context,
    required List<String> list,
    required List<String> selectedList,
    required Function(List<String> values)? onSelect,
  }) {
    final selected = selectedList.obs;
    showGeneralDialog(
      barrierLabel: '',
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 600),
      context: context,
      pageBuilder: (context, anim1, anim2) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            //height: height,
            clipBehavior: Clip.hardEdge,
            //margin: MediaQuery.of(context).viewInsets,
            margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom + 15,
              left: 10,
              right: 10,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Material(
              child: Container(
                height: 270,
                color: stdwhite,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyText(
                          'Select Options',
                          fontStyle: MyTextTheme14Normal.black(),
                        ),
                        InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: const Icon(
                            Icons.close,
                            color: stdgrey,
                          ),
                        ),
                      ],
                    ).paddingSymmetric(horizontal: 15, vertical: 10),
                    const Divider(
                      height: 1,
                      thickness: 1,
                    ),
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: list.length,
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              if (selected.contains(list[index])) {
                                selected.remove(list[index]);
                              } else {
                                selected.add(list[index]);
                              }
                            },
                            child: Obx(
                              () => Card(
                                elevation: 2,
                                child: MyText(
                                  list[index],
                                  fontStyle: selected.contains(list[index])
                                      ? MyTextTheme14Bold.black()
                                      : MyTextTheme14Normal.grey(),
                                  textAlign: TextAlign.center,
                                ).paddingSymmetric(
                                  horizontal: 20,
                                  vertical: 10,
                                ),
                              ).paddingSymmetric(horizontal: 5),
                            ),
                          );
                        },
                      ),
                    ),
                    MyFillButton(
                      onPressed: () {
                        onSelect?.call(selected);
                        Get.back();
                      },
                      text: 'Done',
                    ).paddingAll(10),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position: Tween(
            begin: const Offset(0, 1),
            end: const Offset(0, 0),
          ).animate(anim1),
          child: child,
        );
      },
    );
  }

  static Future<void> selectImage(
    BuildContext context, {
    required Function(String filePath)? onComplete,
  }) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return MediaQuery(
          data: const MediaQueryData(),
          child: AlertDialog(
            // title: const MyText(
            //   WordStrings.selectImageLbl,
            //   fontColor: yasRed,
            //   fontSize: 14,
            //   fontWeight: FontWeight.w600,
            // ),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  ListTile(
                    onTap: () {
                      Get.back();
                      takePhoto(
                        source: ImageSource.gallery,
                        onComplete: onComplete,
                      );
                    },
                    title: const MyText(
                      WordStrings.galleryImageLbl,
                      fontColor: yasRed,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    leading: const Icon(
                      Icons.account_box,
                      color: yasRed,
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      Get.back();
                      takePhoto(
                        source: ImageSource.camera,
                        onComplete: onComplete,
                      );
                    },
                    title: const MyText(
                      WordStrings.cameraImageLbl,
                      fontColor: yasRed,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    leading: const Icon(
                      Icons.camera,
                      color: yasRed,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static Future<void> takePhoto({
    required ImageSource source,
    required Function(String filePath)? onComplete,
  }) async {
    try {
      final pickedImage = await ImagePicker().pickImage(
            source: source,
            imageQuality: 60,
          ) ??
          XFile('');
      // final CroppedFile? croppedFile = await ImageCropper().cropImage(
      //   sourcePath: pickedImage.path,
      //   aspectRatioPresets: [
      //     CropAspectRatioPreset.square,
      //   ],
      //   compressQuality: 80,
      //   maxWidth: 500,
      //   maxHeight: 500,
      //   aspectRatio: const CropAspectRatio(ratioX: 112, ratioY: 112),
      //   uiSettings: [
      //     AndroidUiSettings(
      //       toolbarTitle: 'Crop Profile',
      //       toolbarColor: yasRed,
      //       toolbarWidgetColor: Colors.white,
      //       activeControlsWidgetColor: yasRed,
      //       initAspectRatio: CropAspectRatioPreset.square,
      //       lockAspectRatio: true,
      //     ),
      //     IOSUiSettings(
      //       title: 'Crop Profile',
      //       aspectRatioLockDimensionSwapEnabled: true,
      //       aspectRatioPickerButtonHidden: true,
      //       aspectRatioLockEnabled: true,
      //       minimumAspectRatio: 1 / 1,
      //       rectHeight: 112,
      //       rectWidth: 112,
      //     ),
      //   ],
      // );
      // if (croppedFile == null) {
      //   throw Exception('Please crop image');
      // }
      // Get.back();
      final bytes = File(pickedImage.path).readAsBytesSync();
      debugPrint(bytes.toString());
      onComplete?.call(pickedImage.path);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
