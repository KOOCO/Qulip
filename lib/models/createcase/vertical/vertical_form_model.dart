import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class VerticalFormModel {
  VerticalFormModel({
    required this.upperPoint,
    required this.lowerPoint,
    required this.highDifference,
    required this.titlDirection,
    required this.leftPoint,
    required this.rightPoint,
    required this.tiltValue,
    required this.slope,
    required this.description,
    required this.filePath,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['upperPoint'] = upperPoint;
    data['lowerPoint'] = lowerPoint;
    data['highDifference'] = highDifference;
    data['titlDirection'] = titlDirection;
    data['leftPoint'] = leftPoint;
    data['rightPoint'] = rightPoint;
    data['tiltValue'] = tiltValue;
    data['slope'] = slope;
    data['description'] = description;
    data['filePath'] = filePath;
    return data;
  }

  String? upperPoint;
  String? lowerPoint;
  int? highDifference;
  String? titlDirection;
  String? leftPoint;
  String? rightPoint;
  int? tiltValue;
  double? slope;
  String? description;
  List<String>? filePath;
}
