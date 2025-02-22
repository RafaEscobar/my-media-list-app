import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mymedialist/main.dart';
import 'package:mymedialist/models/saga.dart';
import 'package:mymedialist/provider/app_provider.dart';
import 'package:mymedialist/services/api_service.dart';
import 'package:mymedialist/widgets/general/alert.dart';
import 'package:provider/provider.dart';

class SagaProvider extends ChangeNotifier{
  List<Saga> _sagaList = [];
  final AppProvider appProvider = navigatorKey.currentState!.context.read<AppProvider>();

  //* General Getters and Setters
  List<Saga> get sagaList => _sagaList;
  set sagaList(List<Saga> newSagaList){
    _sagaList = newSagaList;
    notifyListeners();
  }

  Future<List<Saga>> getSaga({ required int limit, required int page, int? categoryId } ) async {
    try {
      Response response = await ApiService.request('/sagas?limit=$limit&page=$page&category_id=$categoryId', auth: appProvider.userInfo.token);
      if (response.statusCode == 200) {
        sagaList.clear();
        for( Map<String, dynamic> sagaJson in response.data['data'] ) {
          sagaList.add(Saga.fromJson(sagaJson));
        }
        return sagaList;
      } else {
        Alert.show(text: 'Error al obtener el contenido.');
        throw Exception();
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}