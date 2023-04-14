import 'dart:convert';
import 'dart:developer';

import 'package:beuty_app/message_argument.dart';
import 'package:beuty_app/sharedPreference/shared_preference.dart';
import 'package:beuty_app/view/bottomBar/bottom_bar.dart';
import 'package:beuty_app/viewModel/bottom_bar_viewmodel.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AppNotificationHandler {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      new FlutterLocalNotificationsPlugin();
  static AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  ///get fcm token
  static Future<String> getFcmToken() async {
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    try {
      String token = await firebaseMessaging.getToken().catchError((e){
        log("=========fcm- Error ....:$e");
      });
      await PreferenceManager.setFCMToken(token);
      log("=========fcm-token===$token");
      return token;
    } catch (e) {
      log("=========fcm- Error :$e");
      return null;
    }
  }

  ///call when app in fore ground
  static void showMsgHandler() {
    print('showMsgHandler...');
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      print('NOtification Call :${notification?.apple}${notification.body}${notification.title}');
      if (notification != null) {
        showMsg(notification);
      }
    }).onError((e){
      print('Error Notification : ....$e');

    });
  }

  /// handle notification when app in fore ground..
  static void getInitialMsg() {
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage message) {
      BottomBarViewModel bottomBarViewModel = Get.find();
      if (message != null) {
        Get.offAll(BottomBar());
      }
    });
  }

  ///show notification msg
  static void showMsg(RemoteNotification notification) {
    flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            'high_importance_channel', // id
            'High Importance Notifications', // title
            'This channel is used for important notifications.',
            // description
            importance: Importance.high,
            icon: '@drawable/ic_stat_ic_launcher_foreground',
          ),
        ));
  }

  ///background notification handler..
  static Future<void> firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    await Firebase.initializeApp();
    print('Handling a background message ${message.messageId}');
    RemoteNotification notification = message.notification;
  }

  ///call when click on notification
  static void onMsgOpen() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      print('listen->${message.data}');
      BottomBarViewModel bottomBarViewModel = Get.find();
      Get.offAll(BottomBar());
    });
  }

  ///SEND NOTIFICATION FROM ONE DEVICE TO ANOTHER DEVICE...
  static Future<bool> sendMessage(List<String> receiverFcmToken, {String msg}) async {
    // var serverKey =
    //     'AAAAdez3bn0:APA91bGgtXxfH0x456OJmbpCWrWZJKfOIzAjgNbhspWTL3sylWArzHCi4TIdS1G_XLbIHUAyOREOWLy7NF0TokYSbdNjk1-wgiOGjh6x7wnW76hbOTqyJ_v-gy9hknDS6n2CMp5xZFpp';
 var serverKey =  'AAAAigHntS4:APA91bFUMyrwuLfi-0BVV2h2gFHyidwtOEkv_Jr3e4ZU-0jBGbvDUmLLs15wJjFhvEw1UlgWXmqJosk1N8iDug_sPjJ9WBMrzonBJeAG0l98sFpbvNxAfYMS5U34SYdL5c7umwhxRymE';
 try {
      for (String token in receiverFcmToken) {
        log("RESPONSE TOKEN  ${token}");

        http.Response response = await http.post(
          Uri.parse('https://fcm.googleapis.com/fcm/send'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': 'key=$serverKey',
          },
          body: jsonEncode(
            <String, dynamic>{
              'notification': <String, dynamic>{
                'body': msg??'liked your post',
                'title': PreferenceManager.getUserName() ?? 'Beauty'
              },

              'priority': 'high',
              'data': <String, dynamic>{
                'click_action': 'FLUTTER_NOTIFICATION_CLICK',
                'id': '1',
                'status': 'done'
              },
              'to': token,
            },
          ),
        );
        log("RESPONSE CODE ${response.statusCode}");

        log("RESPONSE BODY ${response.body}");
      }
    } catch (e) {
      print("error push notification");
    }
  }
}
