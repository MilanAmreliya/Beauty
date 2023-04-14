import 'dart:developer';

import 'package:beuty_app/sharedPreference/shared_preference.dart';
import 'package:beuty_app/res/color_picker.dart';
import 'package:beuty_app/services/stripe_payment_service.dart';
import 'package:beuty_app/view/payment/existing-cards.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progress_dialog/progress_dialog.dart';

class PaymentScreen extends StatefulWidget {
  final String amount;

  PaymentScreen({Key key, this.amount}) : super(key: key);

  @override
  PaymentScreenState createState() => PaymentScreenState();
}

class PaymentScreenState extends State<PaymentScreen> {
  payViaNewCard(BuildContext context) async {
    ProgressDialog dialog = new ProgressDialog(context);
    dialog.style(message: 'Please wait...');
    await dialog.show();
    var response = await StripeService.payWithNewCard(
        amount: widget.amount * 100, currency: 'USD');
    log('Stripe response :${response.message}');
    await dialog.hide();
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(response.message),
      duration:
          new Duration(milliseconds: response.success == true ? 1200 : 3000),
    ));
  }

  @override
  void initState() {
    super.initState();
    StripeService.init();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Home'),
      // ),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: InkResponse(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back_ios_outlined,
            color: cRoyalBlue,
            size: Get.height * 0.027,
          ),
        ),
        title: Text(
          "Payment",
          style: TextStyle(color: cRoyalBlue, fontSize: Get.height * 0.025),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: InkWell(
          onTap: () {
            payViaNewCard(context);
          },
          child: ListTile(
              title: Text('Pay via new card'),
              leading: Icon(Icons.add_circle, color: cRoyalBlue)),
        ),
      ),
    );
    ;
  }
}
