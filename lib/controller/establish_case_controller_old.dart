import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qulip/common/snack.dart';
import 'package:qulip/common/strings.dart';
import 'package:qulip/controller/base_controller.dart';
import 'package:qulip/models/createcase/establish_case_model.dart';
import 'package:qulip/models/createcase/vertical/vertical_form_model.dart';
import 'package:qulip/models/createcase/weential/weential_data_model.dart';
import 'package:qulip/routes/app_routes.dart';
import 'package:qulip/utils/dailog_helper.dart';

class EstablishCaseControllerOld extends BaseController {
  static EstablishCaseControllerOld get instance => Get.find();

  final sDate = DateTime.now();

  // final photoList = <String>[].obs;

  //Weential Step 1
  final caseId = "".obs;
  final txtCaseName = TextEditingController();
  final txtCaseAddress = TextEditingController();
  final txtCaseDate = TextEditingController();
  final txtCaseEquipmentName = TextEditingController();
  final txtCaseWeather = TextEditingController();
  final txtSupplimentryDesc = TextEditingController();

  //Weential Step - 2 list//
  final selectedStructure = WordStrings.selectStructure.toString().obs;
  final selectedUse = WordStrings.selectUse.toString().obs;
  final selectedWall = WordStrings.selectWall.toString().obs;
  final selectedFlatTopMaterial = WordStrings.selectFTop.toString().obs;
  final selectedFloor = WordStrings.selectFloor.toString().obs;
  final techDescription = "".obs;

