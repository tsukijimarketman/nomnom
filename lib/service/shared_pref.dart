import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper{
  static String userIdKey = "USERKEY";
  static String userNameKey = "USERNAMEKEY";
  static String userEmailKey = "USEREMAILKEY";
  static String userWalletKey = "USERWALLETKEY";
  static String passwordKey = "USERPASSWORDKEY";
  static String userProfileKey = "USERPROFILEKEY";
  static String userAddressKey = "USERADDRESSKEY"; 

  Future<bool> saveUserId(String getUserId)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userIdKey, getUserId);
  }

  Future<bool> saveUserAddress(String getUserAddress)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userAddressKey, getUserAddress);
  }

  Future<bool> saveUserName(String getUserName)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userNameKey, getUserName);
  }

  Future<bool> saveUserProfile(String getUserProfile)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userProfileKey, getUserProfile);
  }

  Future<bool> saveUserEmail(String getUserEmail)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userEmailKey, getUserEmail);
  }

  Future<bool> saveUserWallet(String getUserWallet)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userWalletKey, getUserWallet);
  }

  Future<bool> saveUserPassword(String getUserPassword)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(passwordKey, getUserPassword);
  }

  Future<String?> getUserId()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userIdKey);
  }

  Future<String?> getUserName()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userNameKey);
  }

  Future<String?> getUserEmail()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userEmailKey);
  }

  Future<String?> getUserWallet()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userWalletKey);
  }
  
  Future<String?> getUserPassword()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(passwordKey);
  }

  Future<String?> getUserProfile()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userProfileKey);
  }

  Future<String?> getUserAddress()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userAddressKey);
  }
}