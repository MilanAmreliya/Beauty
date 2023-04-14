import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class PreferenceManager {
  static GetStorage getStorage = GetStorage();

  ///email
  static Future setEmailId(String value) async {
    await getStorage.write("email_id", value);
  }

  static String getEmailId() {
    return getStorage.read("email_id");
  }

  ///username
  static Future setUserName(String value) async {
    await getStorage.write("username", value);
  }///username
  static Future setShopPromotion(String value) async {
    await getStorage.write("promotion", value);
  }

  static String getUserName() {
    return getStorage.read("username");
  }static String getShopPromotion() {
    return getStorage.read("promotion");
  }

  ///name
  static Future setName(String value) async {
    await getStorage.write("name", value);
  }

  static String getName() {
    return getStorage.read("name");
  }

  ///bio
  static Future setBio(String value) async {
    await getStorage.write("bio", value);
  }

  static String getBio() {
    return getStorage.read("bio");
  }

  ///customer role
  static Future setCustomerRole(String value) async {
    await getStorage.write("customer_role", value);
  }

  static String getCustomerRole() {
    return getStorage.read("customer_role");
  }
  ///Walking Screen
  static Future setWalkingScreen(bool value) async {
    await getStorage.write("walkingScreen", value);
  }

  static bool getWalkingScreen() {
    return getStorage.read("walkingScreen");
  }

  ///customer image

  static Future setCustomerPImg(String value) async {
    await getStorage.write("profileImage", value);
  }

  static String getCustomerPImg() {
    return getStorage.read("profileImage");
  }

  ///customer id

  static Future setArtistId(int value) async {
    await getStorage.write("artist_id", value);
  }

  static int getArtistId() {
    return getStorage.read("artist_id");
  }

  /// token

  static Future setToken(String value) async {
    await getStorage.write("token", value);
  }

  static String getToken() {
    return getStorage.read("token");
  }

  /// FCM token

  static Future setFCMToken(String value) async {
    await getStorage.write("fcmToken", value);
  }

  static String getFCMToken() {
    return getStorage.read("fcmToken");
  }

  /// shopId

  static Future setShopId(int value) async {
    print("shop_id:>$value");
    await getStorage.write("shop_id", value);
  }

  static int getShopId() {
    return getStorage.read("shop_id");
  }

  ///clear data
  static Future<void> clearData() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    await getStorage.write('email_id', null);
    await getStorage.write("username", null);
    await getStorage.write("customer_role", null);
    await getStorage.write("artist_id", null);
    await getStorage.write("shop_id", null);
    await getStorage.write("token", null);
    await getStorage.write("fcmToken", null);

    await googleSignIn
        .signOut()
        .catchError((e) => print('google logout error :$e'));
  }

  ///favorite
  static Future setFavorite(List list) async {
    await getStorage.write("favorite", list);
  }

  static List getFavorite() {
    return getStorage.read("favorite");
  }
}
