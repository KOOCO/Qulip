import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class UserDBModel {
  UserDBModel({
    required this.username,
    required this.password,
    required this.points,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['UserName'] = username;
    data['Password'] = password;
    data['Points'] = points;
    return data;
  }

  String? username;
  String? password;
  int? points;
}
