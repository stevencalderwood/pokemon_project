import 'package:flutter/material.dart';
import 'package:pokemon_project/constants/constants.dart';
import 'package:pokemon_project/models/pokemon.dart';
import 'package:pokemon_project/controllers/controller.dart';

class InfoView extends StatefulWidget {
  final Pokemon pokemon;
  const InfoView({Key? key, required this.pokemon}) : super(key: key);

  @override
  State<InfoView> createState() => _InfoViewState();
}

class _InfoViewState extends State<InfoView> {
  bool _isLoading = true;
  late final String _error;
  late final PokemonInfo _pokemon;

  void _getPokemonInfo() async {
    final List result = await Service.getPokemonInfo(url: widget.pokemon.url);
    if (result.isNotEmpty) {
      _pokemon = result.first;
      _error = '';
    } else {
      _error = Constants.error;
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
              : _error != ''
                  ? Text(_error)
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Image.network(
                                  _pokemon.sprite.front,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              Expanded(
                                child: Image.network(
                                  _pokemon.sprite.back,
                                  fit: BoxFit.contain,
                                ),
                              ),
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
      ),
    );
  }
}
