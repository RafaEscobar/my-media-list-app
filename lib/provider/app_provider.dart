import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mymedialist/services/api_service.dart';

class AppProvider extends ChangeNotifier{
  String _token = '';
  bool _hasShowSplash = false;

  String get token => _token;
  set token(String newValue){
    _token = newValue;
    notifyListeners();
  }

  bool get hasShowSplash => _hasShowSplash;
  set hasShowSplash(bool newValue) {
    _hasShowSplash = newValue;
    notifyListeners();
  }

  Future<void> login(Map<String, dynamic> credentials) async {
    try {
       Response response = await ApiService.request('login', body: credentials);
       if (response.statusCode == 200) {
         
       }
    } catch (e) {
      throw Exception(e);
    }
  }
}
