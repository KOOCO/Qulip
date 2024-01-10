import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:printing/printing.dart';
import 'package:qulip/common/assests.dart';
import 'package:qulip/common/colors.dart';
import 'package:qulip/common/strings.dart';
import 'package:qulip/common/widgets/my_button.dart';
import 'package:qulip/common/widgets/my_button_with_icon.dart';
import 'package:qulip/common/widgets/my_text.dart';
import 'package:qulip/controller/case_list_controller.dart';
import 'package:qulip/models/createcase/establish_case_model.dart';
import 'package:qulip/models/createcase/horizontal/horizontal_form_model.dart';
import 'package:qulip/models/createcase/vertical/vertical_form_model.dart';
import 'package:qulip/routes/app_routes.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:qulip/utils/storage_helper.dart';

class CaseDetailScreen extends StatelessWidget {
  CaseDetailScreen({super.key});

  final controller = Get.find<CaseListController>();
  var newIndex = 0;
  // final signUrl = "".obs;

  @override
  Widget build(BuildContext context) {
    var index = Get.arguments;
    newIndex = index;
    var modelData = controller.caseListNew[index];
    controller.isPDFExported.value = modelData.isPdfExported ?? false;
    controller.signUrl.value = modelData.signatureUrl ?? "";

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
      backgroundColor: transparentGrey,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const MyText(
                  WordStrings.caseNoLbl,
                  fontFamily: FontFamilyConstant.sinkinSans,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontColor: yasRed,
                ),
                Flexible(
                  child: MyText(
                    modelData.caseName!,
                    fontFamily: FontFamilyConstant.sinkinSans,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    fontColor: yasRed,
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ).paddingOnly(top: 15, bottom: 15),
            Divider(
              height: 1,
              thickness: 1,
              color: Colors.grey.shade400,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const MyText(
                  WordStrings.caseAddresslLbl,
                  fontFamily: FontFamilyConstant.sinkinSans,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontColor: yasRed,
                ),
                Flexible(
                  child: MyText(
                    modelData.caseAddress!,
                    fontFamily: FontFamilyConstant.sinkinSans,
                    fontWeight: FontWeight.w400,
                    maxLines: 2,
                    fontSize: 14,
                    textAlign: TextAlign.right,
                    fontColor: yasRed,
                  ),
                ),
              ],
            ).paddingOnly(top: 15, bottom: 15),
            Divider(
              height: 1,
              thickness: 1,
              color: Colors.grey.shade400,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const MyText(
                  WordStrings.caseDatelLbl,
                  fontFamily: FontFamilyConstant.sinkinSans,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontColor: yasRed,
                ),
                Flexible(
                  child: MyText(
                    modelData.caseDate!,
                    fontFamily: FontFamilyConstant.sinkinSans,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    fontColor: yasRed,
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ).paddingOnly(top: 15, bottom: 15),
            Divider(
              height: 1,
              thickness: 1,
              color: Colors.grey.shade400,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const MyText(
                  WordStrings.caseEquipmentNamelLbl,
                  fontFamily: FontFamilyConstant.sinkinSans,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontColor: yasRed,
                ),
                Flexible(
                  child: MyText(
                    modelData.caseEquipmentNo!,
                    fontFamily: FontFamilyConstant.sinkinSans,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    fontColor: yasRed,
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ).paddingOnly(top: 15, bottom: 15),
            Divider(
              height: 1,
              thickness: 1,
              color: Colors.grey.shade400,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const MyText(
                  WordStrings.caseWeatherlLbl,
                  fontFamily: FontFamilyConstant.sinkinSans,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontColor: yasRed,
                ),
                Flexible(
                  child: MyText(
                    modelData.caseWeather!,
                    fontFamily: FontFamilyConstant.sinkinSans,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    fontColor: yasRed,
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ).paddingOnly(top: 15, bottom: 15),
            Divider(
              height: 1,
              thickness: 1,
              color: Colors.grey.shade400,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const MyText(
                  WordStrings.signatureLbl,
                  fontFamily: FontFamilyConstant.sinkinSans,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontColor: yasRed,
                ),
                Obx(
                  () => controller.signUrl.value.isEmpty
                      ? InkWell(
                          onTap: () {
                            Get.toNamed(AppRoutes.signatureScreen,
                                arguments: modelData.caseLable);
                          },
                          child: const Icon(
                            Icons.edit,
                            color: yasRed,
                            size: 20,
                          ).paddingAll(4),
                        )
                      : Image.network(
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
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              ),
                            );
                          },
                        ),
                )
              ],
            ).paddingOnly(top: 15, bottom: 15),
            Divider(
              height: 1,
              thickness: 1,
              color: Colors.grey.shade400,
            ).paddingOnly(bottom: 25),
            Column(
              children: [
                MyButtonWithIcon(
                  onTap: () {
                    Get.toNamed(AppRoutes.surveyViewScreen, arguments: index);
                  },
                  image: AssetImages.surveyLogo,
                  label: WordStrings.surveyformLblCaseDetails,
                  style: const TextStyle(
                    fontSize: 14,
                    color: stdBlack,
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: const BoxDecoration(
                    color: whiteTxt,
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 6,
                        color: Colors.black26,
                      )
                    ],
                  ),
                  height: Get.height * 0.06,
                  borderRadius: 2,
                ).paddingSymmetric(horizontal: 20, vertical: 5),
                MyButtonWithIcon(
                  image: AssetImages.verticalLogo,
                  label: WordStrings.verticalMeasurementLblCaseDetails,
                  style: const TextStyle(
                    fontSize: 14,
                    color: stdBlack,
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: const BoxDecoration(
                    color: whiteTxt,
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 6,
                        color: Colors.black26,
                      )
                    ],
                  ),
                  height: Get.height * 0.06,
                  borderRadius: 2,
                  onTap: () async {
                    Get.toNamed(AppRoutes.verticalViewScreen, arguments: index);
                  },
                ).paddingSymmetric(horizontal: 20, vertical: 5),
                MyButtonWithIcon(
                  image: AssetImages.horizontalLogo,
                  label: WordStrings.horizontalMeasurementLblCaseDetails,
                  style: const TextStyle(
                    fontSize: 14,
                    color: stdBlack,
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: const BoxDecoration(
                    color: whiteTxt,
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 6,
                        color: Colors.black26,
                      )
                    ],
                  ),
                  height: Get.height * 0.06,
                  borderRadius: 2,
                  onTap: () async {
                    Get.toNamed(AppRoutes.horizontalViewScreen,
                        arguments: index);
                  },
                ).paddingSymmetric(horizontal: 20, vertical: 5),
              ],
            ).marginOnly(bottom: 15),
            Obx(
              () => Visibility(
                visible: controller.isPDFExported.value ? true : true,
                child: MyButton(
                  label: WordStrings.btnExprotLbl,
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
                    Get.toNamed(AppRoutes.pdfPreview, arguments: newIndex);
                    // showWarningForExport(
                    //     context, WordStrings.viewExportDialogMsg, modelData);
                  },
                ).paddingAll(40),
              ),
            ),
          ],
        ).paddingSymmetric(horizontal: 14.w, vertical: 4.h),
      ),
    );
  }

  Future showWarningForExport(BuildContext context, String message,
          EstablishCaseModel modelData) async =>
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const MyText(
                  WordStrings.exitAppTitle,
                  fontSize: 18,
                  fontColor: yasRed,
                  fontWeight: FontWeight.bold,
                ),
                content: MyText(
                  message,
                  fontSize: 14,
                  fontColor: stdBlack,
                ),
                actions: [
                  Row(
                    children: [
                      MyButton(
                        label: WordStrings.btnYes,
                        style: const TextStyle(
                          color: whiteTxt,
                          fontWeight: FontWeight.bold,
                        ),
                        height: Get.height * 0.03,
                        width: Get.width * 0.2,
                        borderRadius: 2,
                        onTap: () async {
                          Get.back();
                          Get.toNamed(AppRoutes.pdfPreview,
                              arguments: modelData.pdfUrl!);
                          // controller.setLoading(true);
                          // StorageHelper.read(StorageKeys.phoneNumber)
                          //     .then((value) {
                          //   controller
                          //       .getPoints(value, modelData.caseLable!)
                          //       .then((value) {
                          //     createPDF(modelData).then((value) {
                          //       controller.setLoading(false);
                          //       controller
                          //           .uploadPdf(
                          //               value, "${modelData.caseLable}.pdf")
                          //           .then((value) {
                          //         controller.setpdfurl(
                          //             modelData.caseLable!, value!);
                          //       });
                          //     });
                          //   });
                          // });
                        },
                      )..paddingOnly(left: 4, right: 4),
                      const Spacer(),
                      MyButton(
                        label: WordStrings.btnNo,
                        style: const TextStyle(
                          color: whiteTxt,
                          fontWeight: FontWeight.bold,
                        ),
                        height: Get.height * 0.03,
                        width: Get.width * 0.2,
                        borderRadius: 2,
                        onTap: () {
                          controller.isPDFExported.value = false;
                          Get.back();
                        },
                      ).paddingOnly(left: 4, right: 4),
                    ],
                  ).paddingOnly(left: 10, right: 10, top: 4, bottom: 10),
                ],
              ));
}

