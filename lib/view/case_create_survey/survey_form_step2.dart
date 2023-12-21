import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qulip/common/assests.dart';
import 'package:qulip/common/colors.dart';
import 'package:qulip/common/strings.dart';
import 'package:qulip/common/widgets/my_dropdown_area.dart';
import 'package:qulip/common/widgets/my_text.dart';
import 'package:qulip/common/widgets/my_textfield.dart';
import 'package:qulip/controller/establish_case_controller.dart';
import 'package:qulip/utils/text_style_helper.dart';

class SurveyFormStep2 extends StatelessWidget {
  SurveyFormStep2({super.key});

  final controller = Get.put(EstablishCaseController());
  DateTime sDate = DateTime.now();
  RxString enteredTechDesc = ''.obs;
  final isImageSelect = false.obs;

  @override
  Widget build(BuildContext context) {
    debugPrint("Size>> ${controller.photoList.length}");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: stdwhite,
        foregroundColor: yasRed,
        centerTitle: true,
        title: const MyText(
          "${WordStrings.surveyFormCreatelLbl}- 2",
          fontFamily: FontFamilyConstant.sinkinSans,
          fontSize: 18,
          fontColor: yasRed,
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.image,
              color: yasRed,
            ),
            onPressed: () {
              //controller.takePhoto(context);
            },
          )
        ],
      ),
      backgroundColor: stdwhite,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              clipBehavior: Clip.antiAlias,
              child: Container(
                color: cardBg,
                child: ExpansionTile(
                  initiallyExpanded: true,
                  trailing: const Icon(
                    Icons.arrow_drop_down,
                    color: yasRed,
                  ),
                  title: const MyText(
                    "Number 1",
                    fontFamily: FontFamilyConstant.sinkinSans,
                    fontSize: 14,
                    fontColor: yasRed,
                  ),
                  children: <Widget>[_buildItem(context)],
                ),
              ),
            ),
          ],
        ).paddingOnly(top: 20.h).paddingSymmetric(horizontal: 12.w),
      ),
    );
  }

  Widget _buildItem(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: cardBg,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const MyText(
            WordStrings.locationLbl,
            fontWeight: FontWeight.w400,
            fontFamily: FontFamilyConstant.sinkinSansMedium,
            fontColor: yasRed,
          ).paddingOnly(left: 2, right: 2, bottom: 4),
          Container(
            height: 35.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: stdwhite,
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              border: Border.all(
                width: 0.5,
                color: yasRed,
              ),
              boxShadow: const [
                BoxShadow(
                  blurRadius: 2,
                  color: yasRed,
                )
              ],
            ),
            child: DropdownButtonHideUnderline(
              child: MyDropDownArea(
                iconColor: lightGrey,
                isExpanded: false,
                items: controller.locationList.map((element) {
                  return DropdownMenuItem<String>(
                    value: element,
                    child: MyText(
                      element,
                      fontStyle: MyTextTheme14Normal.black(),
                    ),
                  );
                }).toList(),
                selectedItemBuilder: (context) {
                  return controller.locationList
                      .map(
                        (element) => Container(
                          height: 25,
                          alignment: Alignment.centerLeft,
                          child: MyText(
                            element,
                            fontStyle: MyTextTheme14Normal.black(),
                          ),
                        ),
                      )
                      .toList();
                },
                value: controller.selectedLocation.value,
                onchange: (value) {
                  if (value != null) {
                    controller.selectedLocation.value = value;
                  }
                },
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          MyTextField(
            fullBorder: true,
            hasFloatingLabel: false,
            controller: controller.txtSituation,
            keyboard: TextInputType.text,
            labelText: WordStrings.situationLbl,
            hintText: WordStrings.situationLbl,
          ),
          const SizedBox(
            height: 15,
          ),
          MyTextField(
            fullBorder: true,
            hasFloatingLabel: false,
            controller: controller.txtCrackLength,
            keyboard: TextInputType.text,
            labelText: WordStrings.crackLengthLbl,
            hintText: WordStrings.crackLengthLbl,
          ),
          const SizedBox(
            height: 15,
          ),
          MyTextField(
            fullBorder: true,
            hasFloatingLabel: false,
            controller: controller.txtCrackWidth,
            keyboard: TextInputType.text,
            labelText: WordStrings.crackWidthLbl,
            hintText: WordStrings.crackWidthLbl,
          ),
          const SizedBox(
            height: 15,
          ),
          const MyText(
            WordStrings.flawLbl,
            fontWeight: FontWeight.w400,
            fontFamily: FontFamilyConstant.sinkinSansMedium,
            fontColor: yasRed,
          ).paddingOnly(left: 2, right: 2),
          Container(
            height: 35.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: stdwhite,
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              border: Border.all(
                width: 0.5,
                color: yasRed,
              ),
              boxShadow: const [
                BoxShadow(
                  blurRadius: 2,
                  color: yasRed,
                )
              ],
            ),
            child: DropdownButtonHideUnderline(
              child: MyDropDownArea(
                iconColor: lightGrey,
                isExpanded: false,
                items: controller.flawList.map((element) {
                  return DropdownMenuItem<String>(
                    value: element,
                    child: MyText(
                      element,
                      fontStyle: MyTextTheme14Normal.black(),
                    ),
                  );
                }).toList(),
                selectedItemBuilder: (context) {
                  return controller.flawList
                      .map(
                        (element) => Container(
                          height: 25,
                          alignment: Alignment.centerLeft,
                          child: MyText(
                            element,
                            fontStyle: MyTextTheme14Normal.black(),
                          ),
                        ),
                      )
                      .toList();
                },
                value: controller.selectedFlaw.value,
                onchange: (value) {
                  if (value != null) {
                    controller.selectedFlaw.value = value;
                  }
                },
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          const MyText(
            WordStrings.sfDescriptionLbl,
            fontWeight: FontWeight.w400,
            fontFamily: FontFamilyConstant.sinkinSansMedium,
            fontColor: yasRed,
          ).paddingOnly(left: 2, right: 2, bottom: 4),
          TextField(
            maxLength: 50,
            maxLines: 3,
            cursorColor: yasRed,
            onChanged: (value) {
              enteredTechDesc.value = value;
            },
            decoration: InputDecoration(
                alignLabelWithHint: true,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: yasRed),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                border: const OutlineInputBorder(
                  borderSide: BorderSide(color: yasRed),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: yasRed),
                ),
                floatingLabelStyle: const TextStyle(color: yasRed),
                labelText: WordStrings.sfDescriptionHint,
                labelStyle: const TextStyle(fontSize: 14, color: stdgrey),
                hintText: '',
                counterText: '${enteredTechDesc.value.length.toString()}/ 50',
                counterStyle: const TextStyle(fontSize: 12, color: yasRed)),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            width: double.infinity,
            height: Get.height * 0.30,
            decoration: BoxDecoration(
              color: stdwhite,
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              border: Border.all(
                width: 1,
                color: yasRed,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Obx(
                  () => InkWell(
                    onTap: () {
                      controller.photoList.removeLast();
                    },
                    child: Visibility(
                      visible: controller.photoList.isNotEmpty ? false : false,
                      // visible: controller.photoList.isNotEmpty ? true : false,
                      child: const Icon(
                        Icons.delete,
                        color: yasRed,
                        size: 25,
                      ).paddingAll(10),
                    ),
                  ),
                ),
                Obx(
                  () => InkWell(
                    onTap: () {
                      //controller.takePhoto(context);
                    },
                    child: Visibility(
                      // visible: controller.photoList.isNotEmpty ? false : true,
                      visible: controller.photoList.isNotEmpty ? true : true,
                      child: Center(
                        heightFactor: 3.0,
                        child: const Icon(
                          Icons.image_search,
                          color: yasRed,
                          size: 50,
                        ).paddingAll(10),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: controller.photoList.isNotEmpty ? true : false,
                  child: _buildImageList(),
                )
              ],
            ),
          ),
        ],
      ).paddingAll(6),
    );
  }

  Widget _buildImageList() {
    return Obx(
      () => ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: controller.photoList.length,
        itemBuilder: (BuildContext context, int index) {
          return SizedBox(
            height: 100,
            width: 100,
            child: Row(
              children: [Image.file(File(controller.photoList.first))],
            ),
          );
        },
      ),
    );
  }
}
