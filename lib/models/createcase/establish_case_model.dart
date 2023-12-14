import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class EstablishCaseModel {
  EstablishCaseModel({
    required this.id,
    required this.userId,
    required this.caseName,
    required this.caseAddress,
    required this.caseDate,
    required this.caseEquipmentNo,
    required this.caseWeather,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['UserId'] = userId;
    data['CaseName'] = caseName;
    data['CaseAddress'] = caseAddress;
    data['CaseCreatedDate'] = caseDate;
    data['CaseEquipmentNo'] = caseEquipmentNo;
    data['CaseWeather'] = caseWeather;
    return data;
  }

  String? id;
  String? userId;
  String? caseName;
  String? caseAddress;
  String? caseDate;
  String? caseEquipmentNo;
  String? caseWeather;
}
