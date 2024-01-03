import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qulip/common/colors.dart';
import 'package:qulip/common/strings.dart';
import 'package:qulip/common/widgets/my_button.dart';
import 'package:qulip/common/widgets/my_text.dart';
import 'package:qulip/controller/case_list_controller.dart';

class SurveyListScreen extends StatelessWidget {
  SurveyListScreen({super.key});

  final controller = Get.find<CaseListController>();

  @override
  Widget build(BuildContext context) {
    var index = Get.arguments;
    var modelData = controller.caseListNew[index];
    return Scaffold(
      body: SafeArea(
          child: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            MyButton(
              onTap: () {},
              label: WordStrings.lblCivilAffairsGuide,
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
            ).paddingAll(10),
            Container(
              width: Get.width,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 2.0,
                ),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: MyText(
                  "${modelData.caseDate!} ${modelData.caseName!}",
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontColor: stdBlack,
                  textAlign: TextAlign.center,
                ).paddingSymmetric(horizontal: 4, vertical: 4),
              ),
            ),
            Column(
              children: [
                Container(
                  width: Get.width,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 2.0,
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: MyText(
                      modelData.caseName!,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontColor: stdBlack,
                      textAlign: TextAlign.center,
                    ).paddingSymmetric(horizontal: 4, vertical: 4),
                  ),
                ),
                Container(
                  width: Get.width,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 2.0,
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: MyText(
                      modelData.caseAddress!,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontColor: stdBlack,
                      textAlign: TextAlign.center,
                    ).paddingSymmetric(horizontal: 4, vertical: 4),
                  ),
                ),
                Container(
                  width: Get.width,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 2.0,
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: MyText(
                      modelData.caseDate!,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontColor: stdBlack,
                      textAlign: TextAlign.center,
                    ).paddingSymmetric(horizontal: 4, vertical: 4),
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: Get.width,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 2.0,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: MyText(
                            "structure " + modelData.wsStructureType!,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            fontColor: stdBlack,
                            textAlign: TextAlign.center,
                          ).paddingSymmetric(horizontal: 4, vertical: 4),
                        ),
                      ),

                      //const Spacer(),

                      Expanded(
                        child: Container(
                          child: MyText(
                            "use " + modelData.wsUseFor!,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            fontColor: stdBlack,
                            textAlign: TextAlign.center,
                          ).paddingSymmetric(horizontal: 4, vertical: 4),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: Get.width,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 2.0,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: MyText(
                            "wall " + modelData.wsWallType!,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            fontColor: stdBlack,
                            textAlign: TextAlign.center,
                          ).paddingSymmetric(horizontal: 4, vertical: 4),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: MyText(
                            "flat " + modelData.wsFlatTopMaterial!,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            fontColor: stdBlack,
                            textAlign: TextAlign.center,
                          ).paddingSymmetric(horizontal: 4, vertical: 4),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: Get.width,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 2.0,
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: MyText(
                      "floor " + modelData.wsFloorMaterial!,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontColor: stdBlack,
                      textAlign: TextAlign.center,
                    ).paddingSymmetric(horizontal: 4, vertical: 4),
                  ),
                ),
                Container(
                  width: Get.width,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 2.0,
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: MyText(
                      "Remarks " + modelData.wsTechDescription!,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontColor: stdBlack,
                      textAlign: TextAlign.center,
                    ).paddingSymmetric(horizontal: 4, vertical: 4),
                  ),
                ),
                Container(
                  width: Get.width,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 2.0,
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: const MyText(
                      "User Signature",
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontColor: stdBlack,
                      textAlign: TextAlign.center,
                    ).paddingSymmetric(horizontal: 4, vertical: 4),
                  ),
                ),
              ],
            )
          ],
        ),
      )),
    );
  }
}
