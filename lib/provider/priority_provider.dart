import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'package:mymedialist/main.dart';
import 'package:mymedialist/models/priority.dart';
import 'package:mymedialist/provider/app_provider.dart';
import 'package:mymedialist/services/api_service.dart';
import 'package:provider/provider.dart';

class PriorityProvider extends ChangeNotifier{
  List<Priority> _priorityList = [];

  List<Priority> get priorityList => _priorityList;
  set priorityList(List<Priority> newList) {
    _priorityList = newList;
    notifyListeners();
  }

  Future<List<Priority>> getPriorities({required int limit, required int page}) async {
    try {
      String token = navigatorKey.currentState!.context.read<AppProvider>().userInfo.token;
      Response response = await ApiService.request('/priorities?per_page=$limit&page=$page', auth: token);
      if (response.statusCode == 200) {
        List<Priority> priorityList = [];
        for(Map<String, dynamic> priority in response.data['data']){
          priorityList.add(Priority.fromJson(priority));
        }
        return priorityList;
      } else {
        throw Exception('Erro al obtener la lista de prioridades');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

}