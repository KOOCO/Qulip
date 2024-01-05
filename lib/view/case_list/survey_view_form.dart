import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qulip/common/assests.dart';
import 'package:qulip/common/colors.dart';
import 'package:qulip/common/strings.dart';
import 'package:qulip/common/widgets/my_button.dart';
import 'package:qulip/common/widgets/my_text.dart';
import 'package:qulip/controller/case_list_controller.dart';
import 'package:qulip/models/createcase/establish_case_model.dart';
import 'package:qulip/models/createcase/weential/weential_data_model.dart';

class SurveyViewForm extends StatelessWidget {
  SurveyViewForm({super.key});

  final controller = Get.find<CaseListController>();
  final List<WeentialDataModel> listOfWeentialModels = [];
  @override
  Widget build(BuildContext context) {
    var index = Get.arguments;
    var modelData = controller.caseListNew[index];
    var list = controller.caseListNew[index].wsWeentileDataList;
    listOfWeentialModels.addAll(list);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: stdwhite,
        foregroundColor: yasRed,
        centerTitle: true,
        title: MyText(
          modelData.caseLable!,
          fontFamily: FontFamilyConstant.sinkinSans,
          fontSize: 18,
          fontColor: yasRed,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Flexible(
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: MyText(
                          "${modelData.caseDate!} - ${modelData.caseName!}",
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontColor: stdBlack,
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                    const Flexible(
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: MyText(
                          WordStrings.surveyCsDetails,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontColor: stdBlack,
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ),
                  ],
                ).paddingOnly(top: 10, bottom: 10),
                buildTopFormView(modelData),
                buildInDoorPlan().paddingOnly(bottom: 15),
                buildNumberList(modelData)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTopFormView(EstablishCaseModel modelData) {
    return Column(
      children: [
        Container(
          width: Get.width,
          decoration: BoxDecoration(
            // borderRadius: const BorderRadius.all(Radius.circular(1.0)),
            border: Border.all(
              color: Colors.black,
              width: 1.0,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const MyText(
                "${WordStrings.caseNamelLbl}:",
                fontSize: 14,
                fontWeight: FontWeight.w600,
                fontColor: stdDarkGray,
                textAlign: TextAlign.center,
              ).paddingSymmetric(horizontal: 4, vertical: 4),
              MyText(
                modelData.caseName!,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                fontColor: stdDarkGray,
                textAlign: TextAlign.center,
              ).paddingSymmetric(horizontal: 4, vertical: 4),
            ],
          ),
        ),
        Container(
          width: Get.width,
          decoration: const BoxDecoration(
            border: Border(
              left: BorderSide(color: Colors.black, width: 1.0),
              right: BorderSide(color: Colors.black, width: 1.0),
              bottom: BorderSide(color: Colors.black, width: 1.0),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const MyText(
                "${WordStrings.caseAddresslLbl}:",
                fontSize: 14,
                fontWeight: FontWeight.w600,
                fontColor: stdDarkGray,
                textAlign: TextAlign.center,
              ).paddingSymmetric(horizontal: 4, vertical: 4),
              MyText(
                modelData.caseAddress!,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                fontColor: stdDarkGray,
                textAlign: TextAlign.center,
              ).paddingSymmetric(horizontal: 4, vertical: 4),
            ],
          ),
        ),
        Container(
          width: Get.width,
          decoration: const BoxDecoration(
            border: Border(
              left: BorderSide(color: Colors.black, width: 1.0),
              right: BorderSide(color: Colors.black, width: 1.0),
              bottom: BorderSide(color: Colors.black, width: 1.0),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const MyText(
                "${WordStrings.caseDatelLbl}:",
                fontSize: 14,
                fontWeight: FontWeight.w600,
                fontColor: stdDarkGray,
                textAlign: TextAlign.center,
              ).paddingSymmetric(horizontal: 4, vertical: 4),
              MyText(
                modelData.caseDate!,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                fontColor: stdDarkGray,
                textAlign: TextAlign.center,
              ).paddingSymmetric(horizontal: 4, vertical: 4),
            ],
          ),
        ).paddingOnly(bottom: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: Get.width,
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.black, width: 1.0),
                  left: BorderSide(color: Colors.black, width: 1.0),
                  right: BorderSide(color: Colors.black, width: 1.0),
                  bottom: BorderSide(color: Colors.black, width: 1.0),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const MyText(
                          "${WordStrings.sfStructurelLbl}:",
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          fontColor: stdDarkGray,
                          textAlign: TextAlign.center,
                        ).paddingSymmetric(horizontal: 4, vertical: 4),
                        Flexible(
                          child: MyText(
                            modelData.wsStructureType!,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            fontColor: stdDarkGray,
                            textAlign: TextAlign.right,
                          ).paddingSymmetric(horizontal: 4, vertical: 4),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          left: BorderSide(color: Colors.black, width: 1.0),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const MyText(
                            "${WordStrings.sfUseLbl}:",
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            fontColor: stdDarkGray,
                            textAlign: TextAlign.center,
                          ).paddingSymmetric(horizontal: 4, vertical: 4),
                          Flexible(
                            child: MyText(
                              modelData.wsUseFor!,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              fontColor: stdDarkGray,
                              textAlign: TextAlign.right,
                            ).paddingSymmetric(horizontal: 4, vertical: 4),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: Get.width,
              decoration: const BoxDecoration(
                border: Border(
                  left: BorderSide(color: Colors.black, width: 1.0),
                  right: BorderSide(color: Colors.black, width: 1.0),
                  bottom: BorderSide(color: Colors.black, width: 1.0),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const MyText(
                          "${WordStrings.sfWallLbl}:",
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          fontColor: stdDarkGray,
                          textAlign: TextAlign.center,
                        ).paddingSymmetric(horizontal: 4, vertical: 4),
                        Flexible(
                          child: MyText(
                            modelData.wsWallType!,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            fontColor: stdDarkGray,
                            textAlign: TextAlign.right,
                          ).paddingSymmetric(horizontal: 4, vertical: 4),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          left: BorderSide(color: Colors.black, width: 1.0),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const MyText(
                            "${WordStrings.sfFlatTopMaterialLbl}:",
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            fontColor: stdDarkGray,
                            textAlign: TextAlign.center,
                          ).paddingSymmetric(horizontal: 4, vertical: 4),
                          Flexible(
                            child: MyText(
                              modelData.wsFlatTopMaterial!,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              fontColor: stdDarkGray,
                              textAlign: TextAlign.right,
                            ).paddingSymmetric(horizontal: 4, vertical: 4),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Container(
          width: Get.width,
          decoration: const BoxDecoration(
            border: Border(
              left: BorderSide(color: Colors.black, width: 1.0),
              right: BorderSide(color: Colors.black, width: 1.0),
              bottom: BorderSide(color: Colors.black, width: 1.0),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const MyText(
                "${WordStrings.sfFloorMaterialLbl}:",
                fontSize: 14,
                fontWeight: FontWeight.w600,
                fontColor: stdDarkGray,
                textAlign: TextAlign.center,
              ).paddingSymmetric(horizontal: 4, vertical: 4),
              MyText(
                modelData.wsFloorMaterial!,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                fontColor: stdDarkGray,
                textAlign: TextAlign.center,
              ).paddingSymmetric(horizontal: 4, vertical: 4),
            ],
          ),
        ),
        Container(
          width: Get.width,
          decoration: const BoxDecoration(
            border: Border(
              left: BorderSide(color: Colors.black, width: 1.0),
              right: BorderSide(color: Colors.black, width: 1.0),
              bottom: BorderSide(color: Colors.black, width: 1.0),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const MyText(
                "${WordStrings.viewRemarkLbl}:",
                fontSize: 14,
                fontWeight: FontWeight.w600,
                fontColor: stdDarkGray,
                textAlign: TextAlign.center,
              ).paddingSymmetric(horizontal: 4, vertical: 4),
              MyText(
                modelData.wsTechDescription!,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                fontColor: stdDarkGray,
                textAlign: TextAlign.center,
              ).paddingSymmetric(horizontal: 4, vertical: 4),
            ],
          ),
        ).paddingOnly(bottom: 15),
        Container(
          width: Get.width,
          decoration: const BoxDecoration(
            border: Border(
              left: BorderSide(color: Colors.black, width: 1.0),
              right: BorderSide(color: Colors.black, width: 1.0),
              bottom: BorderSide(color: Colors.black, width: 1.0),
              top: BorderSide(color: Colors.black, width: 1.0),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const MyText(
                "${WordStrings.signatureLbl}:",
                fontSize: 14,
                fontWeight: FontWeight.w600,
                fontColor: stdDarkGray,
                textAlign: TextAlign.center,
              ).paddingSymmetric(horizontal: 4, vertical: 4),
              const MyText(
                "",
                fontSize: 14,
                fontWeight: FontWeight.w400,
                fontColor: stdDarkGray,
                textAlign: TextAlign.center,
              ).paddingSymmetric(horizontal: 4, vertical: 4),
            ],
          ),
        ),
      ],
    ).paddingOnly(bottom: 15);
  }

  Widget buildInDoorPlan() {
    return Container(
      width: Get.width,
      height: 250.h,
      decoration: const BoxDecoration(
        border: Border(
          left: BorderSide(color: Colors.black, width: 1.0),
          right: BorderSide(color: Colors.black, width: 1.0),
          bottom: BorderSide(color: Colors.black, width: 1.0),
          top: BorderSide(color: Colors.black, width: 1.0),
        ),
      ),
      child: Center(
        child: const MyText(
          WordStrings.viewIndoorkLbl,
          fontSize: 16,
          fontWeight: FontWeight.w600,
          fontColor: stdDarkGray,
          textAlign: TextAlign.center,
        ).paddingSymmetric(horizontal: 4, vertical: 4),
      ),
    );
  }

  Widget buildNumberList(EstablishCaseModel modelData) {
    return ListView.builder(
      itemCount: listOfWeentialModels.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return numberItemView(modelData, listOfWeentialModels[index], index);
      },
    );
  }

  Widget numberItemView(
      EstablishCaseModel modelData, WeentialDataModel data, int index) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.antiAlias,
      child: Container(
        decoration: const BoxDecoration(
          color: cardBg,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            MyText(
              "${WordStrings.numberLbl} ${index + 1}",
              fontFamily: FontFamilyConstant.sinkinSans,
              fontWeight: FontWeight.w600,
              fontSize: 14,
              fontColor: yasRed,
            ).paddingOnly(bottom: 15),
            Container(
              width: Get.width,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 1.0,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const MyText(
                    "${WordStrings.locationLbl}:",
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    fontColor: stdDarkGray,
                    textAlign: TextAlign.center,
                  ).paddingSymmetric(horizontal: 4, vertical: 4),
                  MyText(
                    data.wsLocation.toString(),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontColor: stdDarkGray,
                    textAlign: TextAlign.center,
                  ).paddingSymmetric(horizontal: 4, vertical: 4),
                ],
              ),
            ),
            Container(
              width: Get.width,
              decoration: const BoxDecoration(
                border: Border(
                  left: BorderSide(color: Colors.black, width: 1.0),
                  right: BorderSide(color: Colors.black, width: 1.0),
                  bottom: BorderSide(color: Colors.black, width: 1.0),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const MyText(
                    "${WordStrings.situationLbl}:",
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    fontColor: stdDarkGray,
                    textAlign: TextAlign.center,
                  ).paddingSymmetric(horizontal: 4, vertical: 4),
                  MyText(
                    data.wsSituation!,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontColor: stdDarkGray,
                    textAlign: TextAlign.center,
                  ).paddingSymmetric(horizontal: 4, vertical: 4),
                ],
              ),
            ),
            Container(
              width: Get.width,
              decoration: const BoxDecoration(
                border: Border(
                  left: BorderSide(color: Colors.black, width: 1.0),
                  right: BorderSide(color: Colors.black, width: 1.0),
                  bottom: BorderSide(color: Colors.black, width: 1.0),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const MyText(
                    "${WordStrings.crackLengthLbl}:",
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    fontColor: stdDarkGray,
                    textAlign: TextAlign.center,
                  ).paddingSymmetric(horizontal: 4, vertical: 4),
                  MyText(
                    data.wsCrackedLength.toString(),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontColor: stdDarkGray,
                    textAlign: TextAlign.center,
                  ).paddingSymmetric(horizontal: 4, vertical: 4),
                ],
              ),
            ),
            Container(
              width: Get.width,
              decoration: const BoxDecoration(
                border: Border(
                  left: BorderSide(color: Colors.black, width: 1.0),
                  right: BorderSide(color: Colors.black, width: 1.0),
                  bottom: BorderSide(color: Colors.black, width: 1.0),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const MyText(
                    "${WordStrings.crackWidthLbl}:",
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    fontColor: stdDarkGray,
                    textAlign: TextAlign.center,
                  ).paddingSymmetric(horizontal: 4, vertical: 4),
                  MyText(
                    data.wsCrackedWidth.toString(),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontColor: stdDarkGray,
                    textAlign: TextAlign.center,
                  ).paddingSymmetric(horizontal: 4, vertical: 4),
                ],
              ),
            ),
            Container(
              width: Get.width,
              decoration: const BoxDecoration(
                border: Border(
                  left: BorderSide(color: Colors.black, width: 1.0),
                  right: BorderSide(color: Colors.black, width: 1.0),
                  bottom: BorderSide(color: Colors.black, width: 1.0),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const MyText(
                    "${WordStrings.flawLbl}:",
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    fontColor: stdDarkGray,
                    textAlign: TextAlign.center,
                  ).paddingSymmetric(horizontal: 4, vertical: 4),
                  MyText(
                    data.wsFlaw.toString(),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontColor: stdDarkGray,
                    textAlign: TextAlign.center,
                  ).paddingSymmetric(horizontal: 4, vertical: 4),
                ],
              ),
            ),
            Container(
              width: Get.width,
              decoration: const BoxDecoration(
                border: Border(
                  left: BorderSide(color: Colors.black, width: 1.0),
                  right: BorderSide(color: Colors.black, width: 1.0),
                  bottom: BorderSide(color: Colors.black, width: 1.0),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const MyText(
                    "${WordStrings.sfDescriptionLbl}:",
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    fontColor: stdDarkGray,
                    textAlign: TextAlign.center,
                  ).paddingSymmetric(horizontal: 4, vertical: 4),
                  MyText(
                    data.wsTechDescr.toString(),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontColor: stdDarkGray,
                    textAlign: TextAlign.center,
                  ).paddingSymmetric(horizontal: 4, vertical: 4),
                ],
              ),
            ).paddingOnly(bottom: 15),
            Visibility(
                visible: data.wsImagesList.isNotEmpty ? true : false,
                child: buildImageList(data.wsImagesList))
          ],
        ).paddingAll(6),
      ),
    );
  }

  Widget buildImageList(List<String> imageList) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        shrinkWrap: true,
        // physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: imageList.length,
        itemBuilder: (BuildContext context, int imageIndex) {
          return _buildImageItem(context, imageList, imageIndex);
        },
      ),
    );
  }

  Widget _buildImageItem(
    BuildContext context,
    List<String> imageList,
    int imageIndex,
  ) {
    return Container(
      height: double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: stdwhite,
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        border: Border.all(
          width: 1,
          color: transparentGrey,
        ),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        child: Image.network(
          width: Get.width * 0.40,
          fit: BoxFit.fill,
          imageList[imageIndex],
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) return child;
            return SizedBox(
              width: Get.width * 0.40,
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
    ).paddingAll(6);
  }
}
