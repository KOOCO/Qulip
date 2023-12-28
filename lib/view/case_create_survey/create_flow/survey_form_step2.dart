import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:qulip/common/assests.dart';
import 'package:qulip/common/colors.dart';
import 'package:qulip/common/strings.dart';
import 'package:qulip/common/widgets/my_button.dart';
import 'package:qulip/common/widgets/my_dropdown_area.dart';
import 'package:qulip/common/widgets/my_text.dart';
import 'package:qulip/common/widgets/my_textfield.dart';
import 'package:qulip/controller/establish_case_controller.dart';
import 'package:qulip/models/createcase/weential_survey_data2_model.dart';
import 'package:qulip/routes/app_routes.dart';
import 'package:qulip/utils/text_style_helper.dart';

class SurveyFormStep2 extends StatelessWidget {
  SurveyFormStep2({super.key});

  final controller = Get.put(EstablishCaseController());
  DateTime sDate = DateTime.now();
  RxString enteredTechDesc = ''.obs;
  final isImageSelect = false.obs;

  @override
  Widget build(BuildContext context) {
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Obx(() => _addMoreList(context)),
          MyButton(
            label: WordStrings.newMeasuringPointNumber,
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
              controller.addSurveyForm2ValidatationForm();
            },
          ).paddingAll(10),
          MyButton(
            label: WordStrings.nextLbl,
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
              var dataWeentialSurveyData2 = WeentialSurveyData2Model(
                id:"Weentail Survey Form 2",
                wsLocation: controller.selectedLocation.value,
                wsSituation: controller.txtSituation.value.text,
                wsCrackedLength: controller.txtCrackLength.value.text,
                wsCrackedWidth: controller.txtCrackWidth.value.text,
                wsFlaw: controller.selectedFlaw.value,
                wsTechDescr: controller.txtTechDesc.value.text,
                wsImages: controller.photoList
              );
              controller.storeSurveyForm2ValidatationForm(dataWeentialSurveyData2);
            },
          ).paddingAll(10).marginOnly(bottom: 10),
        ],
      ).paddingOnly(top: 20.h).paddingSymmetric(horizontal: 12.w),
    );
  }

  Widget _addMoreList(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        // physics: const PositionRetainedScrollPhysics(shouldRetain: false),
        itemCount: controller.addNewDataList.length,
        itemBuilder: (context, index) {
          return _buildExpandableList(
              context, controller.addNewDataList[index]);
        },
      ),
    );
  }

  Widget _buildExpandableList(BuildContext context, int number) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.antiAlias,
      child: Container(
        color: cardBg,
        child: ExpansionTile(
          initiallyExpanded: false,
          // initiallyExpanded: number == 1 ? true : false,
          trailing: const Icon(
            Icons.arrow_drop_down,
            color: yasRed,
          ),
          title: MyText(
            "Number $number",
            fontFamily: FontFamilyConstant.sinkinSans,
            fontSize: 14,
            fontColor: yasRed,
          ),
          children: [_buildListItem(context)],
        ),
      ),
    );
  }

  Widget _buildListItem(BuildContext context) {
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
          Obx(
            () => Container(
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
                      // debugPrint(
                      //     "Selected Value >> ${controller.selectedLocation.value}");
                    }
                  },
                ),
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
            keyboard: TextInputType.number,
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
            keyboard: TextInputType.number,
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
          Obx(
            () => Container(
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
            controller: controller.txtTechDesc,
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
                      controller.takePhoto(context);
                    },
                    child: Visibility(
                      child: Align(
                        alignment: controller.photoList.isEmpty
                            ? Alignment.center
                            : Alignment.topRight,
                        heightFactor: controller.photoList.isEmpty ? 4.0 : 1.0,
                        child: Icon(
                          Icons.add_a_photo,
                          color: yasRed,
                          size: controller.photoList.isEmpty ? 50 : 25,
                        ).paddingAll(4),
                      ),
                    ),
                  ),
                ),
                Obx(
                  () => Visibility(
                    visible: controller.photoList.isNotEmpty ? true : false,
                    child: _buildImageList(),
                  ),
                )
              ],
            ),
          ),
        ],
      ).paddingAll(6),
    );
  }

  Widget _buildImageList() {
    return Expanded(
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: controller.photoList.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildImageItem(context, index);
        },
      ),
    );
  }

  Widget _buildImageItem(BuildContext context, int index) {
    return Container(
      height: double.infinity,
      alignment: Alignment.center,
      // width:
      // (controller.photoList.length == 1) ? Get.width - 60 : Get.width - 220,
      decoration: BoxDecoration(
        color: stdwhite,
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        border: Border.all(
          width: 1,
          color: yasRed,
        ),
      ),
      child: Obx(
        () => InkWell(
          child: Stack(children: [
            Center(
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                child: Image.file(
                  fit: BoxFit.contain,
                  File(controller.photoList[index]),
                ),
              ),
            ),
            Positioned(
                right: -8,
                top: -6,
                child: Obx(
                  () => InkWell(
                    onTap: () {
                      controller.photoList.removeAt(index);
                    },
                    child: Visibility(
                      visible:
                          controller.photoList[index].isNotEmpty ? true : false,
                      child: const Icon(
                        Icons.cancel,
                        color: Colors.red,
                        size: 18,
                      ).paddingAll(10),
                    ),
                  ),
                ))
          ]),
        ),
      ),
    ).paddingAll(4);
  }
}
