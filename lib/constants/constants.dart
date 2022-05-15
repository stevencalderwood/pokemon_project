abstract class Constants {
  static const String allPokemonAPI = 'https://pokeapi.co/api/v2/pokemon/';
  static const String error = 'There was a problem. Please try later';

  /// length: >= 3
  ///
  /// char: a-z and hyphen (-)
  ///
  /// constraints: hyphen is not allowed in first or last postion
  static const String regex = r'^(?!-|.*-$)[a-z-]{3,}';
}
