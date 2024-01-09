import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qulip/common/assests.dart';
import 'package:qulip/common/colors.dart';
import 'package:qulip/common/snack.dart';
import 'package:qulip/common/strings.dart';
import 'package:qulip/common/widgets/my_button.dart';
import 'package:qulip/common/widgets/my_text.dart';
import 'package:qulip/common/widgets/my_textfield.dart';
import 'package:qulip/controller/establish_case_controller.dart';
import 'package:qulip/models/createcase/horizontal/horizontal_form_model.dart';
import 'package:qulip/routes/app_routes.dart';

class HorizontalMeasurement1 extends StatelessWidget {
  HorizontalMeasurement1({super.key});

  final controller = Get.find<EstablishCaseController>();
  var dataObj = HorizontalDataModel(
      mesuringPoint: "BM",
      backView: "",
      forwardView: "",
      hypothesis: "",
      levelElevation: 0,
      imageUri: "");
  final tempList = <HorizontalDataModel>[].obs;
  // var levelElv = 0.obs;

  @override
  Widget build(BuildContext context) {
    tempList.add(dataObj);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: stdwhite,
        foregroundColor: yasRed,
        centerTitle: true,
        title: MyText(
          "${controller.txtCaseName.value.text}_${WordStrings.surveyFormHorizonatllLbl}",
          fontFamily: FontFamilyConstant.sinkinSans,
          fontSize: 18,
          fontColor: yasRed,
        ),
        // actions: <Widget>[
        //   IconButton(
        //     icon: const Icon(
        //       Icons.image,
        //       color: yasRed,
        //     ),
        //     onPressed: () {
        //       //controller.takePhoto(context);
        //     },
        //   )
        // ],
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
              addmoreItem();
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
              controller.horizontalfinalList.value =
                  tempList.map((v) => v).toList();
              Get.toNamed(AppRoutes.horizontalCase2Screen);
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
          const MyText(
            WordStrings.sfMesuringPointLbl,
            fontWeight: FontWeight.w400,
            fontFamily: FontFamilyConstant.sinkinSansMedium,
            fontColor: yasRed,
          ).paddingOnly(left: 2, right: 2, bottom: 4),
          MyText(
            tempList[index].mesuringPoint!,
            fontWeight: FontWeight.bold,
            fontFamily: FontFamilyConstant.sinkinSansMedium,
            fontColor: yasRed,
          ).paddingOnly(left: 2, right: 2, bottom: 4),
          const SizedBox(
            height: 15,
          ),
          MyTextField(
            onSubmit: (value) {
              if (value.isNotEmpty) {
                tempList[index].backView = value;
              }
            },
            fullBorder: true,
            hasFloatingLabel: false,
            maxLength: 6,
            controller: TextEditingController(text: tempList[index].backView),
            keyboard: TextInputType.number,
            labelText: WordStrings.sfBackwardViewLbl,
            hintText: WordStrings.sfBackwardViewLbl,
          ),
          const SizedBox(
            height: 15,
          ),
          MyTextField(
            onSubmit: (value) {
              if (value.isNotEmpty) {
                tempList[index].forwardView = value;
                if (index >= 1) {
                  tempList[index].levelElevation =
                      tempList[index - 1].levelElevation;
                  tempList[index].hypothesis =
                      calculateHypo(tempList[index]).toString();
                  tempList[index] = dataObj;
                }
                if (index > 2) {
                  tempList[index].levelElevation =
                      calculateLevelElevation(tempList[index]);
                  tempList[index] = dataObj;
                }
              }
            },
            fullBorder: true,
            hasFloatingLabel: false,
            controller:
                TextEditingController(text: tempList[index].forwardView),
            keyboard: TextInputType.number,
            maxLength: 6,
            labelText: WordStrings.sfForwardViewLbl,
            hintText: WordStrings.sfForwardViewLbl,
          ),
          const SizedBox(
            height: 15,
          ),
          Visibility(
            visible: (index < 1) ? true : false,
            child: MyTextField(
              onSubmit: (value) {
                if (value.isNotEmpty) {
                  tempList[index].hypothesis = value;
                  // levelElv.value = calculateLevelElevation(tempList[index]);
                  tempList[index].levelElevation =
                      calculateLevelElevation(tempList[index]);
                  tempList[index] = dataObj;
                  // debugPrint(
                  // "Himadri >> Level Elevation ${tempList[index].levelElevation} >>${tempList[index].mesuringPoint} >> $index");
                }
              },
              fullBorder: true,
              hasFloatingLabel: false,
              controller: TextEditingController(
                  text: tempList[index].hypothesis.toString()),
              keyboard: TextInputType.number,
              maxLength: 6,
              labelText: WordStrings.sfHypothesisLbl,
              hintText: WordStrings.sfHypothesisLbl,
            ),
          ),
          Obx(
            () => Visibility(
              visible: (index >= 1) ? true : false,
              child: MyText(
                "${WordStrings.sfHypothesisLbl} : ${tempList[index].hypothesis!.isEmpty ? 0 : tempList[index].hypothesis}",
                fontWeight: FontWeight.w600,
                fontFamily: FontFamilyConstant.sinkinSansMedium,
                fontColor: stdBlack,
              ).paddingOnly(left: 6, right: 2),
            ),
          ),
          Visibility(
            visible: (index >= 1) ? true : false,
            child: const SizedBox(
              height: 15,
            ),
          ),
          Obx(
            () => MyText(
              "${WordStrings.sfLevelElevationLbl} : ${tempList[index].levelElevation}",
              fontWeight: FontWeight.w600,
              fontFamily: FontFamilyConstant.sinkinSansMedium,
              fontColor: stdBlack,
            ).paddingOnly(left: 6, right: 2),
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      ).paddingAll(6),
    );
  }

  void addmoreItem() {
    debugPrint("Himadri >> List size ?? ${tempList.length}");
    final index = tempList.length - 1;
    if (tempList[index].backView!.isEmpty) {
      MySnackBar.errorSnackbar(WordStrings.errBackwardViewEmpty);
      return;
    }

    if (tempList[index].forwardView!.isEmpty) {
      MySnackBar.errorSnackbar(WordStrings.errForwardViewEmpty);
      return;
    }

    if (tempList[index].hypothesis!.isEmpty && index < 1) {
      MySnackBar.errorSnackbar(WordStrings.errHypothesisEmpty);
      return;
    }

    tempList[index] = dataObj;
    debugPrint("Himadri >> OldObj >> ${dataObj.toJson()}");
    var mPoint = "";
    if (tempList.length == 1) {
      mPoint = "BM1";
    } else if (tempList.length == 2) {
      mPoint = "L1";
    } else {
      mPoint = "TP${tempList.length - 2}";
    }
    dataObj = HorizontalDataModel(
        mesuringPoint: mPoint,
        // mesuringPoint:
        //     (tempList.length == 1) ? "BM1" : "TP${tempList.length - 1}",
        backView: "",
        forwardView: "",
        hypothesis: "",
        levelElevation: 0,
        imageUri: "");
    debugPrint("Himadri >> NewObj >> ${dataObj.toJson()}");
    tempList.add(dataObj);
  }

  double calculateHypo(HorizontalDataModel data) {
    final forwardValue = data.forwardView;
    final levelElevation = data.levelElevation;
    if (forwardValue!.isNotEmpty) {
      final fValue = double.parse(forwardValue);
      final result = levelElevation - fValue;
      return result;
    } else {
      return 0;
    }
  }

  double calculateLevelElevation(HorizontalDataModel data) {
    final backwardValue = data.backView;
    final hypoValue = data.hypothesis;
    if (backwardValue!.isNotEmpty && hypoValue!.isNotEmpty) {
      final bValue = double.parse(backwardValue);
      final hValue = double.parse(hypoValue);
      return bValue + hValue;
    } else {
      return 0;
    }
  }

  double calculateLevelElevationForTp(HorizontalDataModel data) {
    final backwardValue = data.backView;
    final hypoValue = data.hypothesis;
    if (backwardValue!.isNotEmpty && hypoValue!.isNotEmpty) {
      final bValue = double.parse(backwardValue);
      final hValue = double.parse(hypoValue);
      return bValue + hValue;
    } else {
      return 0;
    }
  }
}
