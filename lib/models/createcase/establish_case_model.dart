import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class EstablishCaseModel {
  EstablishCaseModel(
      {required this.id,
      required this.createdAt,
      required this.userId,
      required this.caseName,
      required this.caseAddress,
      required this.caseDate,
      required this.caseEquipmentNo,
      required this.caseWeather,
      required this.wsStructureType,
      required this.wsUseFor,
      required this.wsWallType,
      required this.wsFlatTopMaterial,
      required this.wsFloorMaterial,
      required this.wsTechDescription});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['createdAt'] = createdAt;
    data['caseName'] = caseName;
    data['caseAddress'] = caseAddress;
    data['caseCreatedDate'] = caseDate;
    data['caseEquipmentNo'] = caseEquipmentNo;
    data['caseWeather'] = caseWeather;
    data['structure'] = wsStructureType;
    data['use'] = wsUseFor;
    data['wall'] = wsWallType;
    data['flatTopMaterial'] = wsFlatTopMaterial;
    data['floorMaterial'] = wsFloorMaterial;
    data['techDescription'] = wsTechDescription;
    return data;
  }

  String? id;
  String? createdAt;
  String? userId;
  String? caseName;
  String? caseAddress;
  String? caseDate;
  String? caseEquipmentNo;
  String? caseWeather;
  String? wsStructureType;
  String? wsUseFor;
  String? wsWallType;
  String? wsFlatTopMaterial;
  String? wsFloorMaterial;
  String? wsTechDescription;
}
