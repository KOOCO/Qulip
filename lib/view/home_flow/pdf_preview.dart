import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:qulip/common/assests.dart';
import 'package:qulip/common/strings.dart';
import 'package:qulip/controller/case_list_controller.dart';
import 'package:qulip/models/createcase/establish_case_model.dart';
import 'package:qulip/models/createcase/horizontal/horizontal_form_model.dart';
import 'package:qulip/models/createcase/vertical/vertical_form_model.dart';
import 'package:qulip/models/createcase/weential/weential_data_model.dart';
// import 'package:printing/printing.dart';

class PdfPreviewPage extends StatelessWidget {
  PdfPreviewPage({super.key});

  PdfColor themeColor = const PdfColor.fromInt(0xff000099);
  PdfColor lightGreen = const PdfColor.fromInt(0xffcdf1e7);

  final controller = Get.find<CaseListController>();

  @override
  Widget build(BuildContext context) {
    var index = Get.arguments;
    var modelData = controller.caseListNew[index];
    return Scaffold(
        appBar: AppBar(
          title: const Text('PDF Preview'),
        ),
        body: PdfPreview(
          allowPrinting: false,
          allowSharing: false,
          canChangeOrientation: false,
          canChangePageFormat: false,
          actions: <PdfPreviewAction>[
            PdfPreviewAction(
              icon: const Icon(Icons.save),
              onPressed: _saveAsFile,
            ),
          ],
          build: (context) => makePdf(modelData),
        ));
  }

  Future<void> _saveAsFile(
    BuildContext context,
    LayoutCallback build,
    PdfPageFormat pageFormat,
  ) async {
    final bytes = await build(pageFormat);

    final appDocDir = await getDownloadsDirectory();
    final appDocPath = appDocDir!.path;
    final file = File('$appDocPath/document.pdf');
    print('Save as file ${file.path} ...');
    await file.writeAsBytes(bytes);
    await OpenFile.open(file.path);
  }

  Future<Uint8List> makePdf(EstablishCaseModel modelData) async {
    final pdf = pw.Document();

    final wsCanvasImage = await networkImage(modelData.wsCanvas!);
    final verticalCanvas1Image = await networkImage(modelData.vertical1Canvas!);
    final verticalCanvas2Image = await networkImage(modelData.vertical2Canvas!);
    final horizontalCanvasImage =
        await networkImage(modelData.horizontalCanvas!);

    final chineseBold = await rootBundle.load("assets/fonts/chinese.ttf");
    final chineseRegular =
        await rootBundle.load("assets/fonts/chinese-regular.ttf");
    final ttf = pw.Font.ttf(chineseBold);
    final ttfRegular = pw.Font.ttf(chineseRegular);

    final ByteData bytes = await rootBundle.load(AssetImages.pdfIcon);
    final Uint8List byteList = bytes.buffer.asUint8List();

    pdf.addPage(pw.MultiPage(
      maxPages: 100,
      pageTheme: _buildTheme(
        PdfPageFormat.a4,
        ttfRegular,
        ttf,
        ttf,
      ),
      // header: (context) => _buildHeader(context, modelData, byteList),
      // footer: _buildFooter,
      build: (context) => [
        _buildSurveyContent(context, modelData, wsCanvasImage, byteList),
        _buildVMSData(
            context, modelData, verticalCanvas1Image, verticalCanvas2Image),
        _buildHMSData(context, modelData, horizontalCanvasImage)
      ],
    ));

    return pdf.save();
  }
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

pw.Widget _buildFooter(
  pw.Context context,
) {
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

pw.Widget _buildSurveyContent(pw.Context context, EstablishCaseModel modelData,
    pw.ImageProvider image, Uint8List byteList) {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    mainAxisAlignment: pw.MainAxisAlignment.center,
    children: [
      pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
        pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Align(
                  alignment: pw.Alignment.topLeft,
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
              ],
            ),
            pw.Align(
              alignment: pw.Alignment.topRight,
              child: pw.Image(
                pw.MemoryImage(byteList),
                // fit: pw.BoxFit.fitHeight,
              ),
            ),
          ],
        ),
      ]),
      _Category(title: WordStrings.pdfSurvey),
      pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
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
            ],
          ),
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
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
            ],
          )
        ],
      ),
      pw.Padding(padding: const pw.EdgeInsets.only(bottom: 8)),
      pw.ListView.builder(
        itemCount: modelData.wsWeentileDataList.length,
        itemBuilder: (context, index) {
          return _buildWSNumber(
              context, modelData.wsWeentileDataList[index], index);
        },
      ),
      pw.Align(
        alignment: pw.Alignment.topLeft,
        child: pw.Image(image, height: 200),
      ),
    ],
  );
}

