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
        return "Películas"  ;
      case CategoryEnum.series:
        return "Series";
      case CategoryEnum.mangas:
        return "Mangas";
      case CategoryEnum.videogames:
        return "Videojuegos";
      case CategoryEnum.animes:
        return "Animes";
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