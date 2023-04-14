class SelectedServiceModel {
  String image;
  String description;
  dynamic price;
  DateTime startTime;
  DateTime endTime;
  String artistId;
  String id;

  SelectedServiceModel._internal();

  static final SelectedServiceModel selectedServiceModel =
      SelectedServiceModel._internal();

  factory SelectedServiceModel() {
    return selectedServiceModel;
  }
}
