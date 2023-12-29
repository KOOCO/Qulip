import 'package:get/get.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class WeentialDataModel {
  WeentialDataModel(
      {this.id,
      required this.wsLocation,
      required this.wsSituation,
      required this.wsCrackedLength,
      required this.wsCrackedWidth,
      required this.wsFlaw,
      required this.wsTechDescr,
      required this.wsImagesList});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['location'] = wsLocation;
    data['situation'] = wsSituation;
    data['crackedLength'] = wsCrackedLength;
    data['crackedWidth'] = wsCrackedWidth;
    data['flaw'] = wsFlaw;
    data['description'] = wsTechDescr;
    data['imagesList'] = wsImagesList;

    return data;
  }

  String? id;
  String? wsLocation;
  String? wsSituation;
  String? wsCrackedLength;
  String? wsCrackedWidth;
  String? wsFlaw;
  String? wsTechDescr;
  List<String>? wsImagesList = <String>[].obs;
}
