import 'package:beuty_app/comman/custom_appbar.dart';
import 'package:beuty_app/comman/svg.dart';
import 'package:beuty_app/res/color_picker.dart';
import 'package:beuty_app/viewModel/bottom_bar_viewmodel.dart';
import 'package:beuty_app/viewModel/get_category_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'widget/add_service_form.dart';

class AddServicesScreen extends StatefulWidget {
  const AddServicesScreen({Key key}) : super(key: key);

  @override
  _AddServicesScreenState createState() => _AddServicesScreenState();
}

class _AddServicesScreenState extends State<AddServicesScreen> {
  GlobalKey<FormState> formKey;
  BottomBarViewModel _barController = Get.find();
  GetCategoryViewModel getCategoryViewModel = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    getCategoryViewModel.getCategory();

    formKey = GlobalKey<FormState>();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _barController.setSelectedRoute('ArtistProfileServices');
        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: cThemColor,
        appBar: customAppBar(
          'Add Service',
          leadingOnTap: () {
            _barController.setSelectedRoute('ArtistProfileServices');
          },
          action: svgChat(),
        ),
        body: SingleChildScrollView(
          child: Form(
              key: formKey,
              child: AddServiceForm(
                formKey: formKey,
              )),
        ),
      ),
    );
  }
}
