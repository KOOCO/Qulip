import 'package:get/get.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class HorizontalDataModel {
  HorizontalDataModel(
      {this.id,
      required this.mesuringPoint,
      required this.backView,
      required this.forwardView,
      required this.hypothesis,
      required this.levelElevation,
      this.imageUri});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mPoint'] = mesuringPoint;
    data['backView'] = backView;
    data['forwardView'] = forwardView;
    data['hypothesis'] = hypothesis;
    data['levelElevation'] = levelElevation;
    data['imageUri'] = imageUri;
    return data;
  }

  String? id;
  String? mesuringPoint;
  String? backView;
  String? forwardView;
  String? hypothesis = "";
  String? imageUri = "";
  int levelElevation = 0;
  String? caseWeather;
}
