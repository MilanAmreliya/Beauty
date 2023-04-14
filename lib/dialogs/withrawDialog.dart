import 'package:beuty_app/comman/comman_widget.dart';
import 'package:beuty_app/comman/loading_indicator.dart';
import 'package:beuty_app/model/apiModel/requestModel/withdraw_request_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/withdraw_response_model.dart';
import 'package:beuty_app/model/apis/api_response.dart';
import 'package:beuty_app/res/utility.dart';
import 'package:beuty_app/sharedPreference/shared_preference.dart';
import 'package:beuty_app/viewModel/artist_profile_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

TextEditingController amountController = TextEditingController();
TextEditingController bankNameController = TextEditingController();
TextEditingController bsbNumberController = TextEditingController();
TextEditingController bankAccountNumber = TextEditingController();
ArtistProfileViewModel artistProfileViewModel = Get.find();
Future<void> withdrawDialog() {
  return Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0)), //this right here
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: Get.height * 0.01),
              child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: Get.width * 0.01),
                        child: Row(
                          children: [
                            Spacer(),
                            InkWell(
                              onTap: () {
                                Get.back();
                              },
                              child: Container(
                                // height: Get.height * 0.05,
                                // width: Get.width * 0.05,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: Colors.black, width: 1)),
                                child: Center(
                                  child: Icon(
                                    Icons.clear,
                                    size: Get.height * 0.03,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        'Withdraw',
                        style: TextStyle(
                            fontSize: Get.height * 0.025,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w600),
                      ),
                      /*  Text(
                        'Money',
                        style: TextStyle(
                            fontSize: Get.height * 0.02,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w400),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: Get.width * 0.06),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Balance',
                                  style: TextStyle(
                                      fontSize: Get.height * 0.014,
                                      fontFamily: "Manrope",
                                      fontWeight: FontWeight.w700),
                                ),
                                Spacer(),
                                Text(
                                  '\$6400 - \$500',
                                  style: TextStyle(
                                      fontSize: Get.height * 0.014,
                                      fontFamily: "Manrope",
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: Get.height * 0.01,
                            ),
                            Row(
                              children: [
                                Text(
                                  'Remaining',
                                  style: TextStyle(
                                      fontSize: Get.height * 0.014,
                                      fontFamily: "Manrope",
                                      fontWeight: FontWeight.w700),
                                ),
                                Spacer(),
                                Text(
                                  '\$5900',
                                  style: TextStyle(
                                      fontSize: Get.height * 0.014,
                                      fontFamily: "Manrope",
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),*/
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: CommanWidget.getTextFormField(
                            labelText: "Enter Amount",

                            textInputType: TextInputType.number,
                            textEditingController: amountController,
                            regularExpression: Utility.digitsValidationPattern,
                            validationMessage: Utility.amountValidValidation,
                            hintText: "Enter Amount Number",
                            icon: Icons.edit),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: CommanWidget.getTextFormField(
                          labelText: "Bank Name",
                          textEditingController: bankNameController,
                          hintText: "Enter Bank name",
                          inputLength: 30,
                          regularExpression: Utility.userNamevalidationPattern,
                          validationMessage: Utility.kEnterBankName,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: CommanWidget.getTextFormField(
                          labelText: "Bsb Number",
                          textEditingController: bsbNumberController,
                          hintText: "Enter Bsb Number",
                          inputLength: 30,
                          regularExpression:
                              Utility.alphabetDigitsValidationPattern,
                          validationMessage: Utility.kEnterBsbNumber,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: CommanWidget.getTextFormField(
                          labelText: "Account Number",
                          textEditingController: bankAccountNumber,
                          hintText: "Enter Account Number",
                          inputLength: 30,
                          regularExpression:
                              Utility.alphabetDigitsValidationPattern,
                          validationMessage: Utility.kEnterBankAccountNumber,
                        ),
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: Get.width * 0.2),
                          child: CommanWidget.activeButton(
                            onTap: () {
                              onWithdrawTap();
                            },
                            title: 'Withdraw',
                          )),
                    ]),
              ),
            ),
            GetBuilder<ArtistProfileViewModel>(
              builder: (controller) {
                if (controller.createWithdrawApiResponse.status ==
                    Status.LOADING) {
                  return Center(child: loadingIndicator());
                } else {
                  return SizedBox();
                }
              },
            )
          ],
        ),
      ),
      barrierDismissible: false);
}

Future<void> onWithdrawTap() async {


  if (amountController.text == null || amountController.text.isEmpty) {
    CommanWidget.snackBar(
      message: "Please enter amount",
    );
    return;
  }
  if (bankAccountNumber.text == null || bankAccountNumber.text.isEmpty) {
    CommanWidget.snackBar(
      message: "Please enter bank account number",
    );
    return;
  }
  if (bankNameController.text == null || bankNameController.text.isEmpty) {
    CommanWidget.snackBar(
      message: "Please enter bank name",
    );
    return;
  }
  if (bsbNumberController.text == null || bsbNumberController.text.isEmpty) {
    CommanWidget.snackBar(
      message: "Please enter BSB number",
    );
    return;
  }  if (amountController.text.lastIndexOf('.')>0) {
    CommanWidget.snackBar(
      message: "Please enter only single dot",
    );
    return;
  }
  WithdrawReqModel withdrawReqModel = WithdrawReqModel();
  withdrawReqModel.shopId = PreferenceManager.getShopId().toString();
  withdrawReqModel.ammount = amountController.text;
  withdrawReqModel.accountName = bankNameController.text;
  withdrawReqModel.bsbNumber = bsbNumberController.text;
  withdrawReqModel.accountNumber = bankAccountNumber.text;
  await artistProfileViewModel.withdraw(withdrawReqModel);
  if (artistProfileViewModel.createWithdrawApiResponse.status ==
      Status.COMPLETE) {
    WithdrawMoneyResponse response =
        artistProfileViewModel.createWithdrawApiResponse.data;
    if (response.success) {
      CommanWidget.snackBar(
        message: response.message,
      );
      Future.delayed(Duration(seconds: 3), () {
        Get.back();
        amountController.clear();
        bankNameController.clear();
        bsbNumberController.clear();
        bankAccountNumber.clear();
        artistProfileViewModel
            .getWithdraws(PreferenceManager.getShopId().toString());
      });
    } else {
      CommanWidget.snackBar(
        message: "Something want wrong",
      );
    }
  } else {
    CommanWidget.snackBar(
      message: "Something want wrong",
    );
  }
}
