import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qulip/common/assests.dart';
import 'package:qulip/common/colors.dart';
import 'package:qulip/common/strings.dart';
import 'package:qulip/common/widgets/my_button.dart';
import 'package:qulip/common/widgets/my_dropdown.dart';
import 'package:qulip/common/widgets/my_text.dart';
import 'package:qulip/common/widgets/my_textarea.dart';
import 'package:qulip/controller/survey_form1_controller.dart';
import 'package:qulip/routes/app_routes.dart';

class SurveyForm1Screen extends StatefulWidget {
  const SurveyForm1Screen({super.key});

  @override
  State<SurveyForm1Screen> createState() => _SurveyForm1ScreenState();
}

class _SurveyForm1ScreenState extends State<SurveyForm1Screen> {
  final controller = Get.put(SurveyForm1Controller());

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const MyText(
            WordStrings.surveyFormCreatelLbl,
            fontFamily: FontFamilyConstant.sinkinSans,
            fontSize: 18,
            fontColor: yasRed,
          ),
        ),
        body: Column(
          children: [
            MyDropDown(
              item: structureList,
              onChanged: (value) {
                controller.txtStructure.text = value!;
              },
              controller: controller.txtStructure,
              hintText: WordStrings.sfStructurelLbl,
            ),
            MyDropDown(
              item: useList,
              onChanged: (value) {
                controller.txtUse.text = value!;
              },
              controller: controller.txtUse,
              hintText: WordStrings.sfUselLbl,
            ),
            MyDropDown(
              item: wallList,
              onChanged: (value) {
                controller.txtWall.text = value!;
              },
              controller: controller.txtWall,
              hintText: WordStrings.sfWalllLbl,
            ),
            MyDropDown(
              item: flatTopMaterialList,
              onChanged: (value) {
                controller.txtFlatTopMaterial.text = value!;
              },
              controller: controller.txtFlatTopMaterial,
              hintText: WordStrings.sfFlatTopMateriallLbl,
            ),
            MyDropDown(
              item: floorList,
              onChanged: (value) {
                controller.txtFloorMaterial.text = value!;
              },
              controller: controller.txtFloorMaterial,
              hintText: WordStrings.sfFloorMateriallLbl,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                border: Border.all(
                  width: 1,
                  color: yasRed,
                ),
              ),
              margin: const EdgeInsets.only(left: 45, right: 45, top: 20),
              child: const MyTextArea(
                //controller: controller,
                keyboard: TextInputType.multiline,
                labelText: WordStrings.sfSupDirectionlLbl,
                hintText: '',
                maxLines: 3,
              ),
            ),
            MyButton(
              label: WordStrings.establishLbl,
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
                Get.toNamed(AppRoutes.surveyForm2CreateScreen);
              },
            )
                .paddingOnly(top: 20.h)
                .paddingSymmetric(horizontal: 20)
                .marginOnly(bottom: 50),
          ],
        ));
  }
}
