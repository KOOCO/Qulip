import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qulip/common/assests.dart';
import 'package:qulip/common/colors.dart';
import 'package:qulip/common/snack.dart';
import 'package:qulip/common/strings.dart';
import 'package:qulip/common/widgets/my_button.dart';
import 'package:qulip/common/widgets/my_dropdown_area.dart';
import 'package:qulip/common/widgets/my_text.dart';
import 'package:qulip/controller/establish_case_controller.dart';
import 'package:qulip/models/createcase/establish_case_model.dart';
import 'package:qulip/routes/app_routes.dart';
import 'package:qulip/utils/datetime_helper.dart';
import 'package:qulip/utils/storage_helper.dart';
import 'package:qulip/utils/text_style_helper.dart';

class SurveyFormStep1 extends StatelessWidget {
  SurveyFormStep1({super.key});

  final controller = Get.put(EstablishCaseController());
  final enteredText = ''.obs;
  var userId = "";
  @override
  Widget build(BuildContext context) {
    StorageHelper.read(StorageKeys.userId).then((value) => {userId = value});
    return Scaffold(
      appBar: AppBar(
        backgroundColor: stdwhite,
        foregroundColor: yasRed,
        centerTitle: true,
        title: MyText(
          "${controller.txtCaseName.text}_${WordStrings.surveyFormCreatelLbl}",
          fontFamily: FontFamilyConstant.sinkinSans,
          fontSize: 18,
          fontColor: yasRed,
        ),
      ),
      backgroundColor: stdwhite,
      body: SingleChildScrollView(
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const MyText(
                WordStrings.sfStructurelLbl,
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
                    items: controller.structureList.map((element) {
                      return DropdownMenuItem<String>(
                        value: element,
                        child: MyText(
                          element,
                          fontStyle: MyTextTheme14Normal.black(),
                        ),
                      );
                    }).toList(),
                    selectedItemBuilder: (context) {
                      return controller.structureList
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
                    value: controller.selectedStructure.value,
                    onchange: (value) {
                      if (value != null) {
                        controller.selectedStructure.value = value;
                      }
                    },
                  ),
                ),
              ),
              const MyText(
                WordStrings.sfUseLbl,
                fontWeight: FontWeight.w400,
                fontFamily: FontFamilyConstant.sinkinSansMedium,
                fontColor: yasRed,
              ).paddingOnly(top: 10, left: 2, right: 2, bottom: 4),
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
                    items: controller.useList.map((element) {
                      return DropdownMenuItem<String>(
                        value: element,
                        child: MyText(
                          element,
                          fontStyle: MyTextTheme14Normal.black(),
                        ),
                      );
                    }).toList(),
                    selectedItemBuilder: (context) {
                      return controller.useList
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
                    value: controller.selectedUse.value,
                    onchange: (value) {
                      if (value != null) {
                        controller.selectedUse.value = value;
                      }
                    },
                  ),
                ),
              ),
              const MyText(
                WordStrings.sfWallLbl,
                fontWeight: FontWeight.w400,
                fontFamily: FontFamilyConstant.sinkinSansMedium,
                fontColor: yasRed,
              ).paddingOnly(top: 10, left: 2, right: 2, bottom: 4),
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
                    items: controller.wallList.map((element) {
                      return DropdownMenuItem<String>(
                        value: element,
                        child: MyText(
                          element,
                          fontStyle: MyTextTheme14Normal.black(),
                        ),
                      );
                    }).toList(),
                    selectedItemBuilder: (context) {
                      return controller.wallList
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
                    value: controller.selectedWall.value,
                    onchange: (value) {
                      if (value != null) {
                        controller.selectedWall.value = value;
                      }
                    },
                  ),
                ),
              ),
              const MyText(
                WordStrings.sfFlatTopMaterialLbl,
                fontWeight: FontWeight.w400,
                fontFamily: FontFamilyConstant.sinkinSansMedium,
                fontColor: yasRed,
              ).paddingOnly(top: 10, left: 2, right: 2, bottom: 4),
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
                    items: controller.flatTopMaterialList.map((element) {
                      return DropdownMenuItem<String>(
                        value: element,
                        child: MyText(
                          element,
                          fontStyle: MyTextTheme14Normal.black(),
                        ),
                      );
                    }).toList(),
                    selectedItemBuilder: (context) {
                      return controller.flatTopMaterialList
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
                    value: controller.selectedFlatTopMaterial.value,
                    onchange: (value) {
                      if (value != null) {
                        controller.selectedFlatTopMaterial.value = value;
                      }
                    },
                  ),
                ),
              ),
              const MyText(
                WordStrings.sfFloorMaterialLbl,
                fontWeight: FontWeight.w400,
                fontFamily: FontFamilyConstant.sinkinSansMedium,
                fontColor: yasRed,
              ).paddingOnly(top: 10, left: 2, right: 2, bottom: 4),
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
                    items: controller.floorList.map((element) {
                      return DropdownMenuItem<String>(
                        value: element,
                        child: MyText(
                          element,
                          fontStyle: MyTextTheme14Normal.black(),
                        ),
                      );
                    }).toList(),
                    selectedItemBuilder: (context) {
                      return controller.floorList
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
                    value: controller.selectedFloor.value,
                    onchange: (value) {
                      if (value != null) {
                        controller.selectedFloor.value = value;
                      }
                    },
                  ),
                ),
              ),
              const MyText(
                WordStrings.sfDescriptionLbl,
                fontWeight: FontWeight.w400,
                fontFamily: FontFamilyConstant.sinkinSansMedium,
                fontColor: yasRed,
              ).paddingOnly(top: 10, left: 2, right: 2, bottom: 4),
              TextField(
                maxLength: 50,
                maxLines: 3,
                cursorColor: yasRed,
                onChanged: (value) {
                  enteredText.value = value;
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
                    counterText: '${enteredText.value.length.toString()}/ 50',
                    counterStyle: const TextStyle(fontSize: 12, color: yasRed)),
              ),
              SizedBox(
                height: Get.height * 0.15,
              ),
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
                  if (controller.selectedStructure.value ==
                      WordStrings.selectStructure.toString()) {
                    MySnackBar.errorSnackbar(WordStrings.errStructure);
                    return;
                  }

                  if (controller.selectedUse.value == WordStrings.selectUse.toString()) {
                    MySnackBar.errorSnackbar(WordStrings.errUse);
                    return;
                  }

                  if (controller.selectedWall.value == WordStrings.selectWall.toString()) {
                    MySnackBar.errorSnackbar(WordStrings.errWall);
                    return;
                  }

                  if (controller.selectedFlatTopMaterial.value ==
                      WordStrings.selectFTop.toString()) {
                    MySnackBar.errorSnackbar(WordStrings.errFTop);
                    return;
                  }

                  if (controller.selectedFloor.value ==
                      WordStrings.selectFloor.toString()) {
                    MySnackBar.errorSnackbar(WordStrings.errFloor);
                    return;
                  }
                  
                  Get.toNamed(AppRoutes.surveyForm2CreateScreen);

                  
                  // "${controller.txtCaseName.value.text}_${getCaseNumber()}",
                  // final now = DateTime.now();
                  // controller.caseId.value =
                  //     "${now.caseGeneratorDateFormate()}_${controller.txtCaseName.value.text}";

                  // final caseModel = EstablishCaseModel(
                  //   id: controller.caseId.value,
                  //   createdAt: now.caseGeneratorDateFormate(),
                  //   userId: userId,
                  //   caseLable: controller.caseId.value,
                  //   caseName: controller.txtCaseName.value.text,
                  //   caseAddress: controller.txtCaseAddress.value.text,
                  //   caseDate: controller.txtCaseDate.value.text,
                  //   caseEquipmentNo: controller.txtCaseEquipmentName.value.text,
                  //   caseWeather: controller.txtCaseWeather.value.text,
                  //   wsStructureType: controller.selectedStructure.value,
                  //   wsUseFor: controller.selectedUse.value,
                  //   wsWallType: controller.selectedWall.value,
                  //   wsFlatTopMaterial: controller.selectedFlatTopMaterial.value,
                  //   wsFloorMaterial: controller.selectedFloor.value,
                  //   wsTechDescription:
                  //       controller.txtSupplimentryDesc.value.text,
                  //   wsWeentileDataList: [],
                  // );
                  // controller.storeWeentialStep1Data(caseModel);
                },
              )
            ],
          ).paddingOnly(top: 20.h).paddingSymmetric(horizontal: 14.w),
        ),
      ),
    );
  }
}
