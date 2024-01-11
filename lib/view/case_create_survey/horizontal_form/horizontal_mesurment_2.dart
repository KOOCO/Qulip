import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qulip/common/assests.dart';
import 'package:qulip/common/colors.dart';
import 'package:qulip/common/strings.dart';
import 'package:qulip/common/widgets/my_button.dart';
import 'package:qulip/common/widgets/my_text.dart';
import 'package:qulip/controller/establish_case_controller.dart';
import 'package:qulip/models/createcase/establish_case_model.dart';
import 'package:qulip/routes/app_routes.dart';
import 'package:qulip/utils/datetime_helper.dart';
import 'package:qulip/utils/storage_helper.dart';

class HorizontalMeasurement2 extends StatelessWidget {
  HorizontalMeasurement2({super.key});

  final controller = Get.find<EstablishCaseController>();
  // Get.put(EstablishCaseController()); //

  @override
  Widget build(BuildContext context) {
    StorageHelper.read(StorageKeys.userId).then((value) {
      controller.userId.value = value.toString();
    });
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
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.image,
              color: yasRed,
            ),
            onPressed: () {
              Get.toNamed(AppRoutes.viewCanvasImage,
                  arguments: controller.canvasHorizontalUrl);
            },
          )
        ],
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
            label: WordStrings.btnSaveLbl,
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
              final now = DateTime.now();
              controller.caseId.value =
                  "${now.caseGeneratorDateFormate()}_${controller.txtCaseName.value.text}";

              final caseModel = EstablishCaseModel(
                  id: controller.caseId.value,
                  createdAt: now,
                  userId: controller.userId.value,
                  caseLable: controller.caseId.value,
                  caseName: controller.txtCaseName.value.text,
                  caseAddress: controller.txtCaseAddress.value.text,
                  caseDate: controller.txtCaseDate.value.text,
                  caseEquipmentNo: controller.txtCaseEquipmentName.value.text,
                  caseWeather: controller.txtCaseWeather.value.text,
                  wsStructureType: controller.selectedStructure.value,
                  wsUseFor: controller.selectedUse.value,
                  wsWallType: controller.selectedWall.value,
                  wsFlatTopMaterial: controller.selectedFlatTopMaterial.value,
                  wsFloorMaterial: controller.selectedFloor.value,
                  wsTechDescription: controller.techDescriptionStr.value,
                  wsCanvas: controller.canvasSurveyUrl.value.toString(),
                  vertical1Canvas:
                      controller.canvasVertical1Url.value.toString(),
                  vertical2Canvas:
                      controller.canvasVertical2Url.value.toString(),
                  horizontalCanvas:
                      controller.canvasHorizontalUrl.value.toString(),
                  wsWeentileDataList: [],
                  verticalMSDataList: [],
                  horizontalMSDataList: [],
                  isPdfExported: false,
                  signatureUrl: "",
                  pdfUrl: "");
              debugPrint("Himadri Final data :: ${caseModel.toJson()}");
              controller.createCase(caseModel);
            },
          ).paddingAll(10).marginOnly(bottom: 10),
        ],
      ).paddingOnly(top: 20.h).paddingSymmetric(horizontal: 12.w),
    );
  }

  Widget _buildListView(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: controller.horizontalfinalList.length,
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
    controller.photoList.add("");
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
            controller.horizontalfinalList[index].mesuringPoint!,
            fontWeight: FontWeight.bold,
            fontFamily: FontFamilyConstant.sinkinSansMedium,
            fontColor: yasRed,
          ).paddingOnly(left: 2, right: 2, bottom: 4),
          const SizedBox(
            height: 15,
          ),
          Container(
            width: double.infinity,
            height: Get.height * 0.30,
            decoration: BoxDecoration(
              color: stdwhite,
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              border: Border.all(
                width: 1,
                color: yasRed,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Obx(
                  () => InkWell(
                    onTap: () {
                      controller.takePhotoHS(context, index);
                    },
                    child: Visibility(
                      visible: controller.photoList[index] == "" ? true : false,
                      child: Align(
                        alignment: Alignment.center,
                        heightFactor: 4.0,
                        child: const Icon(
                          Icons.add_a_photo,
                          color: yasRed,
                          size: 50,
                        ).paddingAll(4),
                      ),
                    ),
                  ),
                ),
                Obx(
                  () => Visibility(
                    visible: controller.photoList[index] == "" ? false : true,
                    child: Stack(children: [
                      Center(
                        child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5)),
                            child: Image.network(
                                height: Get.height * 0.296,
                                width: Get.width,
                                fit: BoxFit.cover,
                                controller.photoList[index])),
                      ),
                      Positioned(
                          right: -8,
                          top: -6,
                          child: Obx(
                            () => InkWell(
                              onTap: () {
                                controller
                                    .deleteImage(controller.photoList[index])
                                    .then((_) {
                                  controller.photoList[index] = "";
                                  controller
                                      .horizontalfinalList[index].imageUri = "";
                                  debugPrint(
                                      'Successfully deleted storage item $index');
                                });
                              },
                              child: Visibility(
                                visible: controller.photoList[index] == ""
                                    ? false
                                    : true,
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                  size: 25,
                                ).paddingAll(10),
                              ),
                            ),
                          ))
                    ]),
                  ),
                ),
              ],
            ),
          )
        ],
      ).paddingAll(6),
    );
  }
}