Future<File> createPDF(EstablishCaseModel modelData) async {
  final pdf = pw.Document();
  final ByteData bytes = await rootBundle.load(AssetImages.pdfIcon);
  final Uint8List byteList = bytes.buffer.asUint8List();
  final wsCanvasImage = await networkImage(modelData.wsCanvas!);
  final verticalCanvas1Image = await networkImage(modelData.vertical1Canvas!);

  final chineseBold = await rootBundle.load("assets/fonts/chinese.ttf");
  final chineseRegular =
      await rootBundle.load("assets/fonts/chinese-regular.ttf");
  final ttf = pw.Font.ttf(chineseBold);
  final ttfRegular = pw.Font.ttf(chineseRegular);

  pdf.addPage(pw.MultiPage(
    pageTheme: _buildTheme(
      PdfPageFormat.a4,
      ttfRegular,
      ttf,
      ttf,
    ),
    header: (context) => _buildHeader(context, modelData, byteList),
    footer: _buildFooter,
    build: (context) => [
      _buildSurveyContent(context, modelData, wsCanvasImage),
      _buildVerticalContent(context, modelData, verticalCanvas1Image),
      _buildHorizontalContent(context, modelData, verticalCanvas1Image)
    ],
  ));

  Directory? directory;
  final plugin = DeviceInfoPlugin();
  final android = await plugin.androidInfo;
  const permission = Permission.storage;
  final status = android.version.sdkInt < 33
      ? await permission.status
      : PermissionStatus.granted;
  debugPrint('>>>Status $status');

  /// here it is coming as PermissionStatus.granted
  if (status != PermissionStatus.granted) {
    await permission.request();
    if (await permission.status.isGranted) {
      directory = await getExternalStorageDirectory();

      ///perform other stuff to download file
    } else if (status == PermissionStatus.permanentlyDenied) {
      await openAppSettings();
    } else {
      await permission.request();
    }
    debugPrint('>>> ${await permission.status}');
  }

  directory = await getExternalStorageDirectory();

  // if (directory != null) {
  final saveFile = File(
    '${directory?.path}/${modelData.caseLable}.pdf',
  );

  debugPrint(saveFile.path);
  if (!await saveFile.exists()) {
    await saveFile.create(recursive: true);
  }

  // }
  return await saveFile.writeAsBytes(await pdf.save());

  // final appDocDir = await getDownloadsDirectory();
  // final appDocPath = appDocDir!.path;
  // final file = File('$appDocPath/document.pdf');
  // debugPrint('Save as file ${file.path} ...');
  // await file.writeAsBytes(await pdf.save());
  // await OpenFile.open(file.path);
}

