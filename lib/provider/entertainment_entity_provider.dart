import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mymedialist/enum/type_enum.dart';
import 'package:mymedialist/main.dart';
import 'package:mymedialist/models/entity.dart';
import 'package:mymedialist/models/saga.dart';
import 'package:mymedialist/models/status.dart';
import 'package:mymedialist/provider/app_provider.dart';
import 'package:mymedialist/services/api_service.dart';
import 'package:provider/provider.dart';

class EntertainmentEntityProvider extends ChangeNotifier {
  // Current step in process to create a media register
  int _currentStep = 0;

  //* Data to create a media register
  Map<String, dynamic> _mediaData = {"user_id": navigatorKey.currentState!.context.read<AppProvider>().userInfo.id};

  //* Data to create a saga register
  Map<String, dynamic> _sagaData = {
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

  Future<Entity> createMedia(BuildContext context) async {
    try {
      Response response = await _sendRequest(context);
      if (context.mounted) return _handleResponse(response, context);
      throw Exception("Error de contexto");
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Response> _sendRequest(BuildContext context) async {
    FormData formData = FormData.fromMap((_type == TypeEnum.media.name) ? mediaData : sagaData);
    return await ApiService.request(
      _type == TypeEnum.media.name ? '/medias' : '/sagas',
      auth: context.read<AppProvider>().userInfo.token,
      body: formData,
    );
  }

  Entity _handleResponse(Response response, BuildContext context){
    if (response.statusCode == 201) {
      return (type == TypeEnum.media.name) ? Entity.fromJson(response.data["data"]) : Saga.fromJson(response.data["data"]);
    } else if (response.statusCode == 422) {
      throw Exception('La solicitud presenta errores, error: ${response.statusCode}');
    } else {
      throw Exception("Error al intentar generar el registro, ${response.statusCode}");
    }
  }

  void deleteData(){
    _currentStep = 0;
    _mediaData = {"user_id": navigatorKey.currentState!.context.read<AppProvider>().userInfo.id};
    _sagaData = {"user_id": navigatorKey.currentState!.context.read<AppProvider>().userInfo.id};
    _type = '';
    _category = '';
    _shouldAddMoreInfo = false;
    _isPendingPriority = false;
    _temporaryImage = File('');
    _status = Status();
  }

}