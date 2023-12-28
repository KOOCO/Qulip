import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qulip/common/snack.dart';
import 'package:qulip/common/strings.dart';
import 'package:qulip/controller/base_controller.dart';
import 'package:qulip/models/createcase/vertical/vertical_form_model.dart';
import 'package:qulip/routes/app_routes.dart';

class VerticalCaseController extends BaseController {
  static VerticalCaseController get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  var verticalFinalList = <VerticalFormModel>[].obs;

  final List<String> tileDirectionList = [
    WordStrings.selectDirection,
    WordStrings.selectLeftDirection,
    WordStrings.selectRightDirection,
  ].obs;

  final List<VerticalFormModel> verticalDataList = [];
  // Vertical Form
  final txtUpperPoint = TextEditingController();
  final txtLowerPoint = TextEditingController();
  final txtLeftPoint = TextEditingController();
  final txtRightPoint = TextEditingController();
  final txtTechnicalDescription = TextEditingController();
  final selectedDirection = WordStrings.selectDirection.toString().obs;

  createVerticalForm(VerticalFormModel formModel, int index) async {
    await _db
        .collection("Veritcal_Data")
        .doc(DateTime.now().millisecondsSinceEpoch.toString())
        .set(formModel.toJson())
        .whenComplete(() {
    });
  }

  Future<void> storeVeritcalFormData(RxList<VerticalFormModel> tempList) async {

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

    if (tempList[index].titlDirection!.isEmpty || tempList[index].titlDirection! == WordStrings.selectDirection.toString()) {
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

    if (tempList[index].description!.isEmpty) {
      MySnackBar.errorSnackbar(WordStrings.errTechDesc);
      return;
    }

    if (tempList[index].filePath!.isEmpty) {
      MySnackBar.errorSnackbar(WordStrings.errImage);
      return;
    }

    setLoading(true);
    for(var item in verticalFinalList ){
      await createVerticalForm(item, index);
    }
    setLoading(false);
    MySnackBar.successSnackbar("Horizontal Form completed");
    Get.toNamed(AppRoutes.horizontalCase1Screen);
  }
}
