import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mymedialist/services/api_service.dart';

class AppProvider extends ChangeNotifier{
  String _token = '';
  bool _showedSplash = false;

  bool get showedSplash => _showedSplash;
  set showedSplash(bool newValue){
    _showedSplash = newValue;
    notifyListeners();
  }

  String get token => _token;
  set token(String newValue){
    _token = newValue;
    notifyListeners();
  }

  Future<bool> login({required Map<String, dynamic> credentials}) async {
    try {
       Response response = await ApiService.request('/login', body: credentials);
       return (response.statusCode == 200);
    } catch (e) {
      throw Exception(e);
    }
  }
}
