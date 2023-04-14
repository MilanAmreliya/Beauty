class CheckUserExistRequestModel {
  String email;

  CheckUserExistRequestModel({this.email});

  Map<String, dynamic> toJson() {
    return {
      'email': email,
    };
  }
}
