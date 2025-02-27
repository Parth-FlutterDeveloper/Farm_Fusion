import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {

  static String userNameKey = "USERNAMEKEY";
  static String userEmailKey = "USEREMAILKEY";
  static String userIdKey = "USERIDKEY";

  // To save data from shared preferences

  Future<bool> saveUserName(String getUserName) async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    return preference.setString(userNameKey, getUserName);
  }

  Future<bool> saveUserEmail(String getUserEmail) async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    return preference.setString(userEmailKey, getUserEmail);
  }

  Future<bool> saveUserId(String getUserId) async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    return preference.setString(userIdKey, getUserId);
  }

  Future<void> saveUserProfileImage(String url) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userProfileImage', url);
  }

  Future<void> saveAdminProfileImage(String url) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('adminProfileImage', url);
  }

  // For Getting data from shared preferences

  Future<String?> getUserName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(userNameKey);
  }

  Future<String?> getUserEmail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(userEmailKey);
  }

  Future<String?> getUserId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(userIdKey);
  }

  Future<String?> getUserProfileImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userProfileImage');
  }

  Future<String?> getAdminProfileImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('adminProfileImage');
  }

}