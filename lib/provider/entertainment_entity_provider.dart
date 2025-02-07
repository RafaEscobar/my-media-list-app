import 'package:flutter/material.dart';
import 'package:mymedialist/widgets/general/alert.dart';

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
  String _category = '';
  String _type = '';
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
  Map<String, dynamic> get sagaData => _sagaData;
  set sagaData(Map<String, dynamic> newData) {
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
  String get category => _category;
  set category(String newValue){
    _category = newValue;
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

  Future<bool> createMedia() async {
    try {
      /*
      Map<String, dynamic> body = _media.toJson();
      body['user_id'] = appProvider.userInfo.id;
      body['image'] = MultipartFile.fromFile(mediaImage.path, filename: "${title}_image");
      FormData formData = FormData.fromMap({
        ...body,
        'image': await MultipartFile.fromFile(
          mediaImage.path,
          filename: "${title}_image.jpg",
        ),
      });
      Response response = await ApiService.request(
        '/medias',
        auth: appProvider.userInfo.token,
        body: formData,
      );
      if (response.statusCode == 201) {
        _mediaId = response.data['data']['id'];
        return true;
      } else if (response.statusCode == 422) {
        Alert.show(text: response.statusMessage!);
      } else {
        Alert.show(text: "Error al intentar generar el registro, ${response.statusCode}");
      }
      return false;
      */
    } catch (e) {
      Alert.show(text: e.toString());
      throw Exception(e.toString());
    }
  }

  void deleteData(){
    _currentStep = 0;
    _mediaData = {
      "title": '',
      "score": '',
      "comment": '',
      "category_id": null,
      "status_id": null,
      "pending_priority_id": null,
      "post_view_priority_id": null,
      "image": ''
    };
    _sagaData = {
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
    _type = '';
    _subtype = '';
    _shouldAddMoreInfo = false;
    _isPendingPriority = false;
  }

}