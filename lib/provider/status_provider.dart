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
          status['iconPath'] = addIconPath(status['status']);
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

  String addIconPath(String status){
    switch (status) {
      case 'Pendiente':
        return "assets/icons/pending.png";
      case 'Visto':
        return "assets/icons/check.png";
      case 'Declinado':
        return "assets/icons/bad.png";
      case 'No terminado':
        return "assets/icons/dislike.png";
      case 'En emisión':
        return "assets/icons/now.png";
      default:
        return '';
    }
  }
}