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
import 'package:qulip/models/createcase/vertical/vertical_form_model.dart';

class VerticalViewScreen extends StatelessWidget {
  VerticalViewScreen({super.key});

  final controller = Get.find<CaseListController>();
  final List<VerticalFormModel> listOfVerticalModels = [];

  @override
  Widget build(BuildContext context) {
    var index = Get.arguments;
    var modelData = controller.caseListNew[index];
    var verticalList = controller.caseListNew[index].verticalMSDataList;
    listOfVerticalModels.addAll(verticalList);
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
                          WordStrings.verticalMesurementTabCsDetails,
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
                buildOutDoorPlan(modelData).paddingOnly(bottom: 15),
                buildTiltTable().paddingOnly(bottom: 15),
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
                "${WordStrings.caseNoLbl}:",
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
                "${WordStrings.caseEquipmentNamelLbl}:",
                fontSize: 14,
                fontWeight: FontWeight.w600,
                fontColor: stdDarkGray,
                textAlign: TextAlign.center,
              ).paddingSymmetric(horizontal: 4, vertical: 4),
              MyText(
                modelData.caseEquipmentNo!,
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
                "${WordStrings.caseWeatherlLbl}:",
                fontSize: 14,
                fontWeight: FontWeight.w600,
                fontColor: stdDarkGray,
                textAlign: TextAlign.center,
              ).paddingSymmetric(horizontal: 4, vertical: 4),
              MyText(
                modelData.caseWeather!,
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
              Visibility(
                visible: controller.signUrl.value.isEmpty ? false : true,
                child: Image.network(
                  controller.signUrl.value,
                  fit: BoxFit.fill,
                  width: 150,
                  height: 65,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return SizedBox(
                      width: 150,
                      height: 65,
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
            ],
          ),
        ),
      ],
    ).paddingOnly(bottom: 15);
  }

  Widget buildOutDoorPlan(EstablishCaseModel modelData) {
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
        child: Image.network(
          width: double.infinity,
          fit: BoxFit.fill,
          modelData.vertical1Canvas.toString(),
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) return child;
            return SizedBox(
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
      // Center(
      //   child: const MyText(
      //     WordStrings.viewOutdoorkLbl,
      //     fontSize: 16,
      //     fontWeight: FontWeight.w600,
      //     fontColor: stdDarkGray,
      //     textAlign: TextAlign.center,
      //   ).paddingSymmetric(horizontal: 4, vertical: 4),
      // ),
    );
  }

  Widget buildTiltTable() {
    return Container(
      width: Get.width,
      decoration: const BoxDecoration(
        border: Border(
          left: BorderSide(color: Colors.black, width: 1.0),
          right: BorderSide(color: Colors.black, width: 1.0),
          bottom: BorderSide(color: Colors.black, width: 1.0),
          top: BorderSide(color: Colors.black, width: 1.0),
        ),
      ),
      child: DataTable(
        headingRowColor: MaterialStateColor.resolveWith((states) => lightGrey),
        columns: const [
          DataColumn(
            label: Flexible(
              child: MyText(
                WordStrings.viewNoLbl,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          DataColumn(
            label: Flexible(
              child: MyText(
                WordStrings.viewMesuringPointLbl,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          DataColumn(
            label: Flexible(
              child: MyText(
                WordStrings.viewTiltValueCMLbl,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          DataColumn(
            label: Flexible(
              child: MyText(
                WordStrings.viewTiltLbl,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
        rows:
            listOfVerticalModels // Loops through dataColumnText, each iteration assigning the value to element
                .map(
                  ((element) => DataRow(
                        cells: <DataCell>[
                          DataCell(MyText(
                            element.highDifference.toString(),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          )),
                          DataCell(MyText(
                            element.highDifference.toString(),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          )), //Extracting from Map element the value
                          DataCell(MyText(
                            "${element.titlDirection!} - ${element.tiltValue}",
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          )),
                          DataCell(MyText(
                            element.slope.toString(),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          )),
                        ],
                      )),
                )
                .toList(),
      ),
    );
  }

  Widget buildNumberList(EstablishCaseModel modelData) {
    return ListView.builder(
      itemCount: listOfVerticalModels.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return numberItemView(modelData, listOfVerticalModels[index], index);
      },
    );
  }

  Widget numberItemView(
      EstablishCaseModel modelData, VerticalFormModel data, int index) {
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
              fontWeight: FontWeight.w600,
              fontFamily: FontFamilyConstant.sinkinSans,
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
                    "${WordStrings.highDifferenceLbl}:",
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    fontColor: stdDarkGray,
                    textAlign: TextAlign.center,
                  ).paddingSymmetric(horizontal: 4, vertical: 4),
                  MyText(
                    data.highDifference.toString(),
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
                    "${WordStrings.viewTiltDirectionLbl}:",
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    fontColor: stdDarkGray,
                    textAlign: TextAlign.center,
                  ).paddingSymmetric(horizontal: 4, vertical: 4),
                  MyText(
                    data.titlDirection!,
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
                    "${WordStrings.viewTiltValueLbl}:",
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    fontColor: stdDarkGray,
                    textAlign: TextAlign.center,
                  ).paddingSymmetric(horizontal: 4, vertical: 4),
                  MyText(
                    data.tiltValue.toString(),
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
                    modelData.wsTechDescription!,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontColor: stdDarkGray,
                    textAlign: TextAlign.center,
                  ).paddingSymmetric(horizontal: 4, vertical: 4),
                ],
              ),
            ).paddingOnly(bottom: 10),
            const MyText(
              WordStrings.viewDiagramLbl,
              fontWeight: FontWeight.w600,
              fontFamily: FontFamilyConstant.sinkinSansMedium,
              fontColor: stdBlack,
            ).paddingOnly(left: 2, right: 2, bottom: 4),
            const SizedBox(
              height: 200,
            ),
            Center(
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                child: Image.network(
                  width: Get.width,
                  height: 400,
                  fit: BoxFit.fill,
                  "https://firebasestorage.googleapis.com/v0/b/qulip-6cd34.appspot.com/o/weential_survey%2FWS_1704439002705.jpg?alt=media&token=71aeb6a8-1fef-41dc-82bc-7ef5a42a8b8d",
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return SizedBox(
                      width: Get.width,
                      height: 100,
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
          ],
        ).paddingAll(6),
      ),
    );
  }
}
