import 'package:beuty_app/comman/get_location.dart';
import 'package:beuty_app/services/app_notification.dart';
import 'package:beuty_app/view/genralScreen/splash_screen.dart';
import 'package:beuty_app/viewModel/appointment_viewmodel.dart';
import 'package:beuty_app/viewModel/artist_profile_viewmodel.dart';
import 'package:beuty_app/viewModel/comment_like_post_viewmodel.dart';
import 'package:beuty_app/viewModel/get_all_tags_viewmodel.dart';
import 'package:beuty_app/viewModel/get_category_viewModel.dart';
import 'package:beuty_app/viewModel/local_file_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'viewModel/artist_home_tab_viewmodel.dart';
import 'viewModel/bottom_bar_viewmodel.dart';
import 'viewModel/chat__viewmodel.dart';
import 'viewModel/login_viewmodel.dart';
import 'viewModel/model_profile_viewmodel.dart';
import 'viewModel/new_story_viewmodel.dart';
import 'viewModel/register_viewmodel.dart';
import 'viewModel/validation_viewmodel.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  ///firebase initiallize
  await Firebase.initializeApp();

  ///Get storage initialize
  await GetStorage.init();

  ///local notification...
  FirebaseMessaging.onBackgroundMessage(
      AppNotificationHandler.firebaseMessagingBackgroundHandler);

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  IOSInitializationSettings initializationSettings = IOSInitializationSettings(
      requestAlertPermission: true,
      requestSoundPermission: true,
      requestBadgePermission: true);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(AppNotificationHandler.channel);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>()
      ?.initialize(initializationSettings);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>()
      ?.requestPermissions(alert: true, badge: true, sound: true);

  // Update the iOS foreground notification presentation options to allow
  // heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  ///Get FCM Token..
  await AppNotificationHandler.getFcmToken();

  /// get current location..
  await GetLocation.checkLocationPermission();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("code merged");
    return GetMaterialApp(
      title: 'Beauty',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(),
    );
  }

  /// controller init..
  BottomBarViewModel bottomBarViewModel = Get.put(BottomBarViewModel());
  ValidationViewModel validationViewModel = Get.put(ValidationViewModel());
  ChatViewModel chatViewModel = Get.put(ChatViewModel());
  RegisterViewModel registerViewModel = Get.put(RegisterViewModel());
  AppointmentViewModel appointmentViewModel = Get.put(AppointmentViewModel());
  HomeTabViewModel getArtistAllStoryViewModel = Get.put(HomeTabViewModel());
  GetCategoryViewModel getCategoryViewModel = Get.put(GetCategoryViewModel());
  NewStoryViewModel newStoryViewModel = Get.put(NewStoryViewModel());
  ArtistProfileViewModel artistProfileViewModel =
      Get.put(ArtistProfileViewModel());
  CommentAndLikePostViewModel createCommentPostViewModel =
      Get.put(CommentAndLikePostViewModel());
  GetAllTagsViewModel getAllTagsViewModel = Get.put(GetAllTagsViewModel());
  LoginViewModel loginViewModel = Get.put(LoginViewModel());
  ModelProfileViewModel modelProfileViewModel =
      Get.put(ModelProfileViewModel());
  LocalFileController con = Get.put(LocalFileController());
}
