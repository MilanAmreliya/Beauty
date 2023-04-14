import 'package:beuty_app/comman/custom_appbar.dart';
import 'package:beuty_app/comman/svg.dart';
import 'package:beuty_app/res/color_picker.dart';
import 'package:beuty_app/view/profileTab/shop_screen/widget/edit_service_form.dart';
import 'package:beuty_app/viewModel/bottom_bar_viewmodel.dart';
import 'package:beuty_app/viewModel/get_category_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditServiceScreen extends StatefulWidget {
  final String name;

  const EditServiceScreen({Key key, this.name}) : super(key: key);
  @override
  _EditServiceScreenState createState() => _EditServiceScreenState();
}

class _EditServiceScreenState extends State<EditServiceScreen> {
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
          'Edit Service',
          leadingOnTap: () {
            _barController.setSelectedRoute('ArtistProfileServices');
          },
          action: svgChat(),
        ),
        body: SingleChildScrollView(
          child: Form(
              key: formKey,
              child: EditServiceForm(
                formKey: formKey,
              )),
        ),
      ),
    );
  }
}
