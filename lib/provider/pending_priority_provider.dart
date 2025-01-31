import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:mymedialist/main.dart';
import 'package:mymedialist/models/priority.dart';
import 'package:mymedialist/provider/app_provider.dart';
import 'package:mymedialist/services/api_service.dart';
import 'package:mymedialist/utils/redirect.dart';
import 'package:mymedialist/widgets/general/alert.dart';
import 'package:provider/provider.dart';

class PendingPriorityProvider extends ChangeNotifier{
  final List<Priority> _pendingPriorityList = [];

  List<Priority> get pendingPriorityList => _pendingPriorityList;

  Future<void> getPendingPriorities() async {
    try {
      Response response = await ApiService.request('/pending-priorities', auth: navigatorKey.currentState!.context.read<AppProvider>().userInfo.token);
      if (response.statusCode == 200) {
        for(Map<String, dynamic> priority in response.data['data']){
          _pendingPriorityList.add(Priority.fromJson(priority));
        }
      } else if (response.statusCode == 401) {
        Redirect.onUnauthorized();
      } else {
        Alert.show(text: 'Error al obtener pending_priorities ${response.statusCode}');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

}