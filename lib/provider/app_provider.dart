import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mymedialist/main.dart';
import 'package:mymedialist/models/user.dart';
import 'package:mymedialist/services/api_service.dart';
import 'package:mymedialist/services/preferences.dart';
import 'package:mymedialist/widgets/general/alert.dart';
import 'package:provider/provider.dart';

class AppProvider extends ChangeNotifier{
  bool _showedSplash = false;
  User _userInfo = User();

  bool get showedSplash => _showedSplash;
  set showedSplash(bool newValue){
    _showedSplash = newValue;
    notifyListeners();
  }

  User get userInfo => _userInfo;
  set userInfo(User newValue){
    _userInfo = newValue;
    notifyListeners();
  }

  Future<bool> login({required Map<String, dynamic> credentials}) async {
    try {
       Response response = await ApiService.request('/login', body: credentials);
       if (response.statusCode == 200) {
        userInfo = User.fromJson(response.data['data']);
        Preferences.token = userInfo.token;
        return true;
       } else {
        return false;
       }
    } catch (e) {
      Alert.show(text: e.toString());
      throw Exception(e);
    }
  }

  Future<bool> register({required Map<String, dynamic> data}) async {
    try {
      Response response = await ApiService.request('/register', body: data);
      if (response.statusCode == 201) {
        userInfo = User.fromJson(response.data['data']);
        Preferences.token = userInfo.token;
        return true;
      } else {
        return false;
      }
    } catch (e) {
      Alert.show(text: e.toString());
      throw Exception(e);
    }
  }

  Future<bool> logout() async {
    try {
      String token = navigatorKey.currentState!.context.read<AppProvider>().userInfo.token;
      Response response = await ApiService.request('/logout', auth: token, isPostWithoutBody: true);
      return (response.statusCode == 200);
    } catch (e) {
      Alert.show(text: e.toString());
      throw Exception(e);
    }
  }

  Future<bool> makeLogout() async {
    try {
      bool isUnloged = await logout();
      return (isUnloged) ? _onLogoutSuccess() : _onLogoutFailure();
    } catch (e) {
      Alert.show(text: e.toString());
      return false;
    }
  }

  bool _onLogoutSuccess(){
    userInfo = User();
    Preferences.rememberme = false;
    Preferences.token = "";
    return true;
  }

  bool _onLogoutFailure(){
    Alert.show(
      text: 'Error al cerrar sesión',
      contentWidth: 150,
      background: Colors.red.shade800,
      textColor: Colors.white
    );
    return false;
  }
}
