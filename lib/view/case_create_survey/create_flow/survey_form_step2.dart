import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qulip/common/assests.dart';
import 'package:qulip/common/colors.dart';
import 'package:qulip/common/snack.dart';
import 'package:qulip/common/strings.dart';
import 'package:qulip/common/widgets/my_button.dart';
import 'package:qulip/common/widgets/my_dropdown_area.dart';
import 'package:qulip/common/widgets/my_image.dart';
import 'package:qulip/common/widgets/my_text.dart';
import 'package:qulip/common/widgets/my_textfield.dart';
import 'package:qulip/controller/establish_case_controller.dart';
import 'package:qulip/models/createcase/weential/weential_data_model.dart';
import 'package:qulip/routes/app_routes.dart';
import 'package:qulip/utils/dailog_helper.dart';
import 'package:qulip/utils/text_style_helper.dart';

class SurveyFormStep2 extends StatefulWidget {
  SurveyFormStep2({super.key});

  @override
  State<SurveyFormStep2> createState() => _SurveyFormStep2State();
}

class _SurveyFormStep2State extends State<SurveyFormStep2> {
  final controller = Get.find<EstablishCaseController>();

  var dataObj = WeentialDataModel(
    wsLocation: WordStrings.selectLocation.toString(),
    wsSituation: "",
    wsCrackedLength: "",
    wsCrackedWidth: "",
    wsFlaw: WordStrings.selectFlaw.toString(),
    wsTechDescr: "",
    wsImagesList: [],
  );

  final tempList = <WeentialDataModel>[].obs;

