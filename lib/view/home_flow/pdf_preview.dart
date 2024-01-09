import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:qulip/common/assests.dart';
import 'package:qulip/controller/case_list_controller.dart';
import 'package:qulip/models/createcase/establish_case_model.dart';
// import 'package:printing/printing.dart';

class PdfPreviewPage extends StatelessWidget {
  PdfPreviewPage({super.key});

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
        build: (context) => makePdf(modelData),
      ),
    );
  }

  Future<Uint8List> makePdf(EstablishCaseModel modelData) async {
    final pdf = pw.Document();
    final ByteData bytes = await rootBundle.load(AssetImages.splashLogo);
    final Uint8List byteList = bytes.buffer.asUint8List();
    pdf.addPage(pw.Page(
        margin: const pw.EdgeInsets.all(10),
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Header(text: "About Cat", level: 1),
                      pw.Image(pw.MemoryImage(byteList),
                          fit: pw.BoxFit.fitHeight, height: 100, width: 100)
                    ]),
                pw.Divider(borderStyle: pw.BorderStyle.dashed),
                pw.Paragraph(text: modelData.caseName),
              ]);
        }));
    return pdf.save();
  }
}
