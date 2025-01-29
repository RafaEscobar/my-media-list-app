import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mymedialist/main.dart';
import 'package:mymedialist/models/media.dart';
import 'package:mymedialist/models/status.dart';
import 'package:mymedialist/provider/app_provider.dart';
import 'package:mymedialist/services/api_service.dart';
import 'package:mymedialist/widgets/general/alert.dart';
import 'package:provider/provider.dart';


class MediaProvider extends ChangeNotifier{
  // Media list from API
  List<Media> _mediaList = [];
  // Variable to connect with AppProvider
  final AppProvider appProvider = navigatorKey.currentState!.context.read<AppProvider>();
  // Current step in process to create a media register
  int _currentStep = 0;

  //* Data to create a media register
  int? _categoryId;
  String? _type;
  String? _subtype;
  String _title = '';
  Status? _status;
  int? _priorityId;
  double? _score;
  String? _comment;

  //* General Getters and Setters
  List<Media> get mediaList => _mediaList;
  set mediaList(List<Media> newMediaList){
    _mediaList = newMediaList;
    notifyListeners();
  }
  int get currentStep => _currentStep;
  set currentStep(int newStep){
    _currentStep = newStep;
    notifyListeners();
  }

  //* Getters and Settets to create a media register
  int get categoryId => _categoryId!;
  set categoryId(int newCategoryId){
    _categoryId = newCategoryId;
    notifyListeners();
  }

  String get type => _type!;
  set type(String newValue){
    _type = newValue;
    notifyListeners();
  }

  String get subtype => _subtype!;
  set subtype(String newValue){
    _subtype = newValue;
    notifyListeners();
  }

  String get title => _title;
  set title(String newTitle){
    _title = newTitle;
    notifyListeners();
  }

  Status get status => _status!;
  set status(Status newStatus){
    _status = newStatus;
    notifyListeners();
  }

  int get priorityId => _priorityId!;
  set priorityId(int newPriorityId){
    _priorityId = newPriorityId;
    notifyListeners();
  }

  double get score => _score!;
  set score(double newScore){
    _score = newScore;
    notifyListeners();
  }

  String get comment => _comment!;
  set comment(String newComment) {
    _comment = newComment;
    notifyListeners();
  }

  Future<List<Media>> getMedia({ required int limit, required int page, int? categoryId } ) async {
    try {
      Response response = await ApiService.request('/medias?limit=$limit&page=$page&category_id=$categoryId', auth: appProvider.userInfo.token);
      if (response.statusCode == 200) {
        List<Media> mediaList = [];
        for( Map<String, dynamic> mediaJson in response.data['data'] ) {
          mediaList.add(Media.fromJson(mediaJson));
        }
        return mediaList;
      } else {
        Alert.show(text: 'Error al obtener el contenido.');
        throw Exception();
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

}