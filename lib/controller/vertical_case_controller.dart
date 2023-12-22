import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qulip/common/snack.dart';
import 'package:qulip/common/strings.dart';
import 'package:qulip/controller/base_controller.dart';
import 'package:qulip/models/createcase/vertical/vertical_form_model.dart';
import 'package:qulip/utils/dailog_helper.dart';

class VerticalCaseController extends BaseController {
  static VerticalCaseController get instance => Get.find();

  final sDate = DateTime.now();
  final _db = FirebaseFirestore.instance;

  int number = 1;
  final highDifference = 0.obs;
  final tiltValue = 0.obs;
  final slope = 0.0.obs;

  final List<String> tileDirectionList = [
    WordStrings.selectDirection,
    WordStrings.selectLeftDirection,
    WordStrings.selectRightDirection,
  ].obs;

  final formList = <int>[1].obs;
  final photoList = <String>[].obs;
  final List<VerticalFormModel> verticalDataList = [];
  // Vertical Form
  final txtUpperPoint = TextEditingController();
  final txtLowerPoint = TextEditingController();
  final txtLeftPoint = TextEditingController();
  final txtRightPoint = TextEditingController();
  final txtTechnicalDescription = TextEditingController();
  final selectedDirection = WordStrings.selectDirection.toString().obs;

  void calculateHighDifference() {
    final upperPoint = txtUpperPoint.text;
    final lowerPoint = txtLowerPoint.text;
    if (upperPoint.isNotEmpty && lowerPoint.isNotEmpty) {
      if (int.parse(lowerPoint) >= int.parse(upperPoint)) {
        MySnackBar.errorSnackbar(WordStrings.errUpperPointMustValid);
        highDifference.value = 0;
      } else {
        highDifference.value = (int.parse(upperPoint) - int.parse(lowerPoint));
      }
    } else {
      highDifference.value = 0;
    }
    calculateSlope(tiltValue.value, highDifference.value);
  }

  void calculateTiltValue() {
    final tiltDirection = selectedDirection.value;
    final leftPoint = txtLeftPoint.text;
    final rightPoint = txtRightPoint.text;

    if (selectedDirection.value == WordStrings.selectDirection.toString()) {
      MySnackBar.errorSnackbar(WordStrings.errselectDirection);
      return;
    }

    if (leftPoint.isNotEmpty && rightPoint.isNotEmpty) {
      if (tiltDirection == WordStrings.selectLeftDirection.toString()) {
        if (int.parse(rightPoint) >= int.parse(leftPoint)) {
          MySnackBar.errorSnackbar(WordStrings.errRightPointMustValid);
          tiltValue.value = 0;
        } else {
          tiltValue.value = int.parse(leftPoint) - int.parse(rightPoint);
        }
      } else {
        if (int.parse(leftPoint) >= int.parse(rightPoint)) {
          MySnackBar.errorSnackbar(WordStrings.errLeftPointMustValid);
          tiltValue.value = 0;
        } else {
          tiltValue.value = int.parse(rightPoint) - int.parse(leftPoint);
        }
      }
    } else {
      tiltValue.value = 0;
    }
    calculateSlope(tiltValue.value, highDifference.value);
  }

  void calculateSlope(int tiltValue, int highDifference) {
    final result = tiltValue / highDifference;
    debugPrint("Himadri >> ${result.toStringAsFixed(2)}");
    slope.value = double.parse(result.toStringAsFixed(2));
  }

  Future<void> takePhoto(BuildContext context) async {
    DialogBox.selectImage(
      context,
      onComplete: (filePath) async {
        if (filePath.isNotEmpty) {
          debugPrint("FilePath $filePath");
          photoList.add(filePath);
        }
      },
    );
  }

  void checkValidation() {
    if (txtUpperPoint.text.isEmpty) {
      MySnackBar.errorSnackbar(WordStrings.errUpperPointEmpty);
      return;
    }

    if (txtLowerPoint.text.isEmpty) {
      MySnackBar.errorSnackbar(WordStrings.errLowerPointEmpty);
      return;
    }
    if (selectedDirection.value == WordStrings.selectDirection.toString()) {
      MySnackBar.errorSnackbar(WordStrings.errselectDirection);
      return;
    }

    if (txtLeftPoint.text.isEmpty) {
      MySnackBar.errorSnackbar(WordStrings.errLeftPointEmpty);
      return;
    }

    if (txtRightPoint.text.isEmpty) {
      MySnackBar.errorSnackbar(WordStrings.errRightPointEmpty);
      return;
    }

    number += 1;
    formList.add(number);

    final verticalModel = VerticalFormModel(
        upperPoint: txtUpperPoint.text,
        lowerPoint: txtLowerPoint.text,
        highDifference: highDifference.value,
        titlDirection: selectedDirection.value,
        leftPoint: txtLeftPoint.text,
        rightPoint: txtRightPoint.text,
        tiltValue: tiltValue.value,
        slope: slope.value,
        description: txtTechnicalDescription.text,
        filePath: photoList);
    verticalDataList.add(verticalModel);

    debugPrint("Himadri >> Vertical data >>${verticalDataList.toList()}");
  }

  createVerticalForm(VerticalFormModel formModel) async {
    await _db
        .collection("VeritcalForm")
        .doc("Veritcal Form $number")
        .set(formModel.toJson())
        .whenComplete(() {
      setLoading(false);
      MySnackBar.successSnackbar("Vertical Form completed");
      //Get.toNamed(AppRoutes.surveyForm1CreateScreen);
    });
  }

  Future<void> storeVeritcalFormData(VerticalFormModel caseModel) async {
    setLoading(true);
    await createVerticalForm(caseModel);
  }
}