pw.PageTheme _buildTheme(
    PdfPageFormat pageFormat, pw.Font base, pw.Font bold, pw.Font italic) {
  return pw.PageTheme(
    pageFormat: pageFormat,
    theme: pw.ThemeData.withFont(
      base: base,
      bold: bold,
    ),
  );
}

pw.Widget _buildHeader(
  pw.Context context,
  EstablishCaseModel modelData,
  Uint8List byteList,
) {
  return pw.Column(
    children: [
      pw.Row(mainAxisAlignment: pw.MainAxisAlignment.center, children: [
        pw.Image(
          pw.MemoryImage(byteList),
          // fit: pw.BoxFit.fitHeight,
        ),
      ]),
      pw.Divider(borderStyle: pw.BorderStyle.solid),
      if (context.pageNumber > 1) pw.SizedBox(height: 20)
    ],
  );
}

pw.Widget _buildFooter(pw.Context context) {
  return pw.Row(
    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
    crossAxisAlignment: pw.CrossAxisAlignment.end,
    children: [
      pw.Text(
        'Page ${context.pageNumber}/${context.pagesCount}',
        style: const pw.TextStyle(
          fontSize: 12,
          color: PdfColors.white,
        ),
      ),
    ],
  );
}

pw.Widget _buildSurveyContent(
    pw.Context context, EstablishCaseModel modelData, pw.ImageProvider image) {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    mainAxisAlignment: pw.MainAxisAlignment.center,
    children: [
      pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
        pw.Center(
          child: pw.Text(
            "${modelData.caseLable}",
            textScaleFactor: 2,
            textAlign: pw.TextAlign.center,
            style: pw.Theme.of(context).defaultTextStyle.copyWith(
                  fontWeight: pw.FontWeight.bold,
                  color: const PdfColor.fromInt(0xff000099),
                ),
          ),
        ),
        pw.Divider(borderStyle: pw.BorderStyle.solid),
        pw.Padding(
          padding: const pw.EdgeInsets.only(top: 20),
        ),
        pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.center,
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: <pw.Widget>[
            pw.Text(
              WordStrings.pdfcAddress,
              textScaleFactor: 1.4,
              style: pw.Theme.of(context).defaultTextStyle.copyWith(
                    fontWeight: pw.FontWeight.bold,
                  ),
            ),
            pw.Text(
              " ${modelData.caseAddress}",
              textScaleFactor: 1.2,
              style: pw.Theme.of(context).defaultTextStyle.copyWith(
                    fontWeight: pw.FontWeight.normal,
                  ),
            ),
          ],
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.only(top: 4),
        ),
        pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.center,
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: <pw.Widget>[
            pw.Text(
              WordStrings.pdfcDate,
              textScaleFactor: 1.4,
              style: pw.Theme.of(context).defaultTextStyle.copyWith(
                    fontWeight: pw.FontWeight.bold,
                  ),
            ),
            pw.Text(
              " ${modelData.caseDate}",
              textScaleFactor: 1.2,
              style: pw.Theme.of(context).defaultTextStyle.copyWith(
                    fontWeight: pw.FontWeight.normal,
                  ),
            ),
          ],
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.only(top: 4),
        ),
        pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.center,
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: <pw.Widget>[
            pw.Text(
              WordStrings.pdfENo,
              textScaleFactor: 1.4,
              style: pw.Theme.of(context).defaultTextStyle.copyWith(
                    fontWeight: pw.FontWeight.bold,
                  ),
            ),
            pw.Text(
              " ${modelData.caseEquipmentNo}",
              textScaleFactor: 1.2,
              style: pw.Theme.of(context).defaultTextStyle.copyWith(
                    fontWeight: pw.FontWeight.normal,
                  ),
            ),
          ],
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.only(top: 4),
        ),
        pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.center,
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: <pw.Widget>[
            pw.Text(
              WordStrings.pdfWeather,
              textScaleFactor: 1.4,
              style: pw.Theme.of(context).defaultTextStyle.copyWith(
                    fontWeight: pw.FontWeight.bold,
                  ),
            ),
            pw.Text(
              " ${modelData.caseWeather}",
              textScaleFactor: 1.2,
              style: pw.Theme.of(context).defaultTextStyle.copyWith(
                    fontWeight: pw.FontWeight.normal,
                  ),
            ),
          ],
        ),
      ]),
      pw.Padding(
        padding: const pw.EdgeInsets.only(top: 10),
      ),
      _Category(title: WordStrings.pdfSurvey),
      pw.Padding(
        padding: const pw.EdgeInsets.only(top: 10),
      ),
      pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.center,
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: <pw.Widget>[
          pw.Text(
            WordStrings.pdfStructure,
            textScaleFactor: 1.4,
            style: pw.Theme.of(context).defaultTextStyle.copyWith(
                  fontWeight: pw.FontWeight.bold,
                ),
          ),
          pw.Text(
            " ${modelData.wsStructureType}",
            textScaleFactor: 1.2,
            style: pw.Theme.of(context).defaultTextStyle.copyWith(
                  fontWeight: pw.FontWeight.normal,
                ),
          ),
        ],
      ),
      pw.Padding(
        padding: const pw.EdgeInsets.only(top: 10),
      ),
      pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.center,
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: <pw.Widget>[
          pw.Text(
            WordStrings.pdfUse,
            textScaleFactor: 1.4,
            style: pw.Theme.of(context).defaultTextStyle.copyWith(
                  fontWeight: pw.FontWeight.bold,
                ),
          ),
          pw.Text(
            " ${modelData.wsUseFor}",
            textScaleFactor: 1.2,
            style: pw.Theme.of(context).defaultTextStyle.copyWith(
                  fontWeight: pw.FontWeight.normal,
                ),
          ),
        ],
      ),
      pw.Padding(
        padding: const pw.EdgeInsets.only(top: 10),
      ),
      pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.center,
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: <pw.Widget>[
          pw.Text(
            WordStrings.pdfWall,
            textScaleFactor: 1.4,
            style: pw.Theme.of(context).defaultTextStyle.copyWith(
                  fontWeight: pw.FontWeight.bold,
                ),
          ),
          pw.Text(
            " ${modelData.wsWallType}",
            textScaleFactor: 1.2,
            style: pw.Theme.of(context).defaultTextStyle.copyWith(
                  fontWeight: pw.FontWeight.normal,
                ),
          ),
        ],
      ),
      pw.Padding(
        padding: const pw.EdgeInsets.only(top: 10),
      ),
      pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.center,
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: <pw.Widget>[
          pw.Text(
            WordStrings.pdfFlatTopMaterial,
            textScaleFactor: 1.4,
            style: pw.Theme.of(context).defaultTextStyle.copyWith(
                  fontWeight: pw.FontWeight.bold,
                ),
          ),
          pw.Text(
            " ${modelData.wsFlatTopMaterial}",
            textScaleFactor: 1.2,
            style: pw.Theme.of(context).defaultTextStyle.copyWith(
                  fontWeight: pw.FontWeight.normal,
                ),
          ),
        ],
      ),
      pw.Padding(
        padding: const pw.EdgeInsets.only(top: 10),
      ),
      pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.center,
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: <pw.Widget>[
          pw.Text(
            WordStrings.pdfFloor,
            textScaleFactor: 1.4,
            style: pw.Theme.of(context).defaultTextStyle.copyWith(
                  fontWeight: pw.FontWeight.bold,
                ),
          ),
          pw.Text(
            " ${modelData.wsFloorMaterial}",
            textScaleFactor: 1.2,
            style: pw.Theme.of(context).defaultTextStyle.copyWith(
                  fontWeight: pw.FontWeight.normal,
                ),
          ),
        ],
      ),
      pw.Padding(
        padding: const pw.EdgeInsets.only(top: 10),
      ),
      pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.center,
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: <pw.Widget>[
          pw.Text(
            WordStrings.pdfRemark,
            textScaleFactor: 1.4,
            style: pw.Theme.of(context).defaultTextStyle.copyWith(
                  fontWeight: pw.FontWeight.bold,
                ),
          ),
          pw.Text(
            " ${modelData.wsTechDescription}",
            textScaleFactor: 1.2,
            style: pw.Theme.of(context).defaultTextStyle.copyWith(
                  fontWeight: pw.FontWeight.normal,
                ),
          ),
        ],
      ),
      pw.Padding(
        padding: const pw.EdgeInsets.only(top: 10),
      ),
      pw.Center(
        child: pw.Image(image, height: 250, alignment: pw.Alignment.center),
      ),
    ],
  );
}

