import 'package:beuty_app/res/const.dart';
import 'package:beuty_app/sharedPreference/shared_preference.dart';
import 'package:beuty_app/viewModel/bottom_bar_viewmodel.dart';
import 'package:beuty_app/viewModel/new_story_viewmodel.dart';
import 'package:beuty_app/viewModel/validation_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

Container bottomNavigationBar(ValidationViewModel viewModel) {
  return Container(
    height: 70,
    width: Get.width,
    color: Colors.white,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: kBottomBarLIst
          .map((e) => InkWell(
                onTap: () {
                  // onTap(listModel.indexOf(e), 'Artist');
                  onTap(kBottomBarLIst.indexOf(e), viewModel.selectRole.value);
                },
                child: GetBuilder<BottomBarViewModel>(
                  builder: (controller) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          e['icon'],
                          color: controller.selectedIndex.value ==
                                  kBottomBarLIst.indexOf(e)
                              ? Color(0xff424BE1)
                              : Color(0xffB9BAC7),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          '${e['title']}',
                          style: TextStyle(
                            color: controller.selectedIndex.value ==
                                    kBottomBarLIst.indexOf(e)
                                ? Color(0xff424BE1)
                                : Color(0xffB9BAC7),
                          ),
                        )
                      ],
                    );
                  },
                ),
              ))
          .toList(),
    ),
  );
}

void onTap(int index, String role) {
  BottomBarViewModel _barController = Get.find();
  _barController.setSelectedIndex(index);
  print('role:$role index :$index');
  role = role ?? PreferenceManager.getCustomerRole();
  if (index == 0) {
    _barController.setSelectedRoute('HomeScreen');
  } else if (index == 1) {
    _barController.setSelectedRoute('ExploreScreen');
  } else if (index == 2 && role == 'Artist') {
    _barController.setSelectedRoute('AppointmentScreen');
  } else if (index == 2 && role == 'Model') {
    _barController.setSelectedRoute('ModalAppointmentScreen');
  } else if (index == 3 && role == 'Artist') {
    _barController.setSelectedRoute('ArtistUserProfileScreen');
  } else if (index == 3 && role == 'Model') {
    _barController.setSelectedRoute('ModalProfileScreen');
  }
}
