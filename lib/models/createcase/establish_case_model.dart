import 'package:json_annotation/json_annotation.dart';
import 'package:qulip/models/createcase/weential_data_model.dart';

@JsonSerializable()
class EstablishCaseModel {
  EstablishCaseModel(
      {required this.id,
      required this.createdAt,
      required this.userId,
      required this.caseName,
      required this.caseLable,
      required this.caseAddress,
      required this.caseDate,
      required this.caseEquipmentNo,
      required this.caseWeather,
      required this.wsStructureType,
      required this.wsUseFor,
      required this.wsWallType,
      required this.wsFlatTopMaterial,
      required this.wsFloorMaterial,
      required this.wsTechDescription,
      required this.wsWeentileDataList});

  EstablishCaseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    createdAt = json['createdAt'];
    caseName = json['caseName'];
    caseLable = json['caseLabel'];
    caseAddress = json['caseAddress'];
    caseDate = json['caseDate'];
    caseEquipmentNo = json['caseEquipmentNo'];
    caseWeather = json['caseWeather'];
    wsStructureType = json['structure'];
    wsUseFor = json['use'];
    wsWallType = json['wall'];
    wsFlatTopMaterial = json['flatTopMaterial'];
    wsFloorMaterial = json['floorMaterial'];
    wsTechDescription = json['techDescription'];
    // wsWeentileDataList = json['weentialList'] as List<WeentialDataModel>;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['createdAt'] = createdAt;
    data['caseName'] = caseName;
    data['caseLabel'] = caseLable;
    data['caseAddress'] = caseAddress;
    data['caseDate'] = caseDate;
    data['caseEquipmentNo'] = caseEquipmentNo;
    data['caseWeather'] = caseWeather;
    data['structure'] = wsStructureType;
    data['use'] = wsUseFor;
    data['wall'] = wsWallType;
    data['flatTopMaterial'] = wsFlatTopMaterial;
    data['floorMaterial'] = wsFloorMaterial;
    data['techDescription'] = wsTechDescription;
    data['weentialList'] = wsWeentileDataList;
    return data;
  }

  String? id;
  String? createdAt;
  String? userId;
  String? caseName;
  String? caseLable;
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
  List<WeentialDataModel>? wsWeentileDataList;
}
