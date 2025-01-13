import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mymedialist/main.dart';
import 'package:mymedialist/models/media.dart';
import 'package:mymedialist/provider/app_provider.dart';
import 'package:mymedialist/services/api_service.dart';
import 'package:mymedialist/widgets/general/alert.dart';
import 'package:provider/provider.dart';


class MediaProvider extends ChangeNotifier{
  List<Media> _mediaList = [];
  final AppProvider appProvider = navigatorKey.currentState!.context.read<AppProvider>();

  List<Media> get mediaList => _mediaList;
  set mediaList(List<Media> newMediaList){
    _mediaList = newMediaList;
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