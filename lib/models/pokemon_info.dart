import 'package:pokemon_project/models/pokemon.dart';
import 'package:pokemon_project/models/sprite.dart';
import 'package:pokemon_project/constants/constants.dart';

class PokemonInfo {
  final int _id;
  final String _name;
  final int _height;
  final int _weight;
  final List<String> _type;
  final List<String> _abilities;
  final Sprite sprite;

  const PokemonInfo({
    required int id,
    required String name,
    required int height,
    required int weight,
    required List<String> type,
    required List<String> abilities,
    required this.sprite,
  })  : _id = id,
        _name = name,
        _height = height,
        _weight = weight,
        _abilities = abilities,
        _type = type;

  factory PokemonInfo.fromJson(Map<String, dynamic> json) {
    return PokemonInfo(
      id: json['id'] as int,
      name: json['name'] as String,
      height: json['height'] as int,
      weight: json['weight'] as int,
      type: json['types'].map<String>((e) => e['type']['name'] as String).toList(growable: false),
      abilities: json['abilities'].map<String>((e) => e['ability']['name'] as String).toList(growable: false),
      sprite: Sprite.fromJson(json['sprites'] as Map<String, dynamic>),
    );
  }

  PokemonInfo copyWith({
    int? id,
    String? name,
    int? height,
    int? weight,
    List<String>? type,
    List<String>? abilities,
    Sprite? sprite,
  }) {
    return PokemonInfo(
      id: id ?? _id,
      name: name ?? _name,
      height: height ?? _height,
      weight: weight ?? _weight,
      type: type ?? _type.toList(growable: false),
      abilities: abilities ?? _abilities.toList(growable: false),
      sprite: sprite ?? this.sprite.copyWith(),
    );
  }

  Pokemon subCopy() => Pokemon(name: _name, url: '${Constant.pokemonAPI}$_id');

  String get id => '#$_id';
  String get name => '${_name[0].toUpperCase()}${_name.substring(1)}';
  String get height => '${(_height / 10).toStringAsFixed(1)} m';
  String get weight => '${(_weight / 10).toStringAsFixed(1)} kg';
  String get type => _type.join('\n');
  String get abilities => _abilities.join('\n');

  @override
  String toString() {
    return 'PokemonInfo(id: $_id, name: $_name, height: $_height, weight: $_weight, type: $_type, abilities: '
        '$_abilities, sprite: $sprite)';
  }
}
