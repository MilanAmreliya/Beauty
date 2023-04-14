import 'package:beuty_app/comman/comman_widget.dart';
import 'package:beuty_app/model/apiModel/requestModel/add_rating_request_model.dart';
import 'package:beuty_app/model/apiModel/responseModel/add_rating_response_model.dart';
import 'package:beuty_app/model/apis/api_response.dart';
import 'package:beuty_app/sharedPreference/shared_preference.dart';
import 'package:beuty_app/viewModel/comment_like_post_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

CommentAndLikePostViewModel commentAndLikePostViewModel = Get.find();
double ratingss = 1;
Future<void> ratingDialog() {
  return Get.dialog(Dialog(
    insetPadding: EdgeInsets.symmetric(horizontal: 30),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0)), //this right here
    child: StatefulBuilder(
      builder: (context, setState) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Service Name'),
              SizedBox(
                height: 20,
              ),
              Text('Plaese Rate'),
              SizedBox(
                height: 30,
              ),
              RatingBar.builder(
                initialRating: ratingss,
                minRating: 1,
                glow: false,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) async {
                  print(rating);
                  ratingss = rating;
                },
              ),
              SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () async {
                  AddRateReqModel addrate = AddRateReqModel();
                  addrate.artistId = "148";
                  addrate.rating = ratingss.toString();
                  addrate.serviceId = "77";
                  addrate.reviwerId =
                      PreferenceManager.getArtistId().toString();
                  await commentAndLikePostViewModel.addRating(addrate);
                  if (commentAndLikePostViewModel.addRatingApiResponse.status ==
                      Status.COMPLETE) {
                    AddRatingResponse response =
                        commentAndLikePostViewModel.addRatingApiResponse.data;
                    if (response.message == "Review created") {
                      CommanWidget.snackBar(
                        message: response.message,
                      );
                      Future.delayed(Duration(seconds: 2), () {
                        Get.back();
                      });
                    } else {
                      CommanWidget.snackBar(
                        message: 'Server error',
                      );
                    }
                  } else {
                    CommanWidget.snackBar(
                      message: 'Google Login failed',
                    );
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                        colors: [
                          Color(0xFF3E5AEF),
                          Color(0xFF6C0BB9),
                        ],
                        begin: const FractionalOffset(0.0, 0.0),
                        end: const FractionalOffset(1.0, 0.0),
                        stops: [0.0, 1.0],
                        tileMode: TileMode.clamp),
                  ),
                  height: 40,
                  width: 100,
                  child: Center(
                    child: Text(
                      'Submit',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        fontFamily: "Poppins",
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    ),
  ));
}
