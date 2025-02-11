import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mymedialist/enum/type_enum.dart';
import 'package:mymedialist/main.dart';
import 'package:mymedialist/models/status.dart';
import 'package:mymedialist/provider/app_provider.dart';
import 'package:mymedialist/screens/main/details_screens.dart';
import 'package:mymedialist/services/api_service.dart';
import 'package:mymedialist/utils/redirect.dart';
import 'package:mymedialist/widgets/general/alert.dart';
import 'package:provider/provider.dart';

class EntertainmentEntityProvider extends ChangeNotifier {
  // Current step in process to create a media register
  int _currentStep = 0;

  //* Data to create a media register
  Map<String, dynamic> _mediaData = {
    "title": '',
    "score": 5,
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
    'num_caps': null,
    'season': null,
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

  Future<void> createMedia(BuildContext context) async {
    try {
      Response response = await _sendRequest(context);
      if (context.mounted) _handleResponse(response, context);
    } catch (e) {
      Alert.show(text: e.toString());
      throw Exception(e.toString());
    }
  }

  Future<Response> _sendRequest(BuildContext context) async {
    AppProvider appProvider = context.read<AppProvider>();
    FormData formData = FormData.fromMap((_type == TypeEnum.media.name) ? mediaData : sagaData);
    return await ApiService.request(
      '/medias',
      auth: appProvider.userInfo.token,
      body: formData,
    );
  }

  void _handleResponse(Response response, BuildContext context){
    if (response.statusCode == 201) {
      if (context.mounted) Redirect.redirectWithLoader(DetailsScreens.routeName, context, params: {'entityId': response.data['data']['id']});
    } else if (response.statusCode == 422) {
      Alert.show(text: response.statusMessage!);
    } else {
      Alert.show(text: "Error al intentar generar el registro, ${response.statusCode}");
    }
  }

  void deleteData(){
    _currentStep = 0;
    _mediaData = {
      'title': '',
      'num_caps': null,
      'season': null,
      'final_comment': '',
      'category_id': null,
      'status_id': null,
      'pending_priority_id': null,
      'post_view_priority_id': null,
      'image': null,
      "user_id": navigatorKey.currentState!.context.read<AppProvider>()
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
    _category = '';
    _shouldAddMoreInfo = false;
    _isPendingPriority = false;
    temporaryImage = File('');
  }

}