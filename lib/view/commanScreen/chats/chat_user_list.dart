import 'package:beuty_app/comman/chat_date_format.dart';
import 'package:beuty_app/comman/common_octo_image.dart';
import 'package:beuty_app/comman/custom_appbar.dart';
import 'package:beuty_app/comman/loading_indicator.dart';
import 'package:beuty_app/model/apiModel/responseModel/following_followers_response_model.dart';
import 'package:beuty_app/model/apis/api_response.dart';
import 'package:beuty_app/res/color_picker.dart';
import 'package:beuty_app/sharedPreference/shared_preference.dart';
import 'package:beuty_app/view/commanScreen/chats/chat_screen.dart';
import 'package:beuty_app/viewModel/bottom_bar_viewmodel.dart';
import 'package:beuty_app/viewModel/chat__viewmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserListChat extends StatefulWidget {
  final String previousRoute;

  const UserListChat({Key key, this.previousRoute}) : super(key: key);

  @override
  _UserListChatState createState() => _UserListChatState();
}

class _UserListChatState extends State<UserListChat> {
  BottomBarViewModel _barController = Get.find();
  ChatViewModel _chatController = Get.find();
  TextEditingController searchTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _chatController.clearSearchStr();
    _chatController
        .getFollowingFollowers(PreferenceManager.getArtistId().toString());
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _barController.setSelectedRoute(widget.previousRoute);

