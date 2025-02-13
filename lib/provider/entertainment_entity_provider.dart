import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mymedialist/enum/type_enum.dart';
import 'package:mymedialist/main.dart';
import 'package:mymedialist/models/status.dart';
import 'package:mymedialist/provider/app_provider.dart';
import 'package:mymedialist/services/api_service.dart';
import 'package:provider/provider.dart';

class EntertainmentEntityProvider extends ChangeNotifier {
  // Current step in process to create a media register
  int _currentStep = 0;

  //* Data to create a media register
  Map<String, dynamic> _mediaData = {
    "title": '',
    "score": null,
    "comment": '',
    "category_id": null,
    "status_id": null,
    "pending_priority_id": null,
    "post_view_priority_id": null,
    "image": null,
    "user_id": navigatorKey.currentState!.context.read<AppProvider>().userInfo.id
  };

  //* Data to create a saga register
  Map<String, dynamic> _sagaData = {
    'title': '',
    'num_caps': 1,
    "score": null,
    'season': 1,
    'final_comment': '',
    'category_id': null,
    'status_id': null,
    'pending_priority_id': null,
    'post_view_priority_id': null,
    'image': null,
    "user_id": navigatorKey.currentState!.context.read<AppProvider>().userInfo.id
  };

  //* Important variables to the create flow
  String _category = '';
  String _type = '';
  bool _shouldAddMoreInfo = false;
  bool _isPendingPriority = false;
  File _temporaryImage = File('');
  Status _status = Status();

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

  //* Getter y setter to _temporaryImage
  File get temporaryImage => _temporaryImage;
  set temporaryImage(File newImage){
    _temporaryImage = newImage;
    notifyListeners();
  }

  //* Getter y setter to _status
  Status get status => _status;
  set status(Status newStatus){
    _status = newStatus;
    notifyListeners();
  }

  Future<int> createMedia(BuildContext context) async {
    Response response = await _sendRequest(context);
    if (context.mounted) return _handleResponse(response, context);
    throw Exception("Contexto no disponible");
  }

  Future<Response> _sendRequest(BuildContext context) async {
    AppProvider appProvider = context.read<AppProvider>();
    FormData formData = FormData.fromMap((_type == TypeEnum.media.name) ? mediaData : sagaData);
    return await ApiService.request(
      _type == TypeEnum.media.name ? '/medias' : '/sagas',
      auth: appProvider.userInfo.token,
      body: formData,
    );
  }

  int _handleResponse(Response response, BuildContext context){
    if (response.statusCode == 201) {
      return response.data['data']['id'];
    } else if (response.statusCode == 422) {
      throw Exception('La solicitud presenta errores, error: ${response.statusCode}');
    } else {
      throw Exception("Error al intentar generar el registro, ${response.statusCode}");
    }
  }

  void deleteData(){
    _currentStep = 0;
    _mediaData = {
      "title": '',
      "score": null,
      "comment": '',
      "category_id": null,
      "status_id": null,
      "pending_priority_id": null,
      "post_view_priority_id": null,
      "image": null,
      "user_id": navigatorKey.currentState!.context.read<AppProvider>().userInfo.id
    };
    _sagaData = {
      'title': '',
      'num_caps': 1,
      "score": null,
      'season': 1,
      'final_comment': '',
      'category_id': null,
      'status_id': null,
      'pending_priority_id': null,
      'post_view_priority_id': null,
      'image': null,
      "user_id": navigatorKey.currentState!.context.read<AppProvider>().userInfo.id
    };
    _type = '';
    _category = '';
    _shouldAddMoreInfo = false;
    _isPendingPriority = false;
    _temporaryImage = File('');
    _status = Status();
  }

}