pw.Widget _buildVerticalContent(
    pw.Context context, EstablishCaseModel modelData, pw.ImageProvider image) {
  final tableHeaders = [
    WordStrings.viewNoLbl,
    WordStrings.viewMesuringPointLbl,
    WordStrings.viewTiltValueCMLbl,
    WordStrings.viewTiltValueLbl,
  ];
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      _Category(title: WordStrings.pdfVerticalMeasurement),
      pw.Padding(
        padding: const pw.EdgeInsets.only(top: 10),
      ),
      pw.ListView.builder(
        itemCount: modelData.verticalMSDataList.length,
        itemBuilder: (context, index) {
          return _buildVerticalNumber(
              context, modelData.verticalMSDataList[index], index);
        },
      ),
      pw.Padding(padding: const pw.EdgeInsets.only(bottom: 10)),
      pw.TableHelper.fromTextArray(
        border: null,
        cellAlignment: pw.Alignment.centerLeft,
        headerDecoration: const pw.BoxDecoration(
          borderRadius: pw.BorderRadius.all(pw.Radius.circular(2)),
          color: PdfColors.grey300,
        ),
        headerHeight: 25,
        cellHeight: 40,
        cellAlignments: {
          0: pw.Alignment.center,
          1: pw.Alignment.center,
          2: pw.Alignment.center,
          3: pw.Alignment.center,
        },
        headerStyle: pw.TextStyle(
          color: const PdfColor.fromInt(0xff000099),
          fontSize: 14,
          fontWeight: pw.FontWeight.bold,
        ),
        cellStyle: const pw.TextStyle(
          color: PdfColors.black,
          fontSize: 12,
        ),
        rowDecoration: const pw.BoxDecoration(
          border: pw.Border(
            bottom: pw.BorderSide(
              color: PdfColors.grey,
              width: 1,
            ),
          ),
        ),
        headers: List<String>.generate(
          tableHeaders.length,
          (col) => tableHeaders[col],
        ),
        data: List<List<String>>.generate(
          modelData.verticalMSDataList.length,
          (row) => List<String>.generate(
            tableHeaders.length,
            (col) => modelData.verticalMSDataList[row].getIndex(col),
          ),
        ),
      ),
      pw.Center(
        child: pw.Image(image, height: 250, alignment: pw.Alignment.center),
      ),
    ],
  );
}

