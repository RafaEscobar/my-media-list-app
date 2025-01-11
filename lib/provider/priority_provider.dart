import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';
import 'package:mymedialist/main.dart';
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

  Future<bool> getPriorities(int limit) async { // Responderemos con la data
    try {
      String token = navigatorKey.currentState!.context.read<AppProvider>().userInfo.token;
      Response response = await ApiService.request('/priorities', auth: token);
      if (response.statusCode == 200) {
        List<dynamic> nose = response.data;
        print(nose);
        return true;
      }
      return false;
    } catch (e) {
      return true;
    }
  }

}