  final List<String> structureList = [
    WordStrings.selectStructure,
    WordStrings.structureRc,
    WordStrings.structureSrc,
    WordStrings.structureSc,
    WordStrings.structureBrick,
    WordStrings.structureMadeOfWood,
    WordStrings.structureTeppel,
    WordStrings.structureOther
  ];
  final List<String> useList = [
    WordStrings.selectUse,
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
    WordStrings.selectWall,
    WordStrings.wallCementPowder,
    WordStrings.wallPaint,
    WordStrings.wallWallpapers,
    WordStrings.wallMagnaticTile,
    WordStrings.wallMarble,
    WordStrings.wallPlank,
    WordStrings.wallOther
  ];
  final List<String> flatTopMaterialList = [
    WordStrings.selectFTop,
    WordStrings.fTopCementPowder,
    WordStrings.fTopPaint,
    WordStrings.fTopWallpapers,
    WordStrings.fTopMagnaticTile,
    WordStrings.fTopLightSteelFrame,
    WordStrings.fTopWoodenFrame,
    WordStrings.fTopOther
  ];
  final List<String> floorList = [
    WordStrings.selectFloor,
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

  //Weential Step -3
  int number = 1;
  final List<WeentialDataModel> surveyModelList = [];
  var surveyModelFinalList = <WeentialDataModel>[].obs;
  final txtLocation = TextEditingController();
  final txtSituation = TextEditingController();
  final txtCrackLength = TextEditingController();
  final txtCrackWidth = TextEditingController();
  final txtTechDescription2 = TextEditingController();
  final txtTechDesc = TextEditingController();

  final List<String> locationList = [
    WordStrings.selectLocation,
    WordStrings.locationLiang,
    WordStrings.locationColumn,
    WordStrings.locationFlatTop,
    WordStrings.locationFloor,
    WordStrings.locationWall,
    WordStrings.locationDW,
    WordStrings.locationBalcony,
    WordStrings.locationTerraceWall,
    WordStrings.locationDoor,
    WordStrings.locationWindowFram,
    WordStrings.locationStairs,
    WordStrings.locationFTCWindow,
    WordStrings.locationIRollingDoor,
    WordStrings.locationCeiling,
    WordStrings.locationLSteelF,
    WordStrings.locationLCompartment,
    WordStrings.locationWardrobe,
    WordStrings.locationBookcase,
    WordStrings.locationCupboard,
    WordStrings.locationFlowerT,
    WordStrings.locationRailing,
    WordStrings.locationACEqu
  ];

  final List<String> flawList = [
    WordStrings.selectFlaw,
    WordStrings.flawCurrentSit,
    WordStrings.flawMicrocrack,
    WordStrings.flawMeshCrack,
    WordStrings.flawWaterSeepage,
    WordStrings.flawAffDamp,
    WordStrings.flawMottled,
    WordStrings.flawWaterStain,
    WordStrings.flawMagneticBrick,
    WordStrings.flawBrokenTiles,
    WordStrings.flawTilePeelingOff,
    WordStrings.flawPaintPeeling,
    WordStrings.flawPAintArches,
    WordStrings.flawPAintPeels,
    WordStrings.flawPAintDamaged,
    WordStrings.flawProtePeel,
    WordStrings.flawRainExpo,
    WordStrings.flawSeamless,
    WordStrings.flawDamaged,
    WordStrings.flawCracking,
    WordStrings.flawDeformation,
    WordStrings.flawCaveIn,
    WordStrings.flawPatching,
    WordStrings.flawBaiHua,
    WordStrings.flawOther
  ];

  //Vertical Mesurment Form
  final List<String> tileDirectionList = [
    WordStrings.selectDirection,
    WordStrings.selectLeftDirection,
    WordStrings.selectRightDirection,
  ].obs;
  var verticalFinalList = <VerticalFormModel>[].obs;

  Future<void> storeCaseEstablishData() async {
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

    Get.toNamed(AppRoutes.surveyForm1CreateScreen);
    // setLoading(true);
    // await createCase(caseModel);
  }

  Future<void> storeWeentialStep1Data(EstablishCaseModel caseModel) async {
    if (selectedStructure.value == WordStrings.selectStructure.toString()) {
      MySnackBar.errorSnackbar(WordStrings.errStructure);
      return;
    }

    if (selectedUse.value == WordStrings.selectUse.toString()) {
      MySnackBar.errorSnackbar(WordStrings.errUse);
      return;
    }

    if (selectedWall.value == WordStrings.selectWall.toString()) {
      MySnackBar.errorSnackbar(WordStrings.errWall);
      return;
    }

    if (selectedFlatTopMaterial.value == WordStrings.selectFTop.toString()) {
      MySnackBar.errorSnackbar(WordStrings.errFTop);
      return;
    }

    if (selectedFloor.value == WordStrings.selectFloor.toString()) {
      MySnackBar.errorSnackbar(WordStrings.errFloor);
      return;
    }

    setLoading(true);
    await createCase(caseModel);
  }

  createCase(EstablishCaseModel caseModel) async {
    await _db
        .collection("case_survey")
        .doc(caseModel.id)
        .set(caseModel.toJson())
        .whenComplete(() {
      setLoading(false);
      Get.toNamed(AppRoutes.surveyForm2CreateScreen);
    });
  }

  Future<void> storWeentialListToFirestore(List<WeentialDataModel> list) async {
    setLoading(true);
    for (var item in list) {
      await createWeetialSurveyList(item);
    }
  }

  createWeetialSurveyList(WeentialDataModel list) async {
    await _db.collection("case_survey").doc(caseId.value).update({
      'weentialList': FieldValue.arrayUnion([list.toJson()])
    }).whenComplete(() {
      setLoading(false);
      Get.toNamed(AppRoutes.surveyFormVerticalScreen);
    });
  }

  Future<void> takePhoto(
      BuildContext context, WeentialDataModel data, tempListIndex) async {
    DialogBox.selectImage(
      context,
      onComplete: (filePath, xFile) async {
        if (filePath.isNotEmpty) {
          setLoading(true);
          final uFile = File(filePath);
          uploadImage(uFile, tempListIndex).then((url) {
            setLoading(false);
            data.wsImagesList!.add(url!);
            // tempList[tempListIndex].wsImagesList!.add(url!);
            // tempList[tempListIndex] = dataObj;
          });
        }
      },
    );
  }

  Future<String?> uploadImage(File pickedImg, int index) async {
    var imageName = "WS_${DateTime.now().millisecondsSinceEpoch}";
    var ref = FirebaseStorage.instance
        .ref()
        .child('weential_survey')
        .child("$imageName.jpg");
    await ref.putFile(pickedImg);

    return await ref.getDownloadURL();
  }
}
