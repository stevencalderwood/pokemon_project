import 'package:flutter/material.dart';
import 'package:pokemon_project/constants/constants.dart';
import 'package:pokemon_project/controllers/controller.dart';
import 'package:pokemon_project/models/pokemon.dart';
import 'package:pokemon_project/widgets/card.dart';
import 'package:pokemon_project/widgets/input.dart';
import 'package:pokemon_project/controllers/controller_api.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final ScrollController _scrollController;
  late final ControllerApi _controller;
  final List<Widget> _pokemonWidgets = [];
  bool _isLoading = true;
  List<Widget> _searchResult = [];

  Future<void> _getPokemon() async {
    List<Widget> result = await _controller.getPokemon();
    _isLoading = false;
    if (result.isEmpty) {
      _scrollController.removeListener(_scrollListener);
      return;
    }
    setState(() {
      _pokemonWidgets.addAll(result);
    });
  }

  void _scrollListener() async {
    if (_scrollController.offset >= _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      await _getPokemon();
    }
  }

  void _search(String search) async {
    //TODO: mostruisità
    if (_isLoading) {
      return;
    }
    setState(() {
      _isLoading = true;
    });
    final List<Widget> memoryResult = _controller.search(search);
    if (memoryResult.isNotEmpty) {
      _searchResult = [Column(children: memoryResult)];
    } else {
      final String url = '${Constant.pokemonAPI}$search';
      final PokemonInfo? result = await Controller.getPokemonInfo(url: url);
      if (result == null) {
        _searchResult = [const Center(child: Text('No pokemon found'))];
      } else {
        final Pokemon pokemon = Pokemon(name: result.name, url: '${Constant.pokemonAPI}${result.id}');
        _searchResult = [
          Column(children: [PokeCard(pokemon: pokemon, pokemonInfo: result)]),
        ];
      }
    }
    setState(() {
      _isLoading = false;
    });
  }

  void _reset() {
    setState(() => _searchResult = []);
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    _controller = ControllerApi();
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
          title: PopupMenuButton<int>(
            position: PopupMenuPosition.under,
            onSelected: (value) {
              Navigator.pushNamed(context, '/v2/');
            },
            itemBuilder: (context) {
              return const [
                PopupMenuItem<int>(
                  value: 0,
                  child: Text(Label.titleSecond),
                ),
              ];
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text(Label.titleHome),
                Icon(Icons.arrow_drop_down),
              ],
            ),
          ),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.info_outline)),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: InputField(onSubmit: _search, onReset: _reset),
            ),
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _searchResult.isEmpty
                      ? SingleChildScrollView(
                          controller: _scrollController,
                          child: Column(children: _pokemonWidgets),
                        )
                      : _searchResult.first,
            ),
          ],
        ),
      ),
    );
  }
}
