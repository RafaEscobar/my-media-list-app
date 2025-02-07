enum TypeEnum {
  saga,
  media
}

extension TypeEnumExtension on TypeEnum {
  String get name {
    switch (this) {
      case TypeEnum.saga:
        return "Saga"  ;
      case TypeEnum.media:
        return "Media";
    }
  }
}