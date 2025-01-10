import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mymedialist/models/user.dart';
import 'package:mymedialist/services/api_service.dart';
import 'package:mymedialist/services/preferences.dart';

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
      throw Exception(e);
    }
  }

  Future<bool> register({required Map<String, dynamic> data}) async {
    try {
      Response response = await ApiService.request('/register', body: data);
      if (response.statusCode == 201) {
        userInfo = User.fromJson(response.data['data']);
        Preferences.token = userInfo.token;
        print('de');
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  void logout(){
    userInfo = User();
    Preferences.rememberme = false;
    Preferences.token = "";
  }
}
