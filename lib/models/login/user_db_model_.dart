import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class UserDBModel {
  UserDBModel(
      {required this.username,
      required this.password,
      required this.points,
      this.userId});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userName'] = username;
    data['password'] = password;
    data['points'] = points;
    data['userId'] = userId;
    return data;
  }

  String? userId;
  String? username;
  String? password;
  int? points;
}
