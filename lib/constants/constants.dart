abstract class Constant {
  static const String pokemonAPI = 'https://pokeapi.co/api/v2/pokemon/';
  static const int pokemonMin = 1;
  static const int pokemonMax = 898;

  /// length: >= 3
  ///
  /// char: a-z and hyphen (-)
  ///
  /// constraints: hyphen is not allowed in first or last position
  static const String regex = r'^(?!-|.*-$)[a-z-]{3,}';
  static const String jsonPath = 'data/pokemon_data.json';
}

abstract class Label {
  static const String appName = 'Pokemon API Project';
  static const String error = 'There was a problem. Please try later';
  static const String invalidId = 'Invalid Id';
  static const String invalidName = 'Invalid name';
  static const String titleHome = 'Pokemon Project 1';
  static const String titleSecond = 'Pokemon Project 2';
  static const String titleSearch = 'Search Pokemon';
  static const String inputHint = 'Please insert name or ID (1-898)';
  static const String pokemonNotFound = 'No pokemon was found';
  static const String maybeLookingFor = 'Maybe you were looking for...';
  static String resultsNumber({required int displayed, required int total}) => '$displayed of $total results';
}