pw.Widget _buildHorizontalContent(
    pw.Context context, EstablishCaseModel modelData, pw.ImageProvider image) {
  final tableHeaders = [
    WordStrings.viewHoriMesuringPointLbl,
    WordStrings.viewHoriRearViewLbl,
    WordStrings.viewHoriAheadLbl,
    WordStrings.viewHoriAssuHighLbl,
  ];
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      _Category(title: WordStrings.pdfHorizontalMeasurement),
      pw.ListView.builder(
        itemCount: modelData.horizontalMSDataList.length,
        itemBuilder: (context, index) {
          return _buildHorizontalNumber(
              context, modelData.horizontalMSDataList[index], index);
        },
      ),
      pw.Padding(padding: const pw.EdgeInsets.only(bottom: 10)),
      pw.TableHelper.fromTextArray(
        border: null,
        cellAlignment: pw.Alignment.centerLeft,
        headerDecoration: const pw.BoxDecoration(
          borderRadius: pw.BorderRadius.all(pw.Radius.circular(2)),
          color: PdfColors.grey300,
        ),
        headerHeight: 25,
        cellHeight: 40,
        cellAlignments: {
          0: pw.Alignment.center,
          1: pw.Alignment.center,
          2: pw.Alignment.center,
          3: pw.Alignment.center,
        },
        headerStyle: pw.TextStyle(
          color: const PdfColor.fromInt(0xff000099),
          fontSize: 14,
          fontWeight: pw.FontWeight.bold,
        ),
        cellStyle: const pw.TextStyle(
          color: PdfColors.black,
          fontSize: 12,
        ),
        rowDecoration: const pw.BoxDecoration(
          border: pw.Border(
            bottom: pw.BorderSide(
              color: PdfColors.grey,
              width: 1,
            ),
          ),
        ),
        headers: List<String>.generate(
          tableHeaders.length,
          (col) => tableHeaders[col],
        ),
        data: List<List<String>>.generate(
          modelData.horizontalMSDataList.length,
          (row) => List<String>.generate(
            tableHeaders.length,
            (col) => modelData.horizontalMSDataList[row].getIndex(col),
          ),
        ),
      ),
      pw.Center(
        child: pw.Image(image, height: 250, alignment: pw.Alignment.center),
      ),
    ],
  );
}

