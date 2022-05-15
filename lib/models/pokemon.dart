import 'package:pokemon_project/models/sprite.dart';

class Pokemon {
  final String name;
  final String url;
  const Pokemon({required this.name, required this.url});

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      name: json['name'] as String,
      url: json['url'] as String,
    );
  }

  String get id => url.split('/')[6];

  Pokemon copyWith({String? name, String? url}) {
    return Pokemon(
      name: name ?? this.name,
      url: url ?? this.url,
    );
  }

  @override
  toString() => '{name: $name, url: $url}';
}

class PokemonInfo {
  final int id;
  final String name;
  final int height;
  final int weight;
  final Sprite sprite;
  //TODO: attualmente la lista è modificabile se la classe è istanziata tramite il suo construttore
  final List<String> types;

  const PokemonInfo({
    required this.id,
    required this.name,
    required this.height,
    required this.weight,
    required this.types,
    required this.sprite,
  });

  factory PokemonInfo.fromJson(Map<String, dynamic> json) {
    return PokemonInfo(
      id: json['id'] as int,
      name: json['name'] as String,
      height: json['height'] as int,
      weight: json['weight'] as int,
      types: json['types'].map<String>((e) => e['type']['name'] as String).toList(growable: false),
      sprite: Sprite.fromJson(json['sprites'] as Map<String, dynamic>),
    );
  }

  PokemonInfo copyWith({int? id, String? name, int? height, int? weight, Sprite? sprite, List<String>? types}) {
    return PokemonInfo(
      id: id ?? this.id,
      name: name ?? this.name,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      sprite: sprite ?? this.sprite.copyWith(),
      types: types ?? this.types.toList(growable: false),
    );
  }

  @override
  String toString() {
    return '{id: $id, name: $name, height: $height, weight: $weight, types: $types, sprite: $sprite}';
  }
}
