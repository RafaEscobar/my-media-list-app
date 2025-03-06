import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:mymedialist/main.dart';
import 'package:mymedialist/models/priority.dart';
import 'package:mymedialist/provider/app_provider.dart';
import 'package:mymedialist/services/api_service.dart';
import 'package:mymedialist/utils/redirect.dart';
import 'package:mymedialist/widgets/general/alert.dart';
import 'package:provider/provider.dart';

class PostViewPriorityProvider extends ChangeNotifier{
  final List<Priority> _postViewPriorityList = [];

  List<Priority> get postViewPriorityList => _postViewPriorityList;

  Future<void> getPostViewPriorities() async {
    try {
      Response response = await ApiService.request('/post-view-priorities', auth: navigatorKey.currentState!.context.read<AppProvider>().userInfo.token);
      if (response.statusCode == 200) {
        for (Map<String, dynamic> priority in response.data['data']) {
          _postViewPriorityList.add(Priority.fromJson(priority));
        }
      } else if (response.statusCode == 401) {
        Redirect.onUnauthorized();
      } else {
        Alert.show(text: "Error al obtener post_view_priorities ${response.statusCode}");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}