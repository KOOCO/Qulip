
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
import 'package:qulip/common/widgets/my_textfield.dart';
import 'package:qulip/controller/establish_case_controller.dart';
import 'package:qulip/models/createcase/weential_data_model.dart';
import 'package:qulip/utils/text_style_helper.dart';

class SurveyFormStep2 extends StatelessWidget {
  SurveyFormStep2({super.key});

  final controller = Get.put(EstablishCaseController());

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
              controller.storWeentialListToFirestore(tempList);
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
            "Number ${index + 1}",
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
                      controller.takePhoto(context, tempList[index], index);
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
            Center(
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                child: Image.network(
                  fit: BoxFit.contain,
                  tempList[tempListIndex].wsImagesList![imageIndex],
                ),
              ),
            ),
            Positioned(
                right: -8,
                top: -6,
                child: Obx(
                  () => InkWell(
                    onTap: () {
                      tempList[tempListIndex]
                          .wsImagesList!
                          .removeAt(imageIndex);
                    },
                    child: Visibility(
                      visible: tempList[tempListIndex]
                              .wsImagesList![imageIndex]
                              .isNotEmpty
                          ? true
                          : false,
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

    // if (tempList[index].wsCrackedLength!.isEmpty) {
    //   MySnackBar.errorSnackbar(WordStrings.errCrackLength);
    //   return;
    // }

    // if (tempList[index].wsCrackedWidth!.isEmpty) {
    //   MySnackBar.errorSnackbar(WordStrings.errCrackWidth);
    //   return;
    // }

    // if (tempList[index].wsTechDescr!.isEmpty) {
    //   MySnackBar.errorSnackbar(WordStrings.errTechDesc);
    //   return;
    // }

    // if (tempList[index].wsImages!.isEmpty) {
    //   MySnackBar.errorSnackbar(WordStrings.errImage);
    //   return;
    // }

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
