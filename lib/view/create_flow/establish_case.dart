import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qulip/common/assests.dart';
import 'package:qulip/common/colors.dart';
import 'package:qulip/common/strings.dart';
import 'package:qulip/common/widgets/my_button.dart';
import 'package:qulip/common/widgets/my_text.dart';
import 'package:qulip/common/widgets/my_textfield.dart';
import 'package:qulip/controller/establish_case_controller.dart';

class EstablishCaseScreen extends StatefulWidget {
  const EstablishCaseScreen({super.key});

  @override
  State<EstablishCaseScreen> createState() => _EstablishCaseScreenState();
}

class _EstablishCaseScreenState extends State<EstablishCaseScreen> {

  final controller = Get.put(EstablishCaseController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const MyText(
          WordStrings.caseCreatelLbl,
          fontFamily: FontFamilyConstant.sinkinSans,
          fontSize: 18,
          fontColor: yasRed,
        ),
        ),
        body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyTextField(
              fullBorder: true,
              hasFloatingLabel: false,
              controller: controller.txtCaseName,
              maxLength: 10,
              keyboard: TextInputType.text,
              labelText: WordStrings.caseNamelLbl,
              hintText: WordStrings.caseNamelLbl,
            ).paddingOnly(top: 10.h).paddingSymmetric(horizontal: 20.w),
            MyTextField(
              fullBorder: true,
              hasFloatingLabel: false,
              controller: controller.txtCaseName,
              maxLength: 10,
              keyboard: TextInputType.text,
              labelText: WordStrings.caseAddresslLbl,
              hintText: WordStrings.caseAddresslLbl,
            ).paddingOnly(top: 10.h).paddingSymmetric(horizontal: 20.w),
            MyTextField(
              fullBorder: true,
              hasFloatingLabel: false,
              controller: controller.txtCaseName,
              maxLength: 10,
              keyboard: TextInputType.text,
              labelText: WordStrings.caseDatelLbl,
              hintText: WordStrings.caseDatelLbl,
            ).paddingOnly(top: 10.h).paddingSymmetric(horizontal: 20.w),
            MyTextField(
              fullBorder: true,
              hasFloatingLabel: false,
              controller: controller.txtCaseName,
              maxLength: 10,
              keyboard: TextInputType.text,
              labelText: WordStrings.caseEquipmentNamelLbl,
              hintText: WordStrings.caseEquipmentNamelLbl,
            ).paddingOnly(top: 10.h).paddingSymmetric(horizontal: 20.w),
            MyTextField(
              fullBorder: true,
              hasFloatingLabel: false,
              controller: controller.txtCaseName,
              maxLength: 10,
              keyboard: TextInputType.text,
              labelText: WordStrings.caseWeatherlLbl,
              hintText: WordStrings.caseWeatherlLbl,
            ).paddingOnly(top: 10.h).paddingSymmetric(horizontal: 20.w),
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
                
              },
            ).paddingOnly(top: 20.h).paddingSymmetric(horizontal: 20)
            .marginOnly(bottom: 50),
        ],
      ).paddingSymmetric(horizontal: 14.w, vertical: 4.h),

      
        );
  }
}