

class AddRateReqModel {
  String artistId;
  String serviceId;
  String reviwerId;
  String rating;

  AddRateReqModel({
    this.rating,
    this.artistId,
    this.serviceId,
    this.reviwerId,
  });

  Future<Map<String, dynamic>> toJson() async {
    return {
      'artist_id': artistId,
      'service_id': serviceId,
      'reviewer_id': reviwerId,
      'rating': rating
    };
  }
}
