enum EUnit {
  g,
  ml
}

extension EUnitExtension on EUnit {

  String toShortString(){
    return this.toString().split('.').last;
  }

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