pw.Widget _buildHorizontalNumber(
    pw.Context context, HorizontalDataModel modelData, int index) {
  return pw.Container(
    decoration: const pw.BoxDecoration(
      borderRadius: pw.BorderRadius.all(pw.Radius.circular(8)),
      color: PdfColors.grey100,
    ),
    child: pw.Padding(
      padding: const pw.EdgeInsets.all(14),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        mainAxisAlignment: pw.MainAxisAlignment.center,
        children: [
          pw.Text(
            "${WordStrings.numberLbl} ${index + 1}",
            textScaleFactor: 1.2,
            style: pw.Theme.of(context).defaultTextStyle.copyWith(
                  fontWeight: pw.FontWeight.normal,
                ),
          ),
          pw.Padding(
            padding: const pw.EdgeInsets.only(top: 10),
          ),
          // pw.Center(
          //   child: pw.ClipRRect(
          //     child: pw.Image(v, height: 250, alignment: pw.Alignment.center),
          //   ),
          // )
        ],
      ),
    ),
  );
}

pw.Widget _buildVerticalNumber(
    pw.Context context, VerticalFormModel modelData, int index) {
  return pw.Container(
      decoration: const pw.BoxDecoration(
        borderRadius: pw.BorderRadius.all(pw.Radius.circular(8)),
        color: PdfColors.grey100,
      ),
      child: pw.Padding(
        padding: const pw.EdgeInsets.all(14),
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          mainAxisAlignment: pw.MainAxisAlignment.center,
          children: [
            pw.Text(
              "${WordStrings.numberLbl} ${index + 1}",
              textScaleFactor: 1.5,
              style: pw.Theme.of(context).defaultTextStyle.copyWith(
                    fontWeight: pw.FontWeight.normal,
                  ),
            ),
            pw.Padding(
              padding: const pw.EdgeInsets.only(top: 10),
            ),
            pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: <pw.Widget>[
                pw.Text(
                  "${WordStrings.highDifferenceLbl}:",
                  textScaleFactor: 1.3,
                  style: pw.Theme.of(context).defaultTextStyle.copyWith(
                        fontWeight: pw.FontWeight.bold,
                      ),
                ),
                pw.Text(
                  " ${modelData.highDifference}",
                  textScaleFactor: 1.2,
                  style: pw.Theme.of(context).defaultTextStyle.copyWith(
                        fontWeight: pw.FontWeight.normal,
                      ),
                ),
              ],
            ),
            pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: <pw.Widget>[
                pw.Text(
                  "${WordStrings.viewTiltDirectionLbl}:",
                  textScaleFactor: 1.3,
                  style: pw.Theme.of(context).defaultTextStyle.copyWith(
                        fontWeight: pw.FontWeight.bold,
                      ),
                ),
                pw.Text(
                  " ${modelData.titlDirection}",
                  textScaleFactor: 1.2,
                  style: pw.Theme.of(context).defaultTextStyle.copyWith(
                        fontWeight: pw.FontWeight.normal,
                      ),
                ),
              ],
            ),
            pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: <pw.Widget>[
                pw.Text(
                  "${WordStrings.viewTiltValueLbl}:",
                  textScaleFactor: 1.3,
                  style: pw.Theme.of(context).defaultTextStyle.copyWith(
                        fontWeight: pw.FontWeight.bold,
                      ),
                ),
                pw.Text(
                  " ${modelData.tiltValue}",
                  textScaleFactor: 1.2,
                  style: pw.Theme.of(context).defaultTextStyle.copyWith(
                        fontWeight: pw.FontWeight.normal,
                      ),
                ),
              ],
            ),
          ],
        ),
      ));
}

class _Category extends pw.StatelessWidget {
  _Category({required this.title});

  final String title;

  @override
  pw.Widget build(pw.Context context) {
    return pw.Container(
      decoration: const pw.BoxDecoration(
        color: PdfColor.fromInt(0xff000099),
        borderRadius: pw.BorderRadius.all(pw.Radius.circular(6)),
      ),
      margin: const pw.EdgeInsets.only(bottom: 10, top: 10),
      padding: const pw.EdgeInsets.fromLTRB(10, 4, 10, 4),
      child: pw.Text(title,
          textScaleFactor: 1.5,
          style: const pw.TextStyle(color: PdfColor.fromInt(0xffFFF7F7))),
    );
  }
}
