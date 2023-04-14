class LoginRequestModel {
  String email;
  String password;
  String deviceToken;

  LoginRequestModel({this.email, this.password, this.deviceToken});

  Map<String, dynamic> toJson() {
    return {'email': email, 'password': password, 'device_token': deviceToken};
  }
}
