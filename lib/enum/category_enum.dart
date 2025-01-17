enum CategoryEnum {
  movies,
  series,
  mangas,
  videogames,
  animes
}

extension CategoryEnumExtension on CategoryEnum{
  String get name {
    switch (this) {
      case CategoryEnum.movies:
        return "película"  ;
      case CategoryEnum.series:
        return "serie";
      case CategoryEnum.mangas:
        return "manga";
      case CategoryEnum.videogames:
        return "videojuego";
      case CategoryEnum.animes:
        return "anime";
    }
  }

  int get identifier {
    switch (this) {
      case CategoryEnum.movies:
        return 1;
      case CategoryEnum.series:
        return 2;
      case CategoryEnum.mangas:
        return 3;
      case CategoryEnum.videogames:
        return 4;
      case CategoryEnum.animes:
        return 5;
    }
  }
}