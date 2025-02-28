import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mymedialist/main.dart';
import 'package:mymedialist/models/entity.dart';
import 'package:mymedialist/models/saga.dart';
import 'package:mymedialist/provider/app_provider.dart';
import 'package:mymedialist/services/api_service.dart';
import 'package:provider/provider.dart';

class RankingProvider extends ChangeNotifier{
  final AppProvider appProvider = navigatorKey.currentState!.context.read<AppProvider>();
  List<Saga> _animeList = [];
  List<Saga> _mangaList = [];
  List<Saga> _serieList = [];
  List<Entity> _movieList = [];
  List<Entity> _gameList = [];

  List<Saga> get animeList => _animeList;
  set animeList(List<Saga> newList){
    _animeList = newList;
    notifyListeners();
  }

  List<Saga> get mangaList => _mangaList;
  set mangaList(List<Saga> newList){
    _mangaList = newList;
    notifyListeners();
  }

  List<Saga> get serieList => _serieList;
  set serieList(List<Saga> newList){
    _serieList = newList;
    notifyListeners();
  }

  List<Entity> get movieList => _movieList;
  set movieList(List<Entity> newList){
    _movieList = newList;
    notifyListeners();
  }

  List<Entity> get gameList => _gameList;
  set gameList(List<Entity> newList){
    _gameList = newList;
    notifyListeners();
  }

  Future<void> getRankings({ int categoryId = 0 }) async {
    try {
      Response response = await ApiService.request(categoryId == 0 ? "/ranking" : "/ranking/$categoryId", auth: appProvider.userInfo.token);
      if (response.statusCode == 200) {
        (categoryId==0) ? _saveLists(response.data) : null;
      }
      throw "${response.statusCode}: ${response.data['data']['message']}";
    } catch (e) {
      throw e.toString();
    }
  }

  void _saveLists(Map<String, dynamic> data) {
    animeList = (data['animes']['data'] as List).map((anime) => Saga.fromJson(anime)).toList();
    mangaList = (data['mangas']['data'] as List).map((manga) => Saga.fromJson(manga)).toList();
    serieList = (data['series']['data'] as List).map((serie) => Saga.fromJson(serie)).toList();
    movieList = (data['movies']['data'] as List).map((movie) => Entity.fromJson(movie)).toList();
    gameList = (data['games']['data'] as List).map((game) => Entity.fromJson(game)).toList();
  }


}