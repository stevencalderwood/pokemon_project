abstract class Constant {
  static const String pokemonAPI = 'https://pokeapi.co/api/v2/pokemon/';
  static const int pokemonMin = 1;
  static const int pokemonMax = 898;

  /// length: >= 3
  ///
  /// char: a-z and hyphen (-)
  ///
  /// constraints: hyphen is not allowed in first or last postion
  static const String regex = r'^(?!-|.*-$)[a-z-]{3,}';
}

abstract class Label {
  static const String error = 'There was a problem. Please try later';
  static const String invalidID = 'Invalid Id';
  static const String invalidName = 'Invalid name';
  static const String titleHome = 'Pokemon Project 1';
  static const String titleSecond = 'Pokemon Project 2';
  static const String inputHint = 'Insert pokemon name or id';
}
