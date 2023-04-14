import 'package:beuty_app/model/apiModel/responseModel/check_shop_available_response_model.dart';
import 'package:beuty_app/model/apis/api_response.dart';
import 'package:beuty_app/sharedPreference/shared_preference.dart';
import 'package:beuty_app/view/bottomBar/bottom_bar.dart';
import 'package:beuty_app/view/profileTab/shop_screen/create_shop_screen.dart';
import 'package:beuty_app/viewModel/artist_profile_viewmodel.dart';
import 'package:beuty_app/viewModel/bottom_bar_viewmodel.dart';
import 'package:beuty_app/viewModel/validation_viewmodel.dart';
import 'package:get/get.dart';

import 'comman_widget.dart';

Future<void> checkShopExist() async {
  ValidationViewModel controller = Get.find();
  ArtistProfileViewModel profileViewModel = Get.find();
  BottomBarViewModel _barController = Get.find();

  final role = PreferenceManager.getCustomerRole();
  await profileViewModel.checkShopAvailable();
  if (profileViewModel.checkShopAvailableApiResponse.status == Status.ERROR) {
    CommanWidget.snackBar(message: 'Server Error');
    return;
  }
  if (profileViewModel.checkShopAvailableApiResponse.status ==
      Status.COMPLETE) {
    CheckShopAvailableResponse shopAvailableResponse =
        profileViewModel.checkShopAvailableApiResponse.data;
    if (shopAvailableResponse.data.id != null) {
      await PreferenceManager.setShopId(shopAvailableResponse.data.id);
      controller.updateRole(role);
      _barController.setSelectedIndex(0);
      _barController.setSelectedRoute('HomeScreen');
      Get.offAll(BottomBar());
    } else {
      Get.offAll(CreateShopScreen(
        firstTimeCreate: true,
      ));
    }
  }
}
