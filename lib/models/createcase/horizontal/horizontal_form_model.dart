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

  HorizontalDataModel.fromJson(Map<String, dynamic> json) {
    mesuringPoint = json['mPoint'];
    backView = json['backView'];
    forwardView = json['forwardView'];
    hypothesis = json['hypothesis'];
    final elev = json['levelElevation'];
    levelElevation = double.parse(elev.toString());
    imageUri = json['imageUri'];
  }

  String? id;
  String? mesuringPoint;
  String? backView;
  String? forwardView;
  String? hypothesis = "";
  String? imageUri = "";
  double levelElevation = 0;
  String? caseWeather;

  String getIndex(int index) {
    switch (index) {
      case 0:
        return mesuringPoint!;
      case 1:
        return backView.toString();
      case 2:
        return forwardView.toString();
      case 3:
        return hypothesis.toString();
    }
    return '';
  }
  
}
