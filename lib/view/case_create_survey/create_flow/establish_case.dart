
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
import 'package:qulip/models/createcase/establish_case_model.dart';
import 'package:qulip/routes/app_routes.dart';
import 'package:qulip/utils/datetime_helper.dart';
import 'package:qulip/utils/storage_helper.dart';
import 'package:qulip/utils/string_helper.dart';

class CreateCaseScreen extends StatelessWidget {
  CreateCaseScreen({super.key});

  final controller = Get.put(EstablishCaseController());
  DateTime sDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: stdwhite,
        foregroundColor: yasRed,
        centerTitle: true,
        title: const MyText(
          WordStrings.caseCreatelLbl,
          fontFamily: FontFamilyConstant.sinkinSans,
          fontSize: 18,
          fontColor: yasRed,
        ),
      ),
      backgroundColor: stdwhite,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            MyTextField(
              fullBorder: true,
              hasFloatingLabel: false,
              controller: controller.txtCaseName,
              keyboard: TextInputType.text,
              labelText: WordStrings.caseNamelLbl,
              hintText: WordStrings.caseNamelLbl,
            ).paddingSymmetric(vertical: 10.h),
            MyTextField(
              fullBorder: true,
              hasFloatingLabel: false,
              controller: controller.txtCaseAddress,
              keyboard: TextInputType.text,
              labelText: WordStrings.caseAddresslLbl,
              hintText: WordStrings.caseAddresslLbl,
            ).paddingSymmetric(vertical: 10.h),
            GestureDetector(
              onTap: () {
                selectDate(
                  context: context,
                  selectedDate: sDate,
                  onSelect: (dateTime) {
                    sDate = dateTime;
                    controller.txtCaseDate.text = sDate.date2Only();
                  },
                );
              },
              child: Theme(
                data: ThemeData(
                  disabledColor: stdBlack,
                ),
                child: MyTextField(
                  suffixIcon: const Icon(
                    Icons.calendar_month,
                    color: yasRed,
                  ),
                  enabled: false,
                  fillColor: yasRed,
                  fullBorder: true,
                  isDateField: true,
                  hasFloatingLabel: false,
                  controller: controller.txtCaseDate,
                  labelText: WordStrings.caseDatelLbl,
                  hintText: WordStrings.caseDatelLbl,
                ),
              ),
            ).paddingSymmetric(vertical: 10.h),
            MyTextField(
              fullBorder: true,
              hasFloatingLabel: false,
              controller: controller.txtCaseEquipmentName,
              keyboard: TextInputType.text,
              labelText: WordStrings.caseEquipmentNamelLbl,
              hintText: WordStrings.caseEquipmentNamelLbl,
            ).paddingSymmetric(vertical: 10.h),
            MyTextField(
              fullBorder: true,
              hasFloatingLabel: false,
              controller: controller.txtCaseWeather,
              keyboard: TextInputType.text,
              labelText: WordStrings.caseWeatherlLbl,
              hintText: WordStrings.caseWeatherlLbl,
            ).paddingSymmetric(vertical: 10.h),
            MyButton(
              label: WordStrings.nextLbl,
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
                // final caseModel = EstablishCaseModel(
                //     id: "${controller.txtCaseName.value.text}_${getCaseNumber()}",
                //     userId: StorageHelper.read(StorageKeys.userId).toString(),
                //     caseName: controller.txtCaseName.value.text,
                //     caseAddress: controller.txtCaseAddress.value.text,
                //     caseDate: controller.txtCaseDate.value.text,
                //     caseEquipmentNo: controller.txtCaseEquipmentName.value.text,
                //     caseWeather: controller.txtCaseWeather.value.text);
                controller.storeCaseEstablishData();
              },
            ).paddingOnly(top: Get.height * 0.04),
          ],
        ).paddingOnly(top: 20.h).paddingSymmetric(horizontal: 14.w),
      ),
    );
  }

  Future<void> selectDate({
    required BuildContext context,
    required DateTime? selectedDate,
    required Function(DateTime dateTime) onSelect,
  }) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      onSelect.call(picked);
    }
  }
}
