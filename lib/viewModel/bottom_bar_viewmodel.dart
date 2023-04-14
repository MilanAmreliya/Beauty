import 'package:get/get.dart';

class BottomBarViewModel extends GetxController {
  int currentPage = 0;
  onChang(int index) {
    currentPage = index;
    update();
  }

  RxInt _selectedArtistId = 0.obs;

  RxInt get selectedArtistId => _selectedArtistId;

  void setSelectedArtistId(int value) {
    _selectedArtistId = value.obs;
    update();
  }

  /*void clearSelectedArtistId() {

    update();
  }*/

  RxString _selectedRoute = 'HomeScreen'.obs;

  RxString get selectedRoute => _selectedRoute;

  void setSelectedRoute(String value) {
    _selectedRoute = value.obs;
    print('route:$_selectedRoute');
    update();
  }

  RxString _newStoryPreviousRoute = 'HomeScreen'.obs;

  RxString get newStoryPreviousRoute => _newStoryPreviousRoute;

  void setNewStoryPreviousRoute(String value) {
    _newStoryPreviousRoute = value.obs;
    update();
  }

  RxString _balancePreviousRoute = 'ArtistUserProfileScreen'.obs;

  RxString get balancePreviousRoute => _balancePreviousRoute;

  void setBalancePreviousRoute(String value) {
    _balancePreviousRoute = value.obs;
    update();
  }

  RxInt _selectedIndex = 0.obs;

  RxInt get selectedIndex => _selectedIndex;

  void setSelectedIndex(int value) {
    _selectedIndex = value.obs;
    update();
  }
}
