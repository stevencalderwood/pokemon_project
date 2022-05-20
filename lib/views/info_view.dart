import 'package:flutter/material.dart';
import 'package:pokemon_project/constants/constants.dart';
import 'package:pokemon_project/models/pokemon.dart';
import 'package:pokemon_project/widgets/loading_widget.dart';
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
    setState(() => _isLoading = false);
    try {
      _pokemon = (widget.pokemonInfo?.copyWith() ?? await Api.getPokemonInfo(url: widget.pokemon.url))!;
    } catch (e) {
      // catching the null check operator used on a null value if the API also fails
      _error = true;
    }
    setState(() => _isLoading = false);
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
        body: _isLoading
            ? const LoadingWidget()
            : _error
                ? const Text(Label.error)
                : ListView(
                    children: [
                      SpriteWidget(sprite: _pokemon.sprite),
                      StatsWidget(title: 'Type', value: _pokemon.type),
                      StatsWidget(title: 'Abilities', value: _pokemon.abilities),
                      StatsWidget(title: 'Height', value: _pokemon.height),
                      StatsWidget(title: 'Weight', value: _pokemon.weight),
                    ],
                  ),
      ),
    );
  }
}
