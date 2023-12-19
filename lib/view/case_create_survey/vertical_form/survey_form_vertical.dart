import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qulip/common/assests.dart';
import 'package:qulip/common/colors.dart';
import 'package:qulip/common/strings.dart';
import 'package:qulip/common/widgets/my_button.dart';
import 'package:qulip/common/widgets/my_dropdown_area.dart';
import 'package:qulip/common/widgets/my_text.dart';
import 'package:qulip/common/widgets/my_textfield.dart';
import 'package:qulip/controller/establish_case_controller.dart';
import 'package:qulip/utils/text_style_helper.dart';

class SurveyFormVertical extends StatelessWidget {
  SurveyFormVertical({super.key});

  final controller = Get.put(EstablishCaseController());
  DateTime sDate = DateTime.now();
  RxString enteredTechDesc = ''.obs;
  final isImageSelect = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: stdwhite,
        foregroundColor: yasRed,
        centerTitle: true,
        title: const MyText(
          "${WordStrings.surveyFormVerticallLbl}",
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
              controller.takePhoto(context);
            },
          )
        ],
      ),
      backgroundColor: stdwhite,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Obx(() => _forumTabBarItem(context)),
          MyButton(
            label: WordStrings.newMeasuringPointNumber,
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
              controller.addWidget();
              debugPrint(controller.listOfForm.length.toString());
            },
          )
              .paddingOnly(top: 20.h)
              .paddingSymmetric(horizontal: 20)
              .marginOnly(bottom: 10),
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
              controller.addWidget();
              debugPrint(controller.listOfForm.length.toString());
            },
          )
              .paddingOnly(top: 20.h)
              .paddingSymmetric(horizontal: 20)
              .marginOnly(bottom: 50),
        ],
      ).paddingOnly(top: 20.h).paddingSymmetric(horizontal: 12.w),
    );
  }

  validateForm(){
    if(controller.txtUpperPoint.text.toString().isEmpty 
    && controller.txtLowerPoint.text.toString().isEmpty
    && controller.highDifference == 0 ){

    }
  }

  Widget _forumTabBarItem(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: controller.listOfForm.length,
        itemBuilder: (context, index) {
          return _buildList(context, controller.listOfForm[index]);
        },
      ),
    );
  }

  Widget _buildList(BuildContext context, int number) {
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
            "Number $number",
            fontFamily: FontFamilyConstant.sinkinSans,
            fontSize: 14,
            fontColor: yasRed,
          ),
          children: [_buildItem(context)],
        ),
      ),
    );
  }

  Widget _buildItem(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: cardBg,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          MyTextField(
            onChanged: (value){
              if(value.isNotEmpty){
                controller.calculateHighDifference(controller.txtUpperPoint.text.toString(), controller.txtLowerPoint.text.toString());
              }
            },
            fullBorder: true,
            hasFloatingLabel: false,
            controller: controller.txtUpperPoint,
            keyboard: TextInputType.text,
            labelText: WordStrings.upperPointLbl,
            hintText: WordStrings.upperPointLbl,
          ),
          const SizedBox(
            height: 15,
          ),
          MyTextField(
            onChanged: (value){
              if(value.isNotEmpty){
                controller.calculateHighDifference(controller.txtUpperPoint.text.toString(), controller.txtLowerPoint.text.toString());
              }
            },
            fullBorder: true,
            hasFloatingLabel: false,
            controller: controller.txtLowerPoint,
            keyboard: TextInputType.text,
            labelText: WordStrings.lowerPointLbl,
            hintText: WordStrings.lowerPointLbl,
          ),
          const SizedBox(
            height: 15,
          ),
          Obx(() => MyText(
            "${WordStrings.highDifferenceLbl} ${controller.highDifference}",
            fontWeight: FontWeight.w400,
            fontFamily: FontFamilyConstant.sinkinSansMedium,
            fontColor: stdBlack,
          ).paddingOnly(left: 2, right: 2, bottom: 4)),
          const SizedBox(
            height: 15,
          ),
          Container(
            height: 35.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: stdwhite,
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              border: Border.all(
                width: 0.5,
                color: yasRed,
              ),
              boxShadow: const [
                BoxShadow(
                  blurRadius: 2,
                  color: yasRed,
                )
              ],
            ),
            child: DropdownButtonHideUnderline(
              child: MyDropDownArea(
                iconColor: lightGrey,
                isExpanded: false,
                items: controller.tileDirectionList.map((element) {
                  return DropdownMenuItem<String>(
                    value: element,
                    child: MyText(
                      element,
                      fontStyle: MyTextTheme14Normal.black(),
                    ),
                  );
                }).toList(),
                selectedItemBuilder: (context) {
                  return controller.tileDirectionList
                      .map(
                        (element) => Container(
                          height: 25,
                          alignment: Alignment.centerLeft,
                          child: MyText(
                            element,
                            fontStyle: MyTextTheme14Normal.black(),
                          ),
                        ),
                      )
                      .toList();
                },
                value: controller.selectedDirection.value,
                onchange: (value) {
                  if (value != null) {
                    controller.selectedDirection.value = value;
                  }
                },
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          MyTextField(
            fullBorder: true,
            hasFloatingLabel: false,
            controller: controller.txtLeftPoint,
            keyboard: TextInputType.text,
            labelText: WordStrings.leftPointLbl,
            hintText: WordStrings.leftPointLbl,
          ),
          const SizedBox(
            height: 15,
          ),
          MyTextField(
            fullBorder: true,
            hasFloatingLabel: false,
            controller: controller.txtRightPoint,
            keyboard: TextInputType.text,
            labelText: WordStrings.rightPointLbl,
            hintText: WordStrings.rightPointLbl,
          ),
          const SizedBox(
            height: 15,
          ),
          const MyText(
            WordStrings.tiltValueLbl,
            fontWeight: FontWeight.w400,
            fontFamily: FontFamilyConstant.sinkinSansMedium,
            fontColor: stdBlack,
          ).paddingOnly(left: 2, right: 2, bottom: 4),
          const SizedBox(
            height: 15,
          ),
          const MyText(
            WordStrings.slopeLbl,
            fontWeight: FontWeight.w400,
            fontFamily: FontFamilyConstant.sinkinSansMedium,
            fontColor: stdBlack,
          ).paddingOnly(left: 2, right: 2, bottom: 4),
          const SizedBox(
            height: 15,
          ),
          const MyText(
            WordStrings.diagramLbl,
            fontWeight: FontWeight.w400,
            fontFamily: FontFamilyConstant.sinkinSansMedium,
            fontColor: stdBlack,
          ).paddingOnly(left: 2, right: 2, bottom: 4),
          const SizedBox(
            height: 200,
          ),
          const MyText(
            WordStrings.sfDescriptionLbl,
            fontWeight: FontWeight.w400,
            fontFamily: FontFamilyConstant.sinkinSansMedium,
            fontColor: yasRed,
          ).paddingOnly(left: 2, right: 2, bottom: 4),
          TextField(
            maxLength: 50,
            maxLines: 3,
            cursorColor: yasRed,
            onChanged: (value) {
              enteredTechDesc.value = value;
            },
            decoration: InputDecoration(
                alignLabelWithHint: true,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: yasRed),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                border: const OutlineInputBorder(
                  borderSide: BorderSide(color: yasRed),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: yasRed),
                ),
                floatingLabelStyle: const TextStyle(color: yasRed),
                labelText: WordStrings.sfDescriptionHint,
                labelStyle: const TextStyle(fontSize: 14, color: stdgrey),
                hintText: '',
                counterText: '${enteredTechDesc.value.length.toString()}/ 50',
                counterStyle: const TextStyle(fontSize: 12, color: yasRed)),
          ),
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
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Obx(
                  () => InkWell(
                    onTap: () {
                      controller.photoList.removeLast();
                    },
                    child: Visibility(
                      visible: controller.photoList.isNotEmpty ? false : false,
                      // visible: controller.photoList.isNotEmpty ? true : false,
                      child: const Icon(
                        Icons.delete,
                        color: yasRed,
                        size: 25,
                      ).paddingAll(10),
                    ),
                  ),
                ),
                Obx(
                  () => InkWell(
                    onTap: () {
                      controller.takePhoto(context);
                    },
                    child: Visibility(
                      // visible: controller.photoList.isNotEmpty ? false : true,
                      visible: controller.photoList.isNotEmpty ? true : true,
                      child: Center(
                        heightFactor: 3.0,
                        child: const Icon(
                          Icons.image_search,
                          color: yasRed,
                          size: 50,
                        ).paddingAll(10),
                      ),
                    ),
                  ),
                ),
                // Visibility(
                //   visible: controller.photoList.isNotEmpty ? true : false,
                //   child: _buildImageList(),
                // )
              ],
            ),
          ),
        ],
      ).paddingAll(6),
    );
  }
}
