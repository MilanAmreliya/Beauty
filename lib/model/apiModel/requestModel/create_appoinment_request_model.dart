

class CreateAppointmentReq {
  String artistId;
  String modelId;
  String serviceId;
  String ammount;
  String paymentType;
  String startTime;

  CreateAppointmentReq(
      {this.ammount,
      this.modelId,
      this.serviceId,
      this.artistId,
      this.paymentType,
      this.startTime});

  Future<Map<String, String>> toJson() async {
    return {
      'artist_id': artistId,
      'model_id': modelId,
      'service_id': serviceId,
      'ammount': ammount,
      'payment_type': paymentType,
      'start_time': startTime,
    };
  }
}