  @override
  Widget build(BuildContext context) {
    tempList.add(dataObj);
    // controller.selectedLocation.value = WordStrings.selectLocation.toString();
    // controller.selectedFlaw.value = WordStrings.selectFlaw.toString();
    // controller.photoList.clear();
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
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.image,
              color: yasRed,
            ),
            onPressed: () {
              Get.toNamed(AppRoutes.viewCanvasImage,
                  arguments: controller.canvasSurveyUrl);
            },
          )
        ],
      ),
      backgroundColor: stdwhite,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Obx(() => _buildListView(context)),
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
              validateFormData();
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
              controller.surveyModelFinalList.value =
                  tempList.map((v) => v).toList();

              controller.storeWeentialStep2();
            },
          ).paddingAll(10).marginOnly(bottom: 10),
        ],
      ).paddingOnly(top: 20.h).paddingSymmetric(horizontal: 12.w),
    );
  }

  Widget _buildListView(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: tempList.length,
        itemBuilder: (context, index) {
          return _buildList(context, index);
        },
      ),
    );
  }

  Widget _buildList(BuildContext context, int index) {
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
          trailing: const Icon(
            Icons.arrow_drop_down,
            color: yasRed,
          ),
          title: MyText(
            "${WordStrings.numberLbl}  ${index + 1}",
            fontFamily: FontFamilyConstant.sinkinSans,
            fontSize: 14,
            fontColor: yasRed,
          ),
          children: [_buildListItem(context, index)],
        ),
      ),
    );
  }

  Widget _buildListItem(BuildContext context, int index) {
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
                  value: tempList[index].wsLocation!,
                  onchange: (value) {
                    // controller.selectedLocation.value = value!;
                    tempList[index].wsLocation = value;
                    tempList[index] = dataObj;
                  },
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          MyTextField(
            onChanged: (value) {
              tempList[index].wsSituation = value;
            },
            fullBorder: true,
            hasFloatingLabel: false,
            controller:
                TextEditingController(text: tempList[index].wsSituation),
            keyboard: TextInputType.text,
            labelText: WordStrings.situationLbl,
            hintText: WordStrings.situationLbl,
          ),
          const SizedBox(
            height: 15,
          ),
          MyTextField(
            onChanged: (value) {
              tempList[index].wsCrackedLength = value;
            },
            fullBorder: true,
            hasFloatingLabel: false,
            controller:
                TextEditingController(text: tempList[index].wsCrackedLength),
            keyboard: TextInputType.number,
            labelText: WordStrings.crackLengthLbl,
            hintText: WordStrings.crackLengthLbl,
          ),
          const SizedBox(
            height: 15,
          ),
          MyTextField(
            onChanged: (value) {
              tempList[index].wsCrackedWidth = value;
            },
            fullBorder: true,
            hasFloatingLabel: false,
            controller:
                TextEditingController(text: tempList[index].wsCrackedWidth),
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
                  value: tempList[index].wsFlaw,
                  onchange: (value) {
                    // controller.selectedFlaw.value = value!;
                    tempList[index].wsFlaw = value;
                    tempList[index] = dataObj;
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
            controller:
                TextEditingController(text: tempList[index].wsTechDescr),
            maxLength: 50,
            maxLines: 3,
            cursorColor: yasRed,
            onChanged: (value) {
              tempList[index].wsTechDescr = value;
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
                counterText:
                    '${tempList[index].wsTechDescr!.length.toString()}/ 50',
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
                      takePhoto(context, tempList[index], index);
                    },
                    child: Visibility(
                      child: Align(
                        alignment: tempList[index].wsImagesList!.isEmpty
                            ? Alignment.center
                            : Alignment.topRight,
                        heightFactor:
                            tempList[index].wsImagesList!.isEmpty ? 4.0 : 1.0,
                        child: Icon(
                          Icons.add_a_photo,
                          color: yasRed,
                          size: tempList[index].wsImagesList!.isEmpty ? 50 : 25,
                        ).paddingAll(4),
                      ),
                    ),
                  ),
                ),
                Obx(
                  () => Visibility(
                    visible:
                        tempList[index].wsImagesList!.isNotEmpty ? true : false,
                    child:
                        _buildImageList(tempList[index].wsImagesList!, index),
                  ),
                )
              ],
            ),
          ),
        ],
      ).paddingAll(6),
    );
  }

  Future<void> takePhoto(
      BuildContext context, WeentialDataModel data, tempListIndex) async {
    DialogBox.selectImage(
      context,
      onComplete: (filePath, xFile) async {
        if (filePath.isNotEmpty) {
          controller.setLoading(true);
          final uFile = File(filePath);
          controller.uploadWSImage(uFile, tempListIndex).then((url) {
            controller.setLoading(false);
            tempList[tempListIndex].wsImagesList!.add(url!);
            tempList[tempListIndex] = dataObj;
          });
        }
      },
    );
  }

  Widget _buildImageList(List<String> imageList, int tempListIndex) {
    return Expanded(
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: imageList.length,
        itemBuilder: (BuildContext context, int imageIndex) {
          return _buildImageItem(context, imageIndex, tempListIndex);
        },
      ),
    );
  }

  Widget _buildImageItem(
      BuildContext context, int imageIndex, int tempListIndex) {
    return Container(
      height: double.infinity,
      width: Get.width * 0.30,
      alignment: Alignment.center,
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
            SizedBox(
              child: Center(
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  child: Image.network(
                    height: Get.height,
                    width: Get.width * 0.30,
                    fit: BoxFit.fill,
                    tempList[tempListIndex].wsImagesList[imageIndex],
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) return child;
                      return SizedBox(
                        width: Get.width * 0.30,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: MyImage(
                              height: Get.height,
                              image: AssetImages.defaultImage,
                              width: Get.width * 0.30,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            Positioned(
                right: -8,
                top: -6,
                child: Obx(
                  () => InkWell(
                    onTap: () {
                      controller.setLoading(true);
                      controller
                          .deleteImage(
                              tempList[tempListIndex].wsImagesList[imageIndex])
                          .then(
                        (_) {
                          tempList[tempListIndex]
                              .wsImagesList
                              .removeAt(imageIndex);
                          // tempList.remove(dataObj);
                          controller.setLoading(false);
                          setState(() {});
                        },
                      );
                    },
                    child: Visibility(
                      visible: tempList[tempListIndex]
                              .wsImagesList[imageIndex]
                              .isNotEmpty
                          ? true
                          : false,
                      child: const Icon(
                        Icons.delete_rounded,
                        color: Colors.red,
                        size: 20,
                      ).paddingAll(10),
                    ),
                  ),
                ))
          ]),
        ),
      ),
    ).paddingAll(4);
  }

  validateFormData() {
    debugPrint("Himadri >> List size ?? ${tempList.length}");
    final index = tempList.length - 1;

    if (tempList[index].wsLocation!.isEmpty ||
        tempList[index].wsLocation! == WordStrings.selectLocation.toString()) {
      MySnackBar.errorSnackbar(WordStrings.errLocation);
      return;
    }

    if (tempList[index].wsSituation!.isEmpty) {
      MySnackBar.errorSnackbar(WordStrings.errSituation);
      return;
    }

    if (tempList[index].wsFlaw!.isEmpty ||
        tempList[index].wsFlaw! == WordStrings.selectFlaw.toString()) {
      MySnackBar.errorSnackbar(WordStrings.errFlaw);
      return;
    }

    tempList[index] = dataObj;
    debugPrint("Himadri >> OldObj >> ${dataObj.toJson()}");
    dataObj = WeentialDataModel(
      wsLocation: WordStrings.selectLocation.toString(),
      wsSituation: "",
      wsCrackedLength: "",
      wsCrackedWidth: "",
      wsFlaw: WordStrings.selectFlaw.toString(),
      wsTechDescr: "",
      wsImagesList: [],
    );
    // controller.photoList.clear();
    debugPrint("Himadri >> NewObj >> ${dataObj.toJson()}");
    tempList.add(dataObj);
  }
}
