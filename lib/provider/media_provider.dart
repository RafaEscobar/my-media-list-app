import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mymedialist/main.dart';
import 'package:mymedialist/models/entity.dart';
import 'package:mymedialist/provider/app_provider.dart';
import 'package:mymedialist/services/api_service.dart';
import 'package:mymedialist/widgets/general/alert.dart';
import 'package:provider/provider.dart';


class MediaProvider extends ChangeNotifier{
  // Media list from API
  List<Entity> _mediaList = [];
  // Variable to connect with AppProvider
  final AppProvider appProvider = navigatorKey.currentState!.context.read<AppProvider>();

  //* General Getters and Setters
  List<Entity> get mediaList => _mediaList;
  set mediaList(List<Entity> newMediaList){
    _mediaList = newMediaList;
    notifyListeners();
  }

  Future<void> getMedia({ required int limit, required int page, int? categoryId } ) async {
    try {
      _cleanList();
      Response response = await ApiService.request('/medias?limit=$limit&page=$page&category_id=$categoryId', auth: appProvider.userInfo.token);
      if (response.statusCode == 200) {
        for( Map<String, dynamic> mediaJson in response.data['data'] ) {
          mediaList.add(Entity.fromJson(mediaJson));
        }
      } else {
        Alert.show(text: 'Error al obtener el contenido.');
        throw Exception();
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  void _cleanList() => mediaList = [];
}