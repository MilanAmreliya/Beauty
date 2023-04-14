import 'package:beuty_app/model/apis/api_response.dart';
import 'package:beuty_app/viewModel/artist_home_tab_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'loading_indicator.dart';

GetBuilder<HomeTabViewModel> homeTabProcessIndicator() {
  return GetBuilder<HomeTabViewModel>(
    builder: (controller) {
      if (controller.apiResponse.status == Status.LOADING) {
        return loadingIndicator();
      } else {
        return SizedBox();
      }
    },
  );
}
