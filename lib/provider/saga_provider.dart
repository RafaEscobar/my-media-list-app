import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mymedialist/main.dart';
import 'package:mymedialist/models/saga.dart';
import 'package:mymedialist/provider/app_provider.dart';
import 'package:mymedialist/services/api_service.dart';
import 'package:mymedialist/widgets/general/alert.dart';
import 'package:provider/provider.dart';

class SagaProvider extends ChangeNotifier{
  final AppProvider appProvider = navigatorKey.currentState!.context.read<AppProvider>();

  Future<List<Saga>> getSaga({ required int limit, required int page, int? categoryId } ) async {
    try {
      Response response = await ApiService.request('/sagas?limit=$limit&page=$page&category_id=$categoryId', auth: appProvider.userInfo.token);
      List<Saga> currentList = [];
      if (response.statusCode == 200) {
        for( Map<String, dynamic> sagaJson in response.data['data'] ) {
          currentList.add(Saga.fromJson(sagaJson));
        }
        return currentList;
      } else {
        Alert.show(text: 'Error al obtener el contenido.');
        throw Exception();
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}