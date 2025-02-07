import 'package:flutter/material.dart';

class EntertainmentEntityProvider extends ChangeNotifier {
  // Current step in process to create a media register
  int _currentStep = 0;

  //* Data to create a media register
  Map<String, dynamic> _mediaData = {
    "title": '',
    "score": '',
    "comment": '',
    "category_id": null,
    "status_id": null,
    "pending_priority_id": null,
    "post_view_priority_id": null,
    "image": ''
  };

  //* Data to create a saga register
  Map<String, dynamic> _sagaData = {
    'title': '',
    'num_caps': null,
    'season': null,
    'final_comment': '',
    'category_id': null,
    'status_id': null,
    'pending_priority_id': null,
    'post_view_priority_id': null,
    'image': ''
  };

  //* Important variables to the create flow
  String _type = '';
  String _subtype = '';
  bool _shouldAddMoreInfo = false;
  bool _isPendingPriority = false;

  //* Getter y setter to _currentStep
  int get currentStep => _currentStep;
  set currentStep(int newValue){
    _currentStep = newValue;
    notifyListeners();
  }

  //* Getter y setter to _mediaData
  Map<String, dynamic> get mediaData => _mediaData;
  set mediaData(Map<String, dynamic> newData){
    _mediaData = newData;
    notifyListeners();
  }

  //* Getter y setter to _sagaData
  Map<String, dynamic> get sagaMedia => _sagaData;
  set sagaMedia(Map<String, dynamic> newData) {
    _sagaData = newData;
    notifyListeners();
  }

  //* Getter y setter to _type
  String get type => _type;
  set type(String newValue){
    _type = newValue;
    notifyListeners();
  }

  //* Getter y setter to _subtype
  String get subType => _subtype;
  set subType(String newValue){
    _subtype = newValue;
    notifyListeners();
  }

  //* Getter y setter to _shouldAddMoreInfo
  bool get shouldAddMoreInfo => _shouldAddMoreInfo;
  set shouldAddMoreInfo(bool newValue){
    _shouldAddMoreInfo = newValue;
    notifyListeners();
  }

  //* Getter y setter to _isPendingPriority
  bool get isPendingPriority => _isPendingPriority;
  set isPendingPriority(bool newValue){
    _isPendingPriority = newValue;
    notifyListeners();
  }

}