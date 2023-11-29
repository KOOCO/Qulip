import 'package:json_annotation/json_annotation.dart';
part 'login_model.g.dart';

@JsonSerializable()
class LoginModel {
  factory LoginModel.fromJson(Map<String, dynamic> json) =>
      _$LoginModelFromJson(json);
  LoginModel();

  String? otp;
  String? mobile;
  User? user;
  Map<String, dynamic> toJson() => _$LoginModelToJson(this);
}

class User {
  User.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    profilePic = json['profile_pic'];
    mobile = json['mobile'];
    countryId = json['country_id'];
    stateId = json['state_id'];
    cityId = json['city_id'];
    subCity = json['sub_city'];
    address = json['address'];
    zipcode = json['zipcode'];
    gender = json['gender'];
    dob = json['dob'];
  }

  User({
    this.userId,
    this.firstName,
    this.lastName,
    this.email,
    this.profilePic,
    this.mobile,
    this.countryId,
    this.stateId,
    this.cityId,
    this.subCity,
    this.address,
    this.zipcode,
    this.gender,
    this.dob,
  });
  int? userId;
  String? firstName;
  String? lastName;
  String? email;
  String? profilePic;
  String? mobile;
  int? countryId;
  int? stateId;
  int? cityId;
  String? subCity;
  String? address;
  String? zipcode;
  String? gender;
  String? dob;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['profile_pic'] = profilePic;
    data['mobile'] = mobile;
    data['country_id'] = countryId;
    data['state_id'] = stateId;
    data['city_id'] = cityId;
    data['sub_city'] = subCity;
    data['address'] = address;
    data['zipcode'] = zipcode;
    data['gender'] = gender;
    data['dob'] = dob;
    return data;
  }
}
