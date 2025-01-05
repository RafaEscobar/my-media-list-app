import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier{
  bool _hasShowSplash = false;
  String _token = '';

  bool get hasShowSplash => _hasShowSplash;
  set hasShowSplash(bool newValue){
    _hasShowSplash = newValue;
    notifyListeners();
  }

  String get token => _token;
  set token(String newValue){
    _token = newValue;
    notifyListeners();
  }
}