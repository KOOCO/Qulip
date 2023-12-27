import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class WeentialSurveyData2Model {
  WeentialSurveyData2Model(
      {this.id,
      required this.wsLocation,
      required this.wsSituation,
      required this.wsCrackedLength,
      required this.wsCrackedWidth,
      required this.wsFlaw,
      required this.wsTechDescr,
      required this.wsImages});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Location'] = wsLocation;
    data['Situation'] = wsSituation;
    data['CrackedLength'] = wsCrackedLength;
    data['CrackedWidth'] = wsCrackedWidth;
    data['Flaw'] = wsFlaw;
    data['Description'] = wsTechDescr;
    data['Images'] = wsImages;

    return data;
  }

  String? id;
  String? wsLocation;
  String? wsSituation;
  String? wsCrackedLength;
  String? wsCrackedWidth;
  String? wsFlaw;
  String? wsTechDescr;
  List<String>? wsImages;
}
