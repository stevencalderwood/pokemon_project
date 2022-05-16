import 'package:flutter/material.dart';
import 'package:pokemon_project/constants/constants.dart';
import 'package:pokemon_project/controllers/controller.dart';
import 'package:pokemon_project/widgets/input.dart';

class SecondView extends StatefulWidget {
  const SecondView({Key? key}) : super(key: key);

  @override
  State<SecondView> createState() => _SecondViewState();
}

class _SecondViewState extends State<SecondView> {
  late final ScrollController _scrollController;
  late final Service _controller;
  final List<Widget> _pokemonToDisplay = [];
  List<Widget> _filteredPokemon = [];

  Future<void> _getPokemon() async {
    List<Widget> result = await _controller.getPokemon();
    if (result.isEmpty) {
      _scrollController.removeListener(_scrollListener);
      return;
    }
    setState(() {
      _pokemonToDisplay.addAll(result);
    });
  }

  void _scrollListener() async {
    if (_scrollController.offset >= _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      await _getPokemon();
    }
  }

  void _search(String search) {
    final String url = 'https://pokeapi.co/api/v2/pokemon/$search';
    print(url);
    // TODO: ora che abbiamo l'url possiamo fare richiesta get e gestire errore "not found"
  }

  void reset() {}

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    _controller = Controller.home;
    _getPokemon();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text(Label.titleSecond),
        ),
        body: Column(
          children: [
            InputField(onSubmit: _search, onReset: reset),
            Expanded(
              child: _filteredPokemon.isEmpty
                  ? SingleChildScrollView(
                      controller: _scrollController,
                      padding: const EdgeInsets.only(top: 10),
                      child: Column(
                        children: [..._pokemonToDisplay],
                      ),
                    )
                  : SingleChildScrollView(
                      padding: const EdgeInsets.only(top: 10),
                      child: Column(
                        children: [
                          Text('${_filteredPokemon.length} results:'),
                          ..._filteredPokemon,
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
