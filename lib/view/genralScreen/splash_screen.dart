
import 'package:beuty_app/comman/check_shop_exist.dart';
import 'package:beuty_app/comman/images.dart';
import 'package:beuty_app/services/app_notification.dart';
import 'package:beuty_app/sharedPreference/shared_preference.dart';
import 'package:beuty_app/view/authScreen/signin/sign_in_screen.dart';
import 'package:beuty_app/view/authScreen/signup/sign_up_screen.dart';
import 'package:beuty_app/view/bottomBar/bottom_bar.dart';
import 'package:beuty_app/view/walking_screen.dart';
import 'package:beuty_app/viewModel/validation_viewmodel.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  ValidationViewModel controller = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    AppNotificationHandler.getInitialMsg();
    AppNotificationHandler.showMsgHandler();
    AppNotificationHandler.onMsgOpen();
    Future.delayed(Duration(seconds: 2), () async {
      final role = PreferenceManager.getCustomerRole();
     final walkingScreen = PreferenceManager.getWalkingScreen();

      print("emailId....>$role");
      if (walkingScreen == null) {
        Get.off(WalkingScreen());
      } else {
        if(role==null){
          Get.off(SignUpScreen());
          // Get.off(SignIn());
        }
        else if (role == 'Artist') {
          checkShopExist();
        } else {
          Get.off(BottomBar());
        }
      }
    });

    super.initState();
    // this.initDynamicLinks();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height,
      width: Get.width,
      margin: EdgeInsets.all(50),
      child: iSplashImage,
    );
  }
/*  void initDynamicLinks() async {

    SharedPreferencesManager sharedPreferencesManager = new SharedPreferencesManager();

    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData dynamicLink) async {
          final Uri deepLink = dynamicLink?.link;
          if (deepLink != null) {
            Navigator.pushNamed(context, deepLink.path);
          }
        },
        onError: (OnLinkErrorException e) async {
          print('onLinkError');
          print(e.message);
        }
    );
    final PendingDynamicLinkData data = await FirebaseDynamicLinks.instance.getInitialLink();
    if(data!=null) {
      print("Dynamic Link Data: " + data.toString());
    } else {
      print("Dynamic Link Data Null");
    }
    final Uri deepLink = data?.link;

    if (deepLink != null) {
      print("Deep Link: "+deepLink.toString());
      final queryParams = deepLink.queryParameters;
      if (queryParams.length > 0) {
        var agentid = queryParams['agentid'].toString();
        sharedPreferencesManager.setAuthToken(Utility.AGENT_ID, agentid);

        print("AGENT ID: "+agentid);
      }
    }
  }*/

}
