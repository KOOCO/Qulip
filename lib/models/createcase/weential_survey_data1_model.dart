import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class WeentialSurveyData1Model {
  WeentialSurveyData1Model(
      {this.id,
      required this.wsStructureType,
      required this.wsUseFor,
      required this.wsWallType,
      required this.wsFlatTopMaterial,
      required this.wsFloorMaterial,
      required this.wsTechDescription});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Structure'] = wsStructureType;
    data['Use'] = wsUseFor;
    data['Wall'] = wsWallType;
    data['FlatTopMaterial'] = wsFlatTopMaterial;
    data['FloorMaterial'] = wsFloorMaterial;
    data['TechDescription'] = wsTechDescription;

    return data;
  }

  String? id;
  String? wsStructureType;
  String? wsUseFor;
  String? wsWallType;
  String? wsFlatTopMaterial;
  String? wsFloorMaterial;
  String? wsTechDescription;
}
