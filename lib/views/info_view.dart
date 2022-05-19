import 'package:flutter/material.dart';
import 'package:pokemon_project/constants/constants.dart';
import 'package:pokemon_project/models/pokemon.dart';
import 'package:pokemon_project/widgets/sprite_widget.dart';
import 'package:pokemon_project/models/pokemon_info.dart';
import 'package:pokemon_project/widgets/stats_widget.dart';
import 'package:pokemon_project/services/api.dart';

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
      final PokemonInfo? result = await Api.getPokemonInfo(url: widget.pokemon.url);
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
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.pokemon.fullName),
              Text(widget.pokemon.hash),
            ],
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
                            if (_pokemon.sprite.front != null) SpriteWidget(url: _pokemon.sprite.front!),
                            if (_pokemon.sprite.back != null) SpriteWidget(url: _pokemon.sprite.back!),
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
