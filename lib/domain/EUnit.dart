enum EUnit {
  g,
  ml
}

extension EUnitExtension on EUnit {
  static EUnit fromString(String value) {
    switch (value.toLowerCase()) {
      case 'g':
        return EUnit.g;
      case 'ml':
        return EUnit.ml;
      default:
        return EUnit.g;
    }
  }
}
