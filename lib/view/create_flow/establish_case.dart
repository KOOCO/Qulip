import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:qulip/common/assests.dart';
import 'package:qulip/common/colors.dart';
import 'package:qulip/common/strings.dart';
import 'package:qulip/common/widgets/my_button.dart';
import 'package:qulip/common/widgets/my_image.dart';
import 'package:qulip/common/widgets/my_text.dart';
import 'package:qulip/common/widgets/my_textfield.dart';
import 'package:qulip/controller/establish_case_controller.dart';
import 'package:qulip/routes/app_routes.dart';

class EstablishCaseScreen extends StatefulWidget {
  const EstablishCaseScreen({super.key});

  @override
  State<EstablishCaseScreen> createState() => _EstablishCaseScreenState();
}

class _EstablishCaseScreenState extends State<EstablishCaseScreen> {
  final controller = Get.put(EstablishCaseController());
  DateTime selectedDate = DateTime.now();

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
            hintText: WordStrings.caseNamelLbl,
          ).paddingOnly(top: 10.h).paddingSymmetric(horizontal: 20.w),
          MyTextField(
            fullBorder: true,
            hasFloatingLabel: false,
            controller: controller.txtCaseName,
            maxLength: 10,
            keyboard: TextInputType.text,
            hintText: WordStrings.caseAddresslLbl,
          ).paddingOnly(top: 10.h).paddingSymmetric(horizontal: 20.w),
          Container(
            alignment: Alignment.center,
            height: 60,
            margin: const EdgeInsets.only(left: 45, right: 45, top: 20),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              border: Border.all(
                width: 1,
                color: yasRed,
              ),
            ),
            child: Row(children: [
              Expanded(
                flex: 1,
                child: MyTextField(
                  fullBorder: false,
                  hasBorder: false,
                  hasFloatingLabel: false,
                  controller: controller.txtCaseDate,
                  keyboard: TextInputType.text,
                  hintText: WordStrings.caseDatelLbl,
                ),
              ),
              InkWell(
                onTap: () {
                  _selectDate(context);
                },
                child: Container(
                    margin: const EdgeInsets.only(right: 20),
                    child: const Icon(
                      Icons.calendar_month,
                      color: yasRed,
                    )),
              )
            ]),
          ),
          MyTextField(
            fullBorder: true,
            hasFloatingLabel: false,
            controller: controller.txtCaseName,
            maxLength: 10,
            keyboard: TextInputType.text,
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
              Get.toNamed(AppRoutes.surveyForm1CreateScreen);
            },
          )
              .paddingOnly(top: 20.h)
              .paddingSymmetric(horizontal: 20)
              .marginOnly(bottom: 50),
        ],
      ).paddingSymmetric(horizontal: 14.w, vertical: 4.h),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        final DateFormat formatter = DateFormat('yyyy-MM-dd');
        final String formatted = formatter.format(selectedDate);
        controller.txtCaseDate.text = formatted;
      });
    }
  }
}
