import 'dart:async';
import 'dart:io';

import 'package:beuty_app/comman/chat_date_format.dart';
import 'package:beuty_app/comman/comman_widget.dart';
import 'package:beuty_app/comman/common_octo_image.dart';
import 'package:beuty_app/comman/custom_appbar.dart';
import 'package:beuty_app/comman/zoom_image.dart';
import 'package:beuty_app/res/color_picker.dart';
import 'package:beuty_app/res/const.dart';
import 'package:beuty_app/sharedPreference/shared_preference.dart';
import 'package:beuty_app/viewModel/local_file_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:octo_image/octo_image.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({this.receiverId, this.userImg, this.userName});

  final String receiverId;
  final String userImg;
  final String userName;

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String senderId, receiverId;

  TextEditingController searchController = TextEditingController();

  LocalFileController con = Get.find();

  Future uploadMultiImage() async {
    try {
      final resultList = await MultiImagePicker.pickImages(
        maxImages: 5,
        enableCamera: true,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Example App",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
      print('result ${resultList}');
      if (resultList.isNotEmpty) {
        resultList.forEach((imageAsset) async {
          final filePath =
              await FlutterAbsolutePath.getAbsolutePath(imageAsset.identifier);

          File tempFile = File(filePath);
          if (tempFile.existsSync()) {
            con.addFileImageArray(tempFile);
          }
          await uploadImgFirebaseStorage(file: tempFile);
          print('success');
        });
      }
    } on Exception catch (e) {
      print('error $e');
    }
  }

  uploadImgFirebaseStorage({File file}) async {
    var snapshot = await kFirebaseStorage
        .ref()
        .child('ChatImage/${DateTime.now().microsecondsSinceEpoch}')
        .putFile(file);
    String downloadUrl = await snapshot.ref.getDownloadURL();
    print('url=$downloadUrl');
    // print('path=$fileImageArray');
    chatCollection.doc(chatId(senderId, receiverId)).collection('Data').add({
      'date': DateTime.now(),
      'text': false,
      'senderId': senderId,
      'receiveId': receiverId,
      'seen': false,
      'msg': '',
      'image': [downloadUrl]
    }).then((value) {
      print('success add');
      con.clearImage();
    }).catchError((e) => print('upload error'));
  }

  @override
  void initState() {
    senderId = PreferenceManager.getArtistId().toString();
    receiverId = widget.receiverId; //admin id
    seenOldMessage();
    print('id=>${chatId(senderId, receiverId)}');

    super.initState();
  }

  Future<void> seenOldMessage() async {
    QuerySnapshot data = await FirebaseFirestore.instance
        .collection('Chat')
        .doc(chatId(senderId, receiverId))
        .collection('Data')
        .where('seen', isEqualTo: false)
        .get();

    data.docs.forEach((element) {
      if (receiverId == element.get('senderId')) {
        FirebaseFirestore.instance
            .collection('Chat')
            .doc(chatId(senderId, receiverId))
            .collection('Data')
            .doc(element.id)
            .update({'seen': true});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Scaffold(
        appBar: customAppBar(widget.userName ?? 'N/A', leadingOnTap: () async {
          await seenOldMessage();
          Get.back();
        }),
        body: _chatScreen(),
      ),
    );
  }

  SizedBox _chatScreen() {
    return SizedBox(
      height: Get.height,
      width: Get.width,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              reverse: true,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _chatField(),
                  _localFileImage(),
                ],
              ),
            ),
          ),
          Align(alignment: Alignment.bottomCenter, child: _bottomBar()),
        ],
      ),
    );
  }

  Widget _localFileImage() {
    return GetBuilder<LocalFileController>(
        builder: (LocalFileController contr) {
      print('list:${contr.fileImageArray.value}');
      return contr.fileImageArray.value.isEmpty
          ? SizedBox()
          : Align(
              alignment: Alignment.centerRight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: contr.fileImageArray.value
                    .map((e) => Container(
                          height: 200,
                          width: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          margin: EdgeInsets.only(right: 10, top: 10),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Image(
                                  image: FileImage(e),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.black26,
                                ),
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                            ],
                          ),
                        ))
                    .toList(),
              ),
            );
    });
  }

  StreamBuilder<QuerySnapshot> _chatField() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('Chat')
          .doc(chatId(senderId, receiverId))
          .collection('Data')
          .orderBy('date', descending: true)
          .snapshots(),
      builder: (context, snapShot) {
        if (!snapShot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return snapShot.data.docs.length > 0 ? _chatMsg(snapShot) : SizedBox();
      },
    );
  }

  Widget _chatMsg(AsyncSnapshot<QuerySnapshot> snapShot) {
    return ListView(
      reverse: true,
      padding: EdgeInsets.only(top: 20),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: List.generate(
          snapShot.data.docs.length,
          (index) => snapShot.data.docs[index]['text']
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: snapShot.data.docs[index]['senderId'] == senderId
                      ? Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding:
                                EdgeInsets.only(left: Get.width / 5, right: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Flexible(
                                  child: Card(
                                    margin: EdgeInsets.zero,
                                    color: cRoyalBlue,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(15),
                                            bottomRight: Radius.circular(15),
                                            bottomLeft: Radius.circular(15))),
                                    elevation: 1,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Flexible(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              "${snapShot.data.docs[index]['msg']}",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.white,
                                                fontFamily: 'Poppins',
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 10, bottom: 5),
                                          child: MsgDate(
                                            date: (snapShot.data.docs[index]
                                                    ['date'] as Timestamp)
                                                .toDate(),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                PreferenceManager.getCustomerPImg() == null ||
                                        PreferenceManager.getCustomerPImg() ==
                                            ''
                                    ? imageNotFound()
                                    : ClipOval(
                                        child: commonProfileOctoImage(
                                          image: PreferenceManager
                                              .getCustomerPImg(),
                                          height: Get.height * 0.05,
                                          width: Get.height * 0.05,
                                        ),
                                      ),
                              ],
                            ),
                          ),
                        )
                      : Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                widget.userImg == null || widget.userImg == ''
                                    ? imageNotFound()
                                    : ClipOval(
                                        child: commonProfileOctoImage(
                                          image: widget.userImg,
                                          height: Get.height * 0.05,
                                          width: Get.height * 0.05,
                                        ),
                                      ),
                                Flexible(
                                  child: Padding(
                                    padding:
                                        EdgeInsets.only(right: Get.width / 5),
                                    child: Card(
                                      color: Colors.grey[200],
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(15),
                                            bottomRight: Radius.circular(15),
                                            bottomLeft: Radius.circular(15)),
                                      ),
                                      elevation: 1,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Flexible(
                                              child: Text(
                                                snapShot.data.docs[index]
                                                    ['msg'],
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.black,
                                                  fontFamily: 'Poppins',
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10),
                                              child: MsgDate(
                                                date: (snapShot.data.docs[index]
                                                        ['date'] as Timestamp)
                                                    .toDate(),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                )
              : snapShot.data.docs[index]['senderId'] == senderId
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 10, top: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: (snapShot.data.docs[index]['image']
                                        as List)
                                    .map(
                                      (e) => Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 5),
                                        child: InkWell(
                                          onTap: () {
                                            Get.to(ZoomImage(
                                              img: e,
                                            ));
                                          },
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            child: OctoImage(
                                              image: CachedNetworkImageProvider(
                                                  '$e'),
                                              placeholderBuilder:
                                                  OctoPlaceholder.blurHash(
                                                'LEHV6nWB2yk8pyo0adR*.7kCMdnj',
                                              ),
                                              errorBuilder: OctoError.icon(
                                                  color: Colors.red),
                                              height: 200,
                                              width: 200,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: MsgDate(
                                date: (snapShot.data.docs[index]['date']
                                        as Timestamp)
                                    .toDate(),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        PreferenceManager.getCustomerPImg() == null ||
                                PreferenceManager.getCustomerPImg() == ''
                            ? imageNotFound()
                            : ClipOval(
                                child: commonProfileOctoImage(
                                  image: PreferenceManager.getCustomerPImg(),
                                  height: Get.height * 0.05,
                                  width: Get.height * 0.05,
                                ),
                              ),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        widget.userImg == null || widget.userImg == ''
                            ? imageNotFound()
                            : ClipOval(
                                child: commonProfileOctoImage(
                                  image: widget.userImg,
                                  height: Get.height * 0.05,
                                  width: Get.height * 0.05,
                                ),
                              ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, top: 10),
                          child: Column(
                            children: (snapShot.data.docs[index]['image']
                                    as List)
                                .map(
                                  (e) => Padding(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: InkWell(
                                        onTap: () {
                                          Get.to(ZoomImage(
                                            img: e,
                                          ));
                                        },
                                        child: OctoImage(
                                          image:
                                              CachedNetworkImageProvider('$e'),
                                          placeholderBuilder:
                                              OctoPlaceholder.blurHash(
                                            'LEHV6nWB2yk8pyo0adR*.7kCMdnj',
                                          ),
                                          errorBuilder:
                                              OctoError.icon(color: Colors.red),
                                          height: 200,
                                          width: 200,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: MsgDate(
                            date:
                                (snapShot.data.docs[index]['date'] as Timestamp)
                                    .toDate(),
                          ),
                        )
                      ],
                    )),
    );
  }

  Padding _bottomBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
      child: Row(
        children: [
          Expanded(
              child: SizedBox(
                  height: 50,
                  child: TextFormField(
                    controller: searchController,
                    decoration: InputDecoration(
                      fillColor: Colors.grey[200],
                      filled: true,
                      hintText: 'Write a reply..',
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                          borderSide: BorderSide.none),
                      contentPadding: EdgeInsets.symmetric(horizontal: 15),
                    ),
                  ))),
          SizedBox(width: 10),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkResponse(
                onTap: () {
                  uploadMultiImage();
                },
                child: Icon(Icons.image),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: InkResponse(
                  onTap: () async {
                    // bool status=await checkCameraPermission();
                    // if(status){
                    ImagePicker imagePicker = ImagePicker();
                    PickedFile file =
                        await imagePicker.getImage(source: ImageSource.camera);
                    if (file != null) {
                      con.addFileImageArray(File(file.path));
                      uploadImgFirebaseStorage(file: File(file.path));
                    }
                    //}
                  },
                  child: Icon(Icons.camera_alt),
                ),
              ),
            ],
          ),
          SizedBox(width: 10),
          InkResponse(
            onTap: addTextData,
            child: CircleAvatar(
              backgroundColor: cRoyalBlue,
              child: Center(
                child: Icon(
                  Icons.send_rounded,
                  size: 20,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  addTextData() {
    if (searchController.text.isEmpty) {
      CommanWidget.snackBar(message: 'Please first write meaage..');
    } else {
      FirebaseFirestore.instance
          .collection('Chat')
          .doc(chatId(senderId, receiverId))
          .collection('Data')
          .add({
            'date': DateTime.now(),
            'text': true,
            'senderId': senderId,
            'receiveId': receiverId,
            'seen': false,
            'msg': searchController.text,
            'image': null
          })
          .then((value) => searchController.clear())
          .catchError((e) => print(e));
    }
  }
}
