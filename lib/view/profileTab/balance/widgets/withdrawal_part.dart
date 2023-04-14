import 'package:beuty_app/comman/common_octo_image.dart';
import 'package:beuty_app/comman/loading_indicator.dart';
import 'package:beuty_app/model/apiModel/responseModel/get_withdraws_response_model.dart';
import 'package:beuty_app/model/apis/api_response.dart';
import 'package:beuty_app/viewModel/artist_profile_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

SingleChildScrollView withdrawalPage(BuildContext context) {
  return SingleChildScrollView(
    child: GetBuilder<ArtistProfileViewModel>(
      builder: (controller) {
        if (controller.getWithdrawsApiResponse.status == Status.LOADING) {
          return Center(child: circularIndicator());
        }
        if (controller.getWithdrawsApiResponse.status == Status.ERROR) {
          return Center(child: Text('Server Error'));
        }
        GetWithdrawResponse response = controller.getWithdrawsApiResponse.data;
        if (response.data.withdraws.isEmpty) {
          return Center(
              child: Padding(
            padding: EdgeInsets.only(top: Get.height * 0.2),
            child: Text("No Withdraws Data"),
          ));
        }
        return Column(
          children: List.generate(
            response.data.withdraws.length,
            (index) => Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.height * 0.023),
              child: Column(
                children: [
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  GestureDetector(
                    onTap: () {
                      response.data.withdraws[index].status == 'approved'
                          ? showModalBottomSheet(
                              shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.only(
                                      topLeft: const Radius.circular(20.0),
                                      topRight: const Radius.circular(20.0))),
                              context: context,
                              builder: (builder) {
                                return new Container(
                                  height: Get.height * 0.53,
                                  color: Colors.transparent,
                                  child: new Container(
                                      decoration: new BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: new BorderRadius.only(
                                              topLeft:
                                                  const Radius.circular(20.0),
                                              topRight:
                                                  const Radius.circular(20.0))),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 20,
                                            bottom: 20,
                                            left: 20,
                                            right: 20),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            response.data.withdraws[index]
                                                            .image ==
                                                        null ||
                                                    response
                                                            .data
                                                            .withdraws[index]
                                                            .image ==
                                                        ''
                                                ? imageNotLoadRectangle()
                                                : ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    child: Container(
                                                      color: Colors.grey
                                                          .withOpacity(0.3),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                        child: commonOctoImage(
                                                          image: response
                                                              .data
                                                              .withdraws[index]
                                                              .image,
                                                          width: Get.width,
                                                          height: Get.height *
                                                              0.225,
                                                          circleShape: false,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            richText(
                                                hint: "amount : ",
                                                value:
                                                    "\$${response.data.withdraws[index].ammount}"),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text.rich(TextSpan(children: [
                                              TextSpan(
                                                  text: "Status : ",
                                                  style:
                                                      TextStyle(fontSize: 18)),
                                              TextSpan(
                                                  text: response
                                                          .data
                                                          .withdraws[index]
                                                          .status ??
                                                      'N/A',
                                                  style: TextStyle(
                                                      color: response
                                                                  .data
                                                                  .withdraws[
                                                                      index]
                                                                  .status ==
                                                              "approved"
                                                          ? Colors.green
                                                          : Colors.red,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w600))
                                            ])),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            richText(
                                                hint: "Transaction Id : ",
                                                value: response
                                                    .data
                                                    .withdraws[index]
                                                    .transactionId),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            richText(
                                                hint: "Comment : ",
                                                value: response.data
                                                    .withdraws[index].comment),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            richText(
                                                hint: "Admin contact Mail : ",
                                                value: response
                                                    .data
                                                    .withdraws[index]
                                                    .adminContactMail),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            richText(
                                                hint: "Bank Name : ",
                                                value: response
                                                    .data
                                                    .withdraws[index]
                                                    .artistAccountName),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            richText(
                                                hint: "BSB Number : ",
                                                value: response
                                                    .data
                                                    .withdraws[index]
                                                    .artistBsbNumber),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            richText(
                                                hint: "Bank Account Number : ",
                                                value: response
                                                    .data
                                                    .withdraws[index]
                                                    .artistAccountNumber),
                                          ],
                                        ),
                                      )),
                                );
                              })
                          : SizedBox();
                    },
                    child: Container(
                      height: Get.height * 0.1,
                      width: Get.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(color: Colors.grey, blurRadius: 5)
                          ]),
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: Get.height * 0.01,
                            right: Get.height * 0.01,
                            top: Get.height * 0.01,
                            bottom: Get.height * 0.01),
                        child: Row(
                          children: [
                            //DK

                            response.data.withdraws[index].artistImage ==
                                        null ||
                                    response.data.withdraws[index]
                                            .artistImage ==
                                        ''
                                ? imageNotFound()
                                : ClipOval(
                                    child: commonProfileOctoImage(
                                      image: response
                                          .data.withdraws[index].artistImage,
                                      height: Get.height * 0.07,
                                      width: Get.height * 0.07,
                                    ),
                                  ),
                            SizedBox(
                              width: Get.width * 0.02,
                            ),
                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    response.data.withdraws[index].user ?? "",
                                    style: TextStyle(
                                        fontSize: Get.height * 0.016,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: "Poppins"),
                                  ),
                                  Text(
                                    response.data.withdraws[index].userRole ??
                                        "",
                                    style: TextStyle(
                                        fontSize: Get.height * 0.014,
                                        fontFamily: "Poppins"),
                                  )
                                ],
                              ),
                            ),

                            Container(
                              width:70,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "\$${response.data.withdraws[index].ammount ?? ""}",
                                    style: TextStyle(
                                        fontSize: Get.height * 0.023,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: "Poppins"),
                                  ),
                                  Text(
                                    response.data.withdraws[index].status ?? "",
                                    style: TextStyle(
                                        color: response.data.withdraws[index]
                                                    .status ==
                                                "approved"
                                            ? Colors.green
                                            : Colors.red,
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Poppins"),
                                  ),
                                ],
                              ),
                            ),

                            Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "${DateFormat('dd.MM.yy').format(response.data.withdraws[index].createdAt)}",
                                    style: TextStyle(
                                        fontSize: Get.height * 0.016,
                                        fontFamily: "Poppins"),
                                  ),
                                  Text(
                                    "${DateFormat.jm().format(response.data.withdraws[index].createdAt)}",
                                    style: TextStyle(
                                        fontSize: Get.height * 0.016,
                                        fontFamily: "Poppins"),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              width: Get.width * 0.03,
                            ),
                            /* Align(
                              alignment: Alignment.topRight,
                              child: svgMenu,
                            ),*/
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.02,
                  )
                ],
              ),
            ),
          ),
        );
      },
    ),
  );
}

Text richText({String hint, String value}) {
  return Text.rich(TextSpan(children: [
    TextSpan(text: hint, style: TextStyle(fontSize: 18)),
    TextSpan(
        text: value ?? 'N/A',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600))
  ]));
}
