import 'dart:io';

import 'package:flutter/material.dart';

class UploadImageProvider extends ChangeNotifier {
  File _temporaryImage = File('');
  bool _multipleImages = false;

  File get temporaryImage => _temporaryImage;
  set temporaryuImage(File newImage){
    _temporaryImage = newImage;
    notifyListeners();
  }

  bool get multipleImages => _multipleImages;
  set multipleImages(bool newValue){
    _multipleImages = newValue;
    notifyListeners();
  }

  void cleanData(){
    _temporaryImage = File('');
    _multipleImages = false;
  }

}