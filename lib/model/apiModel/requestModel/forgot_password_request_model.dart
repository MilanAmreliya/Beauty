class ForgotPasswordReqModel {
  String email;

  ForgotPasswordReqModel({
    this.email,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
    };
  }
}
