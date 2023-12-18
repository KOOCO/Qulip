import 'package:json_annotation/json_annotation.dart';
part 'login_model.g.dart';

@JsonSerializable()
class LoginModel {
  factory LoginModel.fromJson(Map<String, dynamic> json) =>
      _$LoginModelFromJson(json);
  LoginModel();

  String? message;
  String? link;
  int? points;
  Map<String, dynamic> toJson() => _$LoginModelToJson(this);
}
