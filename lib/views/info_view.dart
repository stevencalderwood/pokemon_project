import 'package:flutter/material.dart';
import 'package:pokemon_project/constants/constants.dart';
import 'package:pokemon_project/models/pokemon.dart';
import 'package:pokemon_project/controllers/controller.dart';
import 'package:pokemon_project/widgets/image.dart';

class InfoView extends StatefulWidget {
  final Pokemon pokemon;
  final PokemonInfo? pokemonInfo;
  const InfoView({Key? key, required this.pokemon, this.pokemonInfo}) : super(key: key);

  @override
  State<InfoView> createState() => _InfoViewState();
}

class _InfoViewState extends State<InfoView> {
  bool _isLoading = true;
  bool _error = false;
  late final PokemonInfo _pokemon;

  void _getPokemonInfo() async {
    if (widget.pokemonInfo == null) {
      final PokemonInfo? result = await Controller.getPokemonInfo(url: widget.pokemon.url);
      if (result != null) {
        _pokemon = result;
      } else {
        _error = true;
      }
    } else {
      _pokemon = widget.pokemonInfo!.copyWith();
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    _getPokemonInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.pokemon.name),
        ),
        body: Center(
          child: _isLoading
              ? const CircularProgressIndicator()
              : _error
                  ? const Text(Label.error)
                  : Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SpriteWidget(url: _pokemon.sprite.front),
                            SpriteWidget(url: _pokemon.sprite.back),
                          ],
                        ),
                        Text('NAME: ${_pokemon.name}'),
                        Text('ID: ${_pokemon.id}'),
                        Text('HEIGHT: ${_pokemon.height}'),
                        Text('WEIGHT: ${_pokemon.weight}'),
                        Text('TYPES: ${_pokemon.types}'),
                      ],
                    ),
        ),
      ),
    );
  }
}
