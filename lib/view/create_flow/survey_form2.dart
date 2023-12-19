import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_painter/image_painter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qulip/common/assests.dart';
import 'package:qulip/common/colors.dart';
import 'package:qulip/common/strings.dart';
import 'package:qulip/common/widgets/my_text.dart';
import 'package:open_file/open_file.dart';

class SurveyForm2Screen extends StatefulWidget {
  const SurveyForm2Screen({super.key});

  @override
  State<SurveyForm2Screen> createState() => _SurveyForm2ScreenState();
}

class _SurveyForm2ScreenState extends State<SurveyForm2Screen> {
  List<Rect> rectangles = [];
  late Rect currentRectangle;

  @override
  void initState() {
    super.initState();
    currentRectangle = Rect.largest;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const MyText(
            WordStrings.surveyFormCreatelLbl,
            fontFamily: FontFamilyConstant.sinkinSans,
            fontSize: 18,
            fontColor: yasRed,
          ),
        ),
        body: ImagePainterExample(),

        );
  }
}

class ImagePainterExample extends StatefulWidget {
  @override
  _ImagePainterExampleState createState() => _ImagePainterExampleState();
}

class _ImagePainterExampleState extends State<ImagePainterExample> {
  final _imageKey = GlobalKey<ImagePainterState>();

  @override
  Widget build(BuildContext context) {
    return ImagePainter.asset(
          "assets/images/canvas_background.jpg",
          key: _imageKey,
          height: 1000,
          scalable: false,
          initialStrokeWidth: 2,
          textDelegate: TextDelegate(),
          initialColor: Colors.black,
          initialPaintMode: PaintMode.line,
        );
  }

  void saveImage() async {
    final image = await _imageKey.currentState?.exportImage();
    final directory = (await getApplicationDocumentsDirectory()).path;
    await Directory('$directory/sample').create(recursive: true);
    final fullPath =
        '$directory/sample/${DateTime.now().millisecondsSinceEpoch}.png';
    final imgFile = File('$fullPath');
    if (image != null) {
      imgFile.writeAsBytesSync(image);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.grey[700],
          padding: const EdgeInsets.only(left: 10),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Image Exported successfully.",
                  style: TextStyle(color: Colors.white)),
              TextButton(
                onPressed: () => OpenFile.open("$fullPath"),
                child: Text(
                  "Open",
                  style: TextStyle(
                    color: Colors.blue[200],
                  ),
                ),
              )
            ],
          ),
        ),
      );
    }
  }
}