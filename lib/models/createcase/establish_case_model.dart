import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:qulip/models/createcase/horizontal/horizontal_form_model.dart';
import 'package:qulip/models/createcase/vertical/vertical_form_model.dart';
import 'package:qulip/models/createcase/weential/weential_data_model.dart';

@JsonSerializable()
class EstablishCaseModel {
  EstablishCaseModel({
    required this.id,
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
    required this.wsWeentileDataList,
    required this.verticalMSDataList,
    required this.horizontalMSDataList,
  });

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
    for (var i in json['weentialList']) {
      wsWeentileDataList.add(WeentialDataModel.fromJson(i));
    }
    for (var i in json['verticalMsList']) {
      verticalMSDataList.add(VerticalFormModel.fromJson(i));
    }
    for (var i in json['horizontalMSDataList']) {
      horizontalMSDataList.add(HorizontalDataModel.fromJson(i));
    }
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
    data['verticalMsList'] = verticalMSDataList;
    data['horizontalMSDataList'] = horizontalMSDataList;
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
  List<WeentialDataModel> wsWeentileDataList = [];
  List<VerticalFormModel> verticalMSDataList = [];
  List<HorizontalDataModel> horizontalMSDataList = [];
}
