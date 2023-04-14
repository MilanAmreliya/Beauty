class FilterPostRequestModel {
  String area;
  int km;
  String serviceCategory;

  FilterPostRequestModel({this.area, this.km, this.serviceCategory});

  Map<String, dynamic> toJson() {
    return {'area': area, 'km': km, 'service_category': serviceCategory};
  }
}
