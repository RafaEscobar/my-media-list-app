import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mymedialist/main.dart';
import 'package:mymedialist/models/entity.dart';
import 'package:mymedialist/provider/app_provider.dart';
import 'package:mymedialist/services/api_service.dart';
import 'package:mymedialist/widgets/general/alert.dart';
import 'package:provider/provider.dart';


class MediaProvider extends ChangeNotifier{
  // Variable to connect with AppProvider
  final AppProvider appProvider = navigatorKey.currentState!.context.read<AppProvider>();

  Future<List<Entity>> getMedia({ required int limit, required int page, int? categoryId } ) async {
    try {
      Response response = await ApiService.request('/medias?limit=$limit&page=$page&category_id=$categoryId', auth: appProvider.userInfo.token);
      if (response.statusCode == 200) {
        List<Entity> mediaList = [];
        mediaList.clear();
        for( Map<String, dynamic> mediaJson in response.data['data'] ) {
          mediaList.add(Entity.fromJson(mediaJson));
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