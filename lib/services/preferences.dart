import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static late SharedPreferences pref;
  static Future<void> init() async {
    pref = await SharedPreferences.getInstance();
  }

  static String get token => pref.getString('token') ?? '';
  static set token(String newToken) => pref.setString('token', newToken);

  static bool get logged => pref.getBool('logged') ?? false;
  static set logged(bool newValue) => pref.setBool('logged', newValue);
}