import 'package:flutter/material.dart';
import 'package:pokemon_project/constants/constants.dart';
import 'package:pokemon_project/models/pokemon.dart';
import 'package:pokemon_project/controllers/controller.dart';
import 'package:pokemon_project/widgets/sprite_widget.dart';
import 'package:pokemon_project/models/pokemon_info.dart';
import 'package:pokemon_project/widgets/stats_widget.dart';

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
          title: _isLoading
              ? const Text('...')
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text(_pokemon.name), Text(_pokemon.id)],
                ),
        ),
        body: Center(
          child: _isLoading
              ? const CircularProgressIndicator()
              : _error
                  ? const Text(Label.error)
                  : ListView(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SpriteWidget(url: _pokemon.sprite.front),
                            SpriteWidget(url: _pokemon.sprite.back),
                          ],
                        ),
                        StatsWidget(title: 'Type', value: _pokemon.type),
                        StatsWidget(title: 'Abilities', value: _pokemon.abilities),
                        StatsWidget(title: 'Height', value: _pokemon.height),
                        StatsWidget(title: 'Weight', value: _pokemon.weight),
                      ],
                    ),
        ),
      ),
    );
  }
}
