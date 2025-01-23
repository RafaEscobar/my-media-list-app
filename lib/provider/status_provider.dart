import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:mymedialist/main.dart';
import 'package:mymedialist/models/status.dart';
import 'package:mymedialist/provider/app_provider.dart';
import 'package:mymedialist/services/api_service.dart';
import 'package:mymedialist/utils/redirect.dart';
import 'package:mymedialist/widgets/general/alert.dart';
import 'package:provider/provider.dart';

class StatusProvider extends ChangeNotifier {
  final AppProvider _appProvider = navigatorKey.currentState!.context.read<AppProvider>();
  List<Status> statusList = [];

  Future<void> getStatusList() async {
    try {
      Response response = await ApiService.request('/statuses', auth: _appProvider.userInfo.token);
      if (response.statusCode == 200) {
        statusList = [];
        for(Map<String, dynamic> status in response.data['data']){
          statusList.add(Status.fromJson(status));
        }
      } else if(response.statusCode == 401){
        Redirect.onUnauthorized();
      } else {
        Alert.show(text: "Error al obtener la lista de estatus: ${response.statusCode}");
      }
    } catch (e) {
      Alert.show(text: e.toString());
      throw Exception("Error al obtener la lista de estatus");
    }
  }
}