pw.Widget _buildWSNumber(
    pw.Context context, WeentialDataModel modelData, int index) {
  return pw.Container(
    decoration: pw.BoxDecoration(
      borderRadius: const pw.BorderRadius.all(pw.Radius.circular(8)),
      color: PdfColors.grey300,
      border: pw.Border.all(
        width: 0.5,
        color: PdfColors.blue400,
      ),
    ),
    child: pw.Padding(
      padding: const pw.EdgeInsets.only(top: 14, bottom: 10, left: 6, right: 6),
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
          pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Row(
                      crossAxisAlignment: pw.CrossAxisAlignment.center,
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: <pw.Widget>[
                        pw.Text(
                          "${WordStrings.locationLbl}:",
                          textScaleFactor: 1.3,
                          style: pw.Theme.of(context).defaultTextStyle.copyWith(
                                fontWeight: pw.FontWeight.bold,
                              ),
                        ),
                        pw.Text(
                          " ${modelData.wsLocation}",
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
                          "${WordStrings.situationLbl}:",
                          textScaleFactor: 1.3,
                          style: pw.Theme.of(context).defaultTextStyle.copyWith(
                                fontWeight: pw.FontWeight.bold,
                              ),
                        ),
                        pw.Text(
                          " ${modelData.wsSituation}",
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
                          "${WordStrings.crackLengthLbl}:",
                          textScaleFactor: 1.3,
                          style: pw.Theme.of(context).defaultTextStyle.copyWith(
                                fontWeight: pw.FontWeight.bold,
                              ),
                        ),
                        pw.Text(
                          " ${modelData.wsCrackedLength}",
                          textScaleFactor: 1.2,
                          style: pw.Theme.of(context).defaultTextStyle.copyWith(
                                fontWeight: pw.FontWeight.normal,
                              ),
                        ),
                      ],
                    ),
                  ]),
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.Row(
                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: <pw.Widget>[
                      pw.Text(
                        "${WordStrings.crackWidthLbl}:",
                        textScaleFactor: 1.3,
                        style: pw.Theme.of(context).defaultTextStyle.copyWith(
                              fontWeight: pw.FontWeight.bold,
                            ),
                      ),
                      pw.Text(
                        " ${modelData.wsCrackedWidth}",
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
                        "${WordStrings.flawLbl}:",
                        textScaleFactor: 1.3,
                        style: pw.Theme.of(context).defaultTextStyle.copyWith(
                              fontWeight: pw.FontWeight.bold,
                            ),
                      ),
                      pw.Text(
                        " ${modelData.wsFlaw}",
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
                        "${WordStrings.sfDescriptionLbl}:",
                        textScaleFactor: 1.3,
                        style: pw.Theme.of(context).defaultTextStyle.copyWith(
                              fontWeight: pw.FontWeight.bold,
                            ),
                      ),
                      pw.Text(
                        " ${modelData.wsTechDescr}",
                        textScaleFactor: 1.2,
                        style: pw.Theme.of(context).defaultTextStyle.copyWith(
                              fontWeight: pw.FontWeight.normal,
                            ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
//           pw.GridView(
//         crossAxisCount: 5,
//         childAspectRatio: 1,
//         children: modelData.wsImagesList.map((image) {
//           var url = "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_1280.jpg";
// var response = await get(Uri.parse(url));
// var data = response.bodyBytes;
// PdfBitmap image = pw.PdfBitmap(data);
//           return pw.Container(
//             child: pw.Image(pw.ImageProxy(?????), fit: pw.BoxFit.cover),
//           );
//         }).toList(),
//       ),
        ],
      ),
    ),
  );
}

pw.Widget _buildVMSData(pw.Context context, EstablishCaseModel modelData,
    pw.ImageProvider image1, pw.ImageProvider image2) {
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
      pw.ListView.builder(
        itemCount: modelData.verticalMSDataList.length,
        itemBuilder: (context, index) {
          return _buildVSNumber(
              context, modelData.verticalMSDataList[index], index);
        },
      ),
      pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
          children: [
            pw.Align(
              alignment: pw.Alignment.topCenter,
              child: pw.Image(image1, height: 200),
            ),
            pw.Align(
              alignment: pw.Alignment.topCenter,
              child: pw.Image(image2, height: 200),
            ),
          ])
    ],
  );
}

pw.Widget _buildVSNumber(
    pw.Context context, VerticalFormModel modelData, int index) {
  return pw.Container(
      decoration: pw.BoxDecoration(
        borderRadius: const pw.BorderRadius.all(pw.Radius.circular(8)),
        color: PdfColors.grey300,
        border: pw.Border.all(
          width: 0.5,
          color: PdfColors.blue400,
        ),
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
            pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
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
                ]),
            pw.Row(children: [
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
            ]),
          ],
        ),
      ));
}

pw.Widget _buildHMSData(
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
      pw.Align(
        alignment: pw.Alignment.topLeft,
        child: pw.Image(image, height: 200),
      ),
      // pw.ListView.builder(
      //   itemCount: modelData.horizontalMSDataList.length,
      //   itemBuilder: (context, index) {
      //     // imageUri(modelData.horizontalMSDataList[index])
      //     //     .then((value) => dummyProvider = value);
      //     return _builHSNumber(context, modelData.horizontalMSDataList[index],
      //         dummyProvider, index);
      //   },
      // ),
    ],
  );
}

pw.Widget _builHSNumber(pw.Context context, HorizontalDataModel modelData,
    pw.ImageProvider image, int index) {
  return pw.Container(
    width: double.infinity,
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
          pw.Padding(padding: const pw.EdgeInsets.all(4)),
          pw.ClipRRect(
            child: pw.Image(image, height: 200, alignment: pw.Alignment.center),
          )
        ],
      ),
    ),
  );
}

class _Category extends pw.StatelessWidget {
  _Category({required this.title});

  final String title;

  @override
  pw.Widget build(pw.Context context) {
    return pw.Container(
      width: double.infinity,
      decoration: const pw.BoxDecoration(
        color: PdfColor.fromInt(0xff000099),
        borderRadius: pw.BorderRadius.all(pw.Radius.circular(6)),
      ),
      margin: const pw.EdgeInsets.only(bottom: 10, top: 16),
      padding: const pw.EdgeInsets.fromLTRB(10, 4, 10, 4),
      child: pw.Text(title,
          textAlign: pw.TextAlign.center,
          textScaleFactor: 1.5,
          style: const pw.TextStyle(color: PdfColor.fromInt(0xffFFF7F7))),
    );
  }
}
