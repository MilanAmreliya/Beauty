

class UpdateProfileReqModel {
  String name;
  String username;
  String bio;

  UpdateProfileReqModel({
    this.name,
    this.username,
    this.bio,
  });

  Future<Map<String, dynamic>> toJson() async {
    return {
      'name': name,
      'username': username,
      'bio': bio,
    };
  }
}
