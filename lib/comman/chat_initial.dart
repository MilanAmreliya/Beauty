import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseChatInitial {
  static void userAddOneTimeInFirebase({String artistId,String username,String toKen,String customerImage}){
    FirebaseFirestore.instance.collection('users').doc(artistId).set({
      'nickname': username,
      'photoUrl': customerImage,
      'id': toKen,
      'createdAt': DateTime.now().millisecondsSinceEpoch.toString(),
      'chattingWith': null
    });
  }
}
