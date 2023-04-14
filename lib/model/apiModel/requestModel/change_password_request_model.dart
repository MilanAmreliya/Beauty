class ChangePasswordReqModel {
  String oldPassword;
  String newPassword;

  ChangePasswordReqModel({this.newPassword, this.oldPassword});

  Map<String, dynamic> toJson() {
    return {
      'password': newPassword,
      'old_password': oldPassword,
    };
  }
}
