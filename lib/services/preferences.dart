import 'dart:convert';

import 'package:mymedialist/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static late SharedPreferences pref;
  static Future<void> init() async {
    pref = await SharedPreferences.getInstance();
  }

  static User get userInfo{
    try {
      dynamic userData = pref.getString('userInfo');
      if(userData == null) return User();
      return User.fromJson(jsonDecode(pref.getString('userInfo') ?? ''));
    } catch (e) {
      throw Exception(e.toString());
    }
  }
  static set userInfo(User newUser) => pref.setString('userInfo', jsonEncode(newUser.toJson()));

  static bool get rememberme => pref.getBool('rememberme') ?? false;
  static set rememberme(bool newValue) => pref.setBool('rememberme', newValue);

  static bool get showedSplash => pref.getBool('showedSplash') ?? false;
  static set showedSplash(bool newValue) => pref.setBool('showedSplash', newValue);
}