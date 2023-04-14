import 'package:beuty_app/comman/custom_appbar.dart';
import 'package:beuty_app/comman/svg.dart';
import 'package:beuty_app/res/color_picker.dart';
import 'package:beuty_app/viewModel/artist_profile_viewmodel.dart';
import 'package:beuty_app/viewModel/bottom_bar_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'widget/create_shop_form.dart';

class CreateShopScreen extends StatefulWidget {
  final bool firstTimeCreate;

  const CreateShopScreen({Key key, this.firstTimeCreate = false})
      : super(key: key);

  @override
  _CreateShopScreenState createState() => _CreateShopScreenState();
}

class _CreateShopScreenState extends State<CreateShopScreen> {
  GlobalKey<FormState> formKey;
  BottomBarViewModel _barController = Get.find();
  ArtistProfileViewModel _profileViewModel = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    formKey = GlobalKey<FormState>();
    _profileViewModel.getPlace();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (!widget.firstTimeCreate) {
          _barController.setSelectedRoute('ArtistProfileServices');
        }

        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: cThemColor,
        appBar: customAppBar(
          'Create shop',
          leadingOnTap: !widget.firstTimeCreate
              ? () {
                  _barController.setSelectedRoute('ArtistProfileServices');
                }
              : null,
          action: !widget.firstTimeCreate ? svgChat() : SizedBox(),
        ),
        body: SingleChildScrollView(
          child: CreateShopForm(
            firstTimeCreate: widget.firstTimeCreate,
          ),
        ),
      ),
    );
  }
}