        return Future.value(false);
      },
      child: Scaffold(
        appBar: customAppBar('Chat', leadingOnTap: () {
          _barController.setSelectedRoute(widget.previousRoute);
        }),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [searchTextField(), messageText(), bottomList(context)],
        ),
      ),
    );
  }

  Expanded bottomList(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: GetBuilder<ChatViewModel>(
          builder: (controller) {
            if (controller.followingFollowersApiResponse.status ==
                Status.LOADING) {
              return Center(
                child: circularIndicator(),
              );
            }
            if (controller.followingFollowersApiResponse.status ==
                Status.ERROR) {
              return Center(
                child: Text('Server Error'),
              );
            }
            FollowingFollowersResponse response =
                controller.followingFollowersApiResponse.data;
            List<Follow> listData = [];
            if (controller.searchStr.value == '') {
              if (PreferenceManager.getCustomerRole() == 'Artist') {
                listData = response.followers;
              } else {
                listData = response.followings;
              }
            } else {
              if (PreferenceManager.getCustomerRole() == 'Artist') {
                response.followers.forEach((element) {
                  if (element.username
                      .toLowerCase()
                      .contains(controller.searchStr.value.toLowerCase())) {
                    listData.add(element);
                  }
                });
              } else {
                response.followings.forEach((element) {
                  if (element.username
                      .toLowerCase()
                      .contains(controller.searchStr.value.toLowerCase())) {
                    listData.add(element);
                  }
                });
              }
            }
            return Column(
              children: List.generate(
                  listData.length,
                  (index) =>
                      listData[index].id == PreferenceManager.getArtistId()
                          ? SizedBox()
                          : Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: Get.width * 0.04,
                                  vertical: Get.height * 0.015),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _profileImg(listData, index),
                                  _userNameText(context, listData, index),
                                  _time(listData, index)
                                ],
                              ),
                            )),
            );
          },
        ),
      ),
    );
  }

  Column _time(List<Follow> listData, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        StreamBuilder<QuerySnapshot>(
          stream: getLastMsgData(listData[index].id),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return SizedBox();
            }
            DateTime lastMsgTime;
            List<DocumentSnapshot> docs = snapshot.data.docs;
            if (docs.length == 1) {
              lastMsgTime = docs[0].get('date').toDate();
            }
            print('last Msg :$lastMsgTime');
            return lastMsgTime == null
                ? SizedBox()
                : MsgDate(
                    date: docs[0].get('date').toDate(),
                  );
          },
        ),
        StreamBuilder<QuerySnapshot>(
            stream: getPendingSeenData(listData[index].id),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                int length = 0;
                length = snapshot.data.docs.fold(
                    0,
                    (previousValue, element) =>
                        previousValue +
                        (element.get('senderId') ==
                                listData[index].id.toString()
                            ? 1
                            : 0));
                return length == 0
                    ? SizedBox()
                    : Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: cRoyalBlue),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Center(
                            child: Text(
                              '$length',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ),
                        ));
              } else {
                return SizedBox();
              }
            }),
      ],
    );
  }

  Expanded _userNameText(
      BuildContext context, List<Follow> listData, int index) {
    return Expanded(
      flex: 4,
      child: Padding(
        padding: EdgeInsets.only(left: Get.width * 0.03),
        child: InkWell(
          onTap: () {
            _chatController.clearSearchStr();
            searchTextController.clear();
            FocusScope.of(context).unfocus();
            Get.to(ChatScreen(
              userImg: listData[index].image,
              userName: '${listData[index].username}',
              receiverId: listData[index].id.toString(),
            ));
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${listData[index].username}',
                style: TextStyle(
                    fontSize: Get.height * 0.018,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Poppins"),
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: getLastMsgData(listData[index].id),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return SizedBox();
                    }
                    String lastMsg = '';
                    List<DocumentSnapshot> docs = snapshot.data.docs;
                    if (docs.length == 1) {
                      lastMsg = docs[0].get('msg') == ''
                          ? 'Photo'
                          : docs[0].get('msg');
                    }
                    print('last Msg :$lastMsg');
                    return Padding(
                      padding: EdgeInsets.only(right: Get.width * 0.08),
                      child: Text(
                        lastMsg,
                        style: TextStyle(
                            fontSize: Get.height * 0.016,
                            fontFamily: "poppins",
                            fontWeight: FontWeight.w400),
                      ),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }

  Widget _profileImg(List<Follow> listData, int index) {
    return listData[index].image == null || listData[index].image == ''
        ? imageNotFound()
        : ClipOval(
            child: commonProfileOctoImage(
              image: listData[index].image,
              height: Get.height * 0.07,
              width: Get.height * 0.07,
            ),
          );
  }

  Padding messageText() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Get.width * 0.04, vertical: Get.height * 0.01),
      child: Text(
        'Messages',
        style: TextStyle(
          fontSize: Get.height * 0.022,
          fontFamily: "Poppins",
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Padding searchTextField() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Get.width * 0.04, vertical: Get.height * 0.02),
      child: Align(
        alignment: Alignment.centerLeft,
        child: TextField(
            controller: searchTextController,
            onChanged: (value) {
              _chatController.setSearchStr(value);
            },
            decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 1),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey, width: 1),
                ),
                hintText: "Search..",
                prefixIcon: Image.asset(
                  'assets/image/search.png',
                  height: Get.height * 0.020,
                  width: Get.width * 0.020,
                ),
                hintStyle: TextStyle(
                    fontSize: Get.height * 0.020,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Manrope",
                    color: Colors.grey)),
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontFamily: "Manrope",
                color: Colors.black,
                fontSize: Get.height * 0.020)),
      ),
    );
  }

  Stream<QuerySnapshot> getPendingSeenData(int id) {
    String senderId = PreferenceManager.getArtistId().toString();
    String receiverId = id.toString();
    return FirebaseFirestore.instance
        .collection('Chat')
        .doc(chatId(senderId, receiverId))
        .collection('Data')
        .where('seen', isEqualTo: false)
        .snapshots();
  }

  Stream<QuerySnapshot> getLastMsgData(int id) {
    String senderId = PreferenceManager.getArtistId().toString();
    String receiverId = id.toString();
    return FirebaseFirestore.instance
        .collection('Chat')
        .doc(chatId(senderId, receiverId))
        .collection('Data')
        .orderBy('date')
        .limitToLast(1)
        .snapshots();
  }
}
