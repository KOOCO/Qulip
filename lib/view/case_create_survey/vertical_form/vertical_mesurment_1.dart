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
import 'package:qulip/common/widgets/my_text.dart';
import 'package:qulip/common/widgets/my_textfield.dart';
import 'package:qulip/controller/establish_case_controller.dart';
import 'package:qulip/models/createcase/vertical/vertical_form_model.dart';
import 'package:qulip/utils/dailog_helper.dart';
import 'package:qulip/utils/text_style_helper.dart';

class VerticalMeasurement1 extends StatelessWidget {
  VerticalMeasurement1({super.key});

  final caseController = Get.find<EstablishCaseController>();

  var dataObj = VerticalFormModel(
      upperPoint: "",
      lowerPoint: "",
      highDifference: 0,
      titlDirection: WordStrings.selectDirection.toString(),
      leftPoint: "",
      rightPoint: "",
      tiltValue: 0,
      slope: 0.0,
      description: "",
      filePath: []);
  final tempList = <VerticalFormModel>[].obs;

  @override
  Widget build(BuildContext context) {
    tempList.add(dataObj);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: stdwhite,
        foregroundColor: yasRed,
        centerTitle: true,
        title: MyText(
          "${caseController.txtCaseName.value.text}_${WordStrings.surveyFormVerticallLbl}",
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
          Obx(
            () => _buildListView(context),
          ),
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
              addVerticalValidatationForm();
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
              caseController.verticalFinalList.value =
                  tempList.map((v) => v).toList();
              caseController.storeVeritcalFormData();
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
            "${WordStrings.numberLbl} ${index + 1}",
            fontFamily: FontFamilyConstant.sinkinSans,
            fontSize: 14,
            fontColor: yasRed,
          ),
          children: [_buildItem(context, index)],
        ),
      ),
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    return Container(
      decoration: const BoxDecoration(
        color: cardBg,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          MyTextField(
            onSubmit: (value) {
              tempList[index].upperPoint = value;
              calculateHighDifference(index);
            },
            fullBorder: true,
            hasFloatingLabel: false,
            controller: TextEditingController(text: tempList[index].upperPoint),
            keyboard: TextInputType.number,
            labelText: WordStrings.upperPointLbl,
            hintText: WordStrings.upperPointLbl,
          ),
          const SizedBox(
            height: 15,
          ),
          MyTextField(
            onSubmit: (value) {
              tempList[index].lowerPoint = value;
              calculateHighDifference(index);
              tempList[index] = dataObj;
            },
            fullBorder: true,
            hasFloatingLabel: false,
            controller: TextEditingController(text: tempList[index].lowerPoint),
            keyboard: TextInputType.number,
            labelText: WordStrings.lowerPointLbl,
            hintText: WordStrings.lowerPointLbl,
          ),
          const SizedBox(
            height: 15,
          ),
          Obx(
            () => MyText(
              "${WordStrings.highDifferenceLbl} : ${tempList[index].highDifference}",
              fontWeight: FontWeight.w600,
              fontFamily: FontFamilyConstant.sinkinSansMedium,
              fontColor: stdBlack,
            ).paddingOnly(left: 6, right: 2),
          ),
          const SizedBox(
            height: 15,
          ),
          Obx(() => Container(
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
                    items: caseController.tileDirectionList.map((element) {
                      return DropdownMenuItem<String>(
                        value: element,
                        child: MyText(
                          element,
                          fontStyle: MyTextTheme14Normal.black(),
                        ),
                      );
                    }).toList(),
                    selectedItemBuilder: (context) {
                      return caseController.tileDirectionList
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
                    value: tempList[index].titlDirection,
                    onchange: (value) {
                      tempList[index].titlDirection = value;
                      tempList[index] = dataObj;
                    },
                  ),
                ),
              )),
          const SizedBox(
            height: 15,
          ),
          MyTextField(
            onSubmit: (value) {
              tempList[index].leftPoint = value;
              calculateTiltValue(index);
              // tempList[index] = dataObj;
            },
            fullBorder: true,
            hasFloatingLabel: false,
            controller: TextEditingController(text: tempList[index].leftPoint),
            keyboard: TextInputType.number,
            labelText: WordStrings.leftPointLbl,
            hintText: WordStrings.leftPointLbl,
          ),
          const SizedBox(
            height: 15,
          ),
          MyTextField(
            fullBorder: true,
            hasFloatingLabel: false,
            controller: TextEditingController(text: tempList[index].rightPoint),
            keyboard: TextInputType.number,
            labelText: WordStrings.rightPointLbl,
            hintText: WordStrings.rightPointLbl,
            onSubmit: (value) {
              tempList[index].rightPoint = value;
              calculateTiltValue(index);
              tempList[index] = dataObj;
            },
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(
                () => MyText(
                  "${WordStrings.tiltValueLbl} : ${tempList[index].tiltValue}",
                  fontWeight: FontWeight.w600,
                  fontFamily: FontFamilyConstant.sinkinSansMedium,
                  fontColor: stdBlack,
                ).paddingOnly(left: 6),
              ),
              Obx(
                () => MyText(
                  "${WordStrings.slopeLbl} : ${tempList[index].slope}",
                  fontWeight: FontWeight.w600,
                  fontFamily: FontFamilyConstant.sinkinSansMedium,
                  fontColor: stdBlack,
                ).paddingOnly(right: 6),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          // const MyText(
          //   WordStrings.diagramLbl,
          //   fontWeight: FontWeight.w400,
          //   fontFamily: FontFamilyConstant.sinkinSansMedium,
          //   fontColor: stdBlack,
          // ).paddingOnly(left: 2, right: 2, bottom: 4),
          // const SizedBox(
          //   height: 200,
          // ),
          const MyText(
            WordStrings.sfDescriptionLbl,
            fontWeight: FontWeight.w400,
            fontFamily: FontFamilyConstant.sinkinSansMedium,
            fontColor: yasRed,
          ).paddingOnly(left: 2, right: 2, bottom: 4),
          TextField(
            controller:
                TextEditingController(text: tempList[index].description),
            maxLength: 50,
            maxLines: 3,
            cursorColor: yasRed,
            onChanged: (value) {
              tempList[index].description = value;
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
                    '${tempList[index].description!.length.toString()}/ 50',
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
                      takePhoto(context, index);
                    },
                    child: Visibility(
                      child: Align(
                        alignment: tempList[index].filePath!.isEmpty
                            ? Alignment.center
                            : Alignment.topRight,
                        heightFactor:
                            tempList[index].filePath!.isEmpty ? 4.0 : 1.0,
                        child: Icon(
                          Icons.add_a_photo,
                          color: yasRed,
                          size: tempList[index].filePath!.isEmpty ? 50 : 25,
                        ).paddingAll(4),
                      ),
                    ),
                  ),
                ),
                Obx(
                  () => Visibility(
                    visible:
                        tempList[index].filePath!.isNotEmpty ? true : false,
                    child: _buildImageList(tempList[index].filePath!, index),
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
                  tempList[tempListIndex].filePath![imageIndex],
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return SizedBox(
                      width: Get.width * 0.25,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: yasRed,
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Positioned(
                right: -8,
                top: -6,
                child: Obx(
                  () => InkWell(
                    onTap: () {
                      caseController.setLoading(true);
                      caseController
                          .deleteImage(
                              tempList[tempListIndex].filePath![imageIndex])
                          .then(
                        (_) {
                          tempList[tempListIndex]
                              .filePath!
                              .removeAt(imageIndex);
                          tempList.add(dataObj);
                          caseController.setLoading(false);
                        },
                      );
                    },
                    child: Visibility(
                      visible: tempList[tempListIndex]
                              .filePath![imageIndex]
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

  Future<void> takePhoto(BuildContext context, int tempListIndex) async {
    DialogBox.selectImage(
      context,
      onComplete: (filePath) async {
        if (filePath.isNotEmpty) {
          caseController.setLoading(true);
          final uFile = File(filePath);
          caseController.uploadVMSImage(uFile, tempListIndex).then((url) {
            tempList[tempListIndex].filePath!.add(url!);
            tempList[tempListIndex] = dataObj;
            caseController.setLoading(false);
          });
        }
      },
    );
  }

  void calculateHighDifference(int index) {
    final upperPoint = tempList[index].upperPoint!;
    final lowerPoint = tempList[index].lowerPoint!;
    if (upperPoint.isNotEmpty && lowerPoint.isNotEmpty) {
      if (int.parse(lowerPoint) >= int.parse(upperPoint)) {
        MySnackBar.errorSnackbar(WordStrings.errUpperPointMustValid);
        tempList[index].highDifference = 0;
      } else {
        tempList[index].highDifference =
            (int.parse(upperPoint) - int.parse(lowerPoint));
      }
    } else {
      tempList[index].highDifference = 0;
    }
    calculateSlope(
        tempList[index].tiltValue!, tempList[index].highDifference!, index);
  }

  void calculateTiltValue(int index) {
    final tiltDirection = tempList[index].titlDirection;
    final leftPoint = tempList[index].leftPoint!;
    final rightPoint = tempList[index].rightPoint!;

    if (tiltDirection == WordStrings.selectDirection.toString()) {
      MySnackBar.errorSnackbar(WordStrings.errselectDirection);
      return;
    }

    if (leftPoint.isNotEmpty && rightPoint.isNotEmpty) {
      if (tiltDirection == WordStrings.selectLeftDirection.toString()) {
        if (int.parse(rightPoint) >= int.parse(leftPoint)) {
          MySnackBar.errorSnackbar(WordStrings.errRightPointMustValid);
          tempList[index].tiltValue = 0;
        } else {
          tempList[index].tiltValue =
              int.parse(leftPoint) - int.parse(rightPoint);
        }
      } else {
        if (int.parse(leftPoint) >= int.parse(rightPoint)) {
          MySnackBar.errorSnackbar(WordStrings.errLeftPointMustValid);
          tempList[index].tiltValue = 0;
        } else {
          tempList[index].tiltValue =
              int.parse(rightPoint) - int.parse(leftPoint);
        }
      }
    } else {
      tempList[index].tiltValue = 0;
    }
    calculateSlope(
        tempList[index].tiltValue!, tempList[index].highDifference!, index);
  }

  void calculateSlope(int tiltValue, int highDifference, int index) {
    final result = tiltValue / highDifference;
    debugPrint("Himadri >> ${result.toStringAsFixed(2)}");
    tempList[index].slope = double.parse(result.toStringAsFixed(2));
  }

  void addVerticalValidatationForm() {
    debugPrint("Himadri >> List size ?? ${tempList.length}");
    final index = tempList.length - 1;

    if (tempList[index].upperPoint!.isEmpty) {
      MySnackBar.errorSnackbar(WordStrings.errUpperPointEmpty);
      return;
    }

    if (tempList[index].lowerPoint!.isEmpty) {
      MySnackBar.errorSnackbar(WordStrings.errLowerPointEmpty);
      return;
    }

    if (tempList[index].titlDirection!.isEmpty ||
        tempList[index].titlDirection! ==
            WordStrings.selectDirection.toString()) {
      MySnackBar.errorSnackbar(WordStrings.errselectDirection);
      return;
    }

    if (tempList[index].leftPoint!.isEmpty) {
      MySnackBar.errorSnackbar(WordStrings.errLeftPointEmpty);
      return;
    }

    if (tempList[index].rightPoint!.isEmpty) {
      MySnackBar.errorSnackbar(WordStrings.errRightPointEmpty);
      return;
    }

    tempList[index] = dataObj;
    debugPrint("Himadri >> OldObj >> ${dataObj.toJson()}");
    dataObj = VerticalFormModel(
        upperPoint: "",
        lowerPoint: "",
        highDifference: 0,
        titlDirection: WordStrings.selectDirection.toString(),
        leftPoint: "",
        rightPoint: "",
        tiltValue: 0,
        slope: 0.0,
        description: "",
        filePath: []);

    debugPrint("Himadri >> NewObj >> ${dataObj.toJson()}");
    tempList.add(dataObj);
  }
}
