import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qulip/common/snack.dart';
import 'package:qulip/common/strings.dart';
import 'package:qulip/controller/base_controller.dart';
import 'package:qulip/models/createcase/establish_case_model.dart';
import 'package:qulip/models/createcase/weential_survey_data1_model.dart';
import 'package:qulip/routes/app_routes.dart';

class EstablishCaseController extends BaseController {
  static EstablishCaseController get instance => Get.find();

  final sDate = DateTime.now();

  final txtCaseName = TextEditingController();
  final txtCaseAddress = TextEditingController();
  final txtCaseDate = TextEditingController();
  final txtCaseEquipmentName = TextEditingController();
  final txtCaseWeather = TextEditingController();
  final txtSupplimentryDesc = TextEditingController();

  //Step - 1 list//
  final selectedStructure = WordStrings.structureRc.toString().obs;
  final selectedUse = WordStrings.useResidence.toString().obs;
  final selectedWall = WordStrings.wallCementPowder.toString().obs;
  final selectedFlatTopMaterial = WordStrings.fTopCementPowder.toString().obs;
  final selectedFloor = WordStrings.floorCementPowder.toString().obs;

  final List<String> structureList = [
    WordStrings.structureRc,
    WordStrings.structureSrc,
    WordStrings.structureSc,
    WordStrings.structureBrick,
    WordStrings.structureMadeOfWood,
    WordStrings.structureTeppel,
    WordStrings.structureOther
  ];
  final List<String> useList = [
    WordStrings.useResidence,
    WordStrings.useBusiness,
    WordStrings.useIndustry,
    WordStrings.useReligion,
    WordStrings.useMedicalTreatment,
    WordStrings.useSocialWelfare,
    WordStrings.useTheOffice,
    WordStrings.useTheWarehouse,
    WordStrings.useShopfront,
    WordStrings.useOther
  ];
  final List<String> wallList = [
    WordStrings.wallCementPowder,
    WordStrings.wallPaint,
    WordStrings.wallWallpapers,
    WordStrings.wallMagnaticTile,
    WordStrings.wallMarble,
    WordStrings.wallPlank,
    WordStrings.wallOther
  ];
  final List<String> flatTopMaterialList = [
    WordStrings.fTopCementPowder,
    WordStrings.fTopPaint,
    WordStrings.fTopWallpapers,
    WordStrings.fTopMagnaticTile,
    WordStrings.fTopLightSteelFrame,
    WordStrings.fTopWoodenFrame,
    WordStrings.fTopOther
  ];
  final List<String> floorList = [
    WordStrings.floorCementPowder,
    WordStrings.floorPaint,
    WordStrings.floorGrindingStone,
    WordStrings.floorWashStones,
    WordStrings.floorMagnaticTile,
    WordStrings.floorCarpet,
    WordStrings.floorPlank,
    WordStrings.floorStoneMaterial,
    WordStrings.floorPlasticFloorTiles,
    WordStrings.floorOther
  ];

  final _db = FirebaseFirestore.instance;

  //FireStore method
  createCase(EstablishCaseModel caseModel) async {
    await _db.collection("CaseSurvey").doc(caseModel.id).set(caseModel.toJson()).whenComplete(() {
      MySnackBar.successSnackbar("Step 1 completed");
      Get.toNamed(AppRoutes.surveyForm1CreateScreen);
    });
  }

  createWeentialSurveyDoc1(WeentialSurveyData1Model wsDataModel) async {
    await _db
        .collection("WeentialSurveyForm")
        .add(wsDataModel.toJson())
        .whenComplete(() {
      MySnackBar.successSnackbar("Step 2 completed");
      Get.toNamed(AppRoutes.surveyForm2CreateScreen);
    });
  }

  //

  //Check validation and store data
  Future<void> storeCaseEstablishData(EstablishCaseModel caseModel) async {
    if (txtCaseName.text.isEmpty) {
      MySnackBar.errorSnackbar(WordStrings.errCaseName);
      return;
    }

    if (txtCaseAddress.text.isEmpty) {
      MySnackBar.errorSnackbar(WordStrings.errCaseAddress);
      return;
    }

    if (txtCaseDate.text.isEmpty) {
      MySnackBar.errorSnackbar(WordStrings.errCaseDate);
      return;
    }

    if (txtCaseEquipmentName.text.isEmpty) {
      MySnackBar.errorSnackbar(WordStrings.errCaseEquipmentName);
      return;
    }

    if (txtCaseWeather.text.isEmpty) {
      MySnackBar.errorSnackbar(WordStrings.errCaseWeather);
      return;
    }

    await createCase(caseModel);
  }

  Future<void> storeWeentialStep1Data(WeentialSurveyData1Model caseModel) async {
    // if (txtCaseName.text.isEmpty) {
    //   MySnackBar.errorSnackbar(WordStrings.errCaseName);
    //   return;
    // }

    // if (txtCaseAddress.text.isEmpty) {
    //   MySnackBar.errorSnackbar(WordStrings.errCaseAddress);
    //   return;
    // }

    // if (txtCaseDate.text.isEmpty) {
    //   MySnackBar.errorSnackbar(WordStrings.errCaseDate);
    //   return;
    // }

    // if (txtCaseEquipmentName.text.isEmpty) {
    //   MySnackBar.errorSnackbar(WordStrings.errCaseEquipmentName);
    //   return;
    // }

    // if (txtCaseWeather.text.isEmpty) {
    //   MySnackBar.errorSnackbar(WordStrings.errCaseWeather);
    //   return;
    // }

    await createWeentialSurveyDoc1(caseModel);
  }
}
