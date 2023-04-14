import 'package:get/get.dart';

class BookAppointmentViewModel extends GetxController {
  int indexCurrent;
  onChange({value}) {
    indexCurrent = value;
    update();
  }
}
