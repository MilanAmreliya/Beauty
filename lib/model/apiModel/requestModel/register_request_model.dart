class RegisterRequestModel {
  String userName;
  String name;
  String email;
  String password;
  String confirmPassword;
  String customerRole;
  String type;
  String deviceToken;

  static final RegisterRequestModel requestModel =
      RegisterRequestModel._internal();

  RegisterRequestModel._internal();

  factory RegisterRequestModel() {
    return requestModel;
  }

  Map<String, dynamic> toJson() {
    return {
      'username': userName,
      'name': name,
      'email': email,
      'password': password,
      'password_confirmation': null,
      'customer_role': customerRole,
      'type': type,
      'device_token': deviceToken
      //'profile_pic': profilePic,
      // 'phone_number': pNumber,
    };
  }
}
