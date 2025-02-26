import 'package:flutter/material.dart';

class ChapterProvider extends ChangeNotifier{
  String _name = '';
  String _comment = '';
  double _score = 0;
  int _sagaId = 0;

  String get name => _name;
  set name(String value){
    _name = value;
    notifyListeners();
  }

  String get comment => _comment;
  set comment(String value){
    _comment = value;
    notifyListeners();
  }

  double get score => _score;
  set score(double value){
    _score = value;
    notifyListeners();
  }

  int get sagaId => _sagaId;
  set sagaId(int value){
    _sagaId = value;
    notifyListeners();
  }

  Map<String, dynamic> getData() => {
    "name": _name,
    "score": _score,
    "comment": _comment,
    "saga_id": _sagaId
  };

  

  void cleanData(){
    _name = '';
    _comment = '';
    _score = 0;
    _sagaId = 0;
  }
}