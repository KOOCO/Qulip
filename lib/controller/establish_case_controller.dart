import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qulip/common/snack.dart';
import 'package:qulip/common/strings.dart';
import 'package:qulip/controller/base_controller.dart';
import 'package:qulip/models/createcase/establish_case_model.dart';
import 'package:qulip/models/createcase/horizontal/horizontal_form_model.dart';
import 'package:qulip/models/createcase/vertical/vertical_form_model.dart';
import 'package:qulip/models/createcase/weential/weential_data_model.dart';
import 'package:qulip/routes/app_routes.dart';
import 'package:path/path.dart' as Path;
import 'package:qulip/utils/dailog_helper.dart';

class EstablishCaseController extends BaseController {
  static EstablishCaseController get instance => Get.find();

  final sDate = DateTime.now();
  var isWeentialCompleted = false;

  //Weential Step 1
  final caseId = "".obs;
  final userId = "".obs;
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
  final canvasSurveyUrl = "".obs;
  final canvasVertical1Url = "".obs;
  final canvasVertical2Url = "".obs;
  final canvasHorizontalUrl = "".obs;
  final techDescriptionStr = "".obs;

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

  //Vertical measurement form
  final List<String> tileDirectionList = [
    WordStrings.selectDirection,
    WordStrings.selectLeftDirection,
    WordStrings.selectRightDirection,
  ].obs;
  final txtUpperPoint = TextEditingController();
  final txtLowerPoint = TextEditingController();
  final txtLeftPoint = TextEditingController();
  final txtRightPoint = TextEditingController();
  final txtTechnicalDescription = TextEditingController();
  final List<VerticalFormModel> verticalDataList = [];
  var verticalFinalList = <VerticalFormModel>[].obs;

  //Horizontal measurement form
  final photoList = <String>[].obs;
  var horizontalfinalList = <HorizontalDataModel>[].obs;

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
  }

  Future<void> storeWeentialStep1() async {
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

    Get.toNamed(AppRoutes.surveyCanvasView);
    // Get.toNamed(AppRoutes.surveyForm2CreateScreen);
  }

  Future<void> storeWeentialStep2() async {
    final index = surveyModelFinalList.length - 1;
    if (surveyModelFinalList[index].wsLocation!.isEmpty ||
        surveyModelFinalList[index].wsLocation! ==
            WordStrings.selectLocation.toString()) {
      MySnackBar.errorSnackbar(WordStrings.errLocation);
      return;
    }

    if (surveyModelFinalList[index].wsSituation!.isEmpty) {
      MySnackBar.errorSnackbar(WordStrings.errSituation);
      return;
    }

    if (surveyModelFinalList[index].wsFlaw!.isEmpty ||
        surveyModelFinalList[index].wsFlaw! ==
            WordStrings.selectFlaw.toString()) {
      MySnackBar.errorSnackbar(WordStrings.errFlaw);
      return;
    }

    Get.toNamed(AppRoutes.verticalCanvas1View);
  }

  Future<void> storeVeritcalFormData() async {
    final index = verticalFinalList.length - 1;

    if (verticalFinalList[index].upperPoint!.isEmpty) {
      MySnackBar.errorSnackbar(WordStrings.errUpperPointEmpty);
      return;
    }

    if (verticalFinalList[index].lowerPoint!.isEmpty) {
      MySnackBar.errorSnackbar(WordStrings.errLowerPointEmpty);
      return;
    }

    if (verticalFinalList[index].titlDirection!.isEmpty ||
        verticalFinalList[index].titlDirection! ==
            WordStrings.selectDirection.toString()) {
      MySnackBar.errorSnackbar(WordStrings.errselectDirection);
      return;
    }

    if (verticalFinalList[index].leftPoint!.isEmpty) {
      MySnackBar.errorSnackbar(WordStrings.errLeftPointEmpty);
      return;
    }

    if (verticalFinalList[index].rightPoint!.isEmpty) {
      MySnackBar.errorSnackbar(WordStrings.errRightPointEmpty);
      return;
    }
    Get.toNamed(AppRoutes.horizontalCase1Screen);
  }

  Future<void> takePhotoHS(BuildContext context, int index) async {
    DialogBox.selectImage(
      context,
      onComplete: (filePath, xFile) async {
        if (filePath.isNotEmpty) {
          setLoading(true);
          debugPrint("FilePath $filePath");
          final uFile = File(filePath);
          uploadHMSImage(uFile, index).then((url) {
            setLoading(false);
            horizontalfinalList[index].imageUri = url;
            photoList[index] = url!;
            debugPrint("Himadri : Download url>> $index >>> $url");
          });
        }
      },
    );
  }

  Future<String?> uploadWSImage(File pickedImg, int index) async {
    var imageName = "WS_${DateTime.now().millisecondsSinceEpoch}";
    var ref = FirebaseStorage.instance
        .ref()
        .child('weential_survey')
        .child("$imageName.jpg");
    await ref.putFile(pickedImg);

    return await ref.getDownloadURL();
  }

  Future<String?> uploadVMSImage(File pickedImg, int index) async {
    var imageName = "VMS_${DateTime.now().millisecondsSinceEpoch}";
    var ref = FirebaseStorage.instance
        .ref()
        .child('vertical_survey')
        .child("$imageName.jpg");
    await ref.putFile(pickedImg);

    return await ref.getDownloadURL();
  }

  Future<String?> uploadHMSImage(File pickedImg, int index) async {
    var imageName =
        "HMS_${horizontalfinalList[index].mesuringPoint!}_${DateTime.now().millisecondsSinceEpoch}";
    var ref = FirebaseStorage.instance
        .ref()
        .child('horizontal_survey')
        .child("$imageName.jpg");
    await ref.putFile(pickedImg);

    return await ref.getDownloadURL();
  }

  Future<void> deleteImage(String imageFileUrl) async {
    String fileUrl = Uri.decodeFull(Path.basename(imageFileUrl))
        .replaceAll(RegExp(r'(\?alt).*'), '');
    var ref = FirebaseStorage.instance.ref().child(fileUrl);

    await ref.delete();
  }

  createCase(EstablishCaseModel caseModel) async {
    setLoading(true);
    await _db
        .collection("case_survey")
        .doc(caseModel.id)
        .set(caseModel.toJson())
        .whenComplete(() {
      updateWeentialData().then((_) {
        debugPrint("Himadri weentialList Stored final}");
        updateVerticalData().then((_) {
          debugPrint("Himadri Vertical Stored final}");
          updateHorizontalData().then((_) {
            debugPrint("Himadri Horizontal Stored final}");
            setLoading(false);
            clearTextField();
            MySnackBar.successSnackbar("Data saved successfully");
            Get.toNamed(AppRoutes.homeScreen);
          });
        });
      });
    });
  }

  updateWeentialData() async {
    for (var item in surveyModelFinalList) {
      await _db.collection("case_survey").doc(caseId.value).update({
        'weentialList': FieldValue.arrayUnion([item.toJson()])
      }).whenComplete(() {
        debugPrint("Himadri weentialList Stored}");
      });
    }
  }

  updateVerticalData() async {
    for (var item in verticalFinalList) {
      await _db.collection("case_survey").doc(caseId.value).update({
        'verticalMsList': FieldValue.arrayUnion([item.toJson()])
      }).whenComplete(() {
        debugPrint("Himadri Vertical Stored}");
      });
    }
  }

  updateHorizontalData() async {
    for (var item in horizontalfinalList) {
      await _db.collection("case_survey").doc(caseId.value).update({
        'horizontalMSDataList': FieldValue.arrayUnion([item.toJson()])
      }).whenComplete(() {
        debugPrint("Himadri Horizontal Stored}");
      });
    }
  }

  void clearTextField() {
    txtCaseName.clear();
    txtCaseAddress.clear();
    txtCaseDate.clear();
    txtCaseEquipmentName.clear();
    txtCaseWeather.clear();
    txtSupplimentryDesc.clear();
    txtLocation.clear();
    txtSituation.clear();
    txtCrackLength.clear();
    txtCrackWidth.clear();
    txtTechDescription2.clear();
    txtTechDesc.clear();
    selectedStructure.value = WordStrings.selectStructure.toString();
    selectedUse.value = WordStrings.selectUse.toString();
    selectedWall.value = WordStrings.selectWall.toString();
    selectedFlatTopMaterial.value = WordStrings.selectFTop.toString();
    selectedFloor.value = WordStrings.selectFloor.toString();
  }
}
