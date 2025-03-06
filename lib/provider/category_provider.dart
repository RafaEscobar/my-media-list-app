import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:mymedialist/main.dart';
import 'package:mymedialist/models/category_model.dart';
import 'package:mymedialist/provider/app_provider.dart';
import 'package:mymedialist/services/api_service.dart';
import 'package:mymedialist/utils/redirect.dart';
import 'package:mymedialist/widgets/general/alert.dart';
import 'package:provider/provider.dart';

class CategoryProvider extends ChangeNotifier{
  final AppProvider _appProvider = navigatorKey.currentState!.context.read<AppProvider>();
  List<CategoryModel> _categoryList = [];

  List<CategoryModel> get categoryList => _categoryList;
  set categoryList(List<CategoryModel> newList){
    _categoryList = newList;
    notifyListeners();
  }

  Future<void> getCategories() async {
    try {
      Response response = await ApiService.request('/categories', auth: _appProvider.userInfo.token);
      if (response.statusCode == 200) {
        for(Map<String, dynamic> category in response.data['data']){
          categoryList.add( CategoryModel.fromJson(category) );
        }
      } else if(response.statusCode == 401) {
        Redirect.onUnauthorized();
      } else {
        Alert.show(text: "Error al obtener listado de categorias ${response.statusCode}");
        throw Exception("Error al obtener listado de categorias");
      }
    } catch (e) {
      Alert.show(text: e.toString());
      throw Exception("Error al obtener listado de categorias");
    }
  }
}