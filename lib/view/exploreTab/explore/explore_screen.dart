
import 'package:beuty_app/comman/custom_appbar.dart';
import 'package:beuty_app/comman/loading_indicator.dart';
import 'package:beuty_app/comman/story_circle_box.dart';
import 'package:beuty_app/comman/svg.dart';
import 'package:beuty_app/model/apiModel/responseModel/get_artist_allstory_response_model.dart';
import 'package:beuty_app/model/apis/api_response.dart';
import 'package:beuty_app/res/color_picker.dart';
import 'package:beuty_app/view/exploreTab/explore/widgets/category_box_list.dart';
import 'package:beuty_app/viewModel/get_all_tags_viewmodel.dart';
import 'package:beuty_app/viewModel/get_category_viewModel.dart';
import 'package:beuty_app/viewModel/new_story_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets/hair_box_list.dart';

class ExploreScreen extends StatefulWidget {
  final String role;

  const ExploreScreen({Key key, this.role = 'Artist'}) : super(key: key);

  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  GetCategoryViewModel getCategoryViewModel = Get.find();
  GetAllTagsViewModel getAllTagsViewModel = Get.find();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategoryViewModel.getCategory();
    getAllTagsViewModel.getAllTag();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cDarkBlue,
      appBar: customAppBar(
        'Explore',
        action: svgChat(),
      ),
      body: _buildBody(),
    );
  }

  Column _buildBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Text(
            'Near by artist',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        storyList(),
        SizedBox(
          height: 10,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: SingleChildScrollView(
              padding: EdgeInsets.only(bottom: 10),
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  categoryBoxList(),
                  SizedBox(
                    height: 10,
                  ),
                  hairCategory()
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Padding storyList() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: GetBuilder<NewStoryViewModel>(
        builder: (controller) {
          if (controller.apiResponse.status == Status.LOADING) {
            return circularIndicator();
          }
          if (controller.apiResponse.status == Status.ERROR) {
            return SizedBox();
          }
          GetArtistAllStoryResponse response=controller.apiResponse.data;
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            child: Row(
              children: List.generate(
               response

                    .data
                    .length,
                (index) => Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: storyBox(
                      response
                          .data[index]
                          .id,
                      artistId: response
                          .data[index]
                          .artistId
                          .toString(),
                      profileImg: response.data[index].user.profilePic,
                      image:response
                          .data[index]
                          .storyImage),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
