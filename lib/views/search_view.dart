import 'package:flutter/material.dart';
import 'package:pokemon_project/constants/constants.dart';
import 'package:pokemon_project/controllers/controller.dart';
import 'package:pokemon_project/controllers/controller_json.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final ControllerJson _controller = Provider.json;
  late final ScrollController _scrollController;
  late final TextEditingController _txtController;
  List<Widget> _results = [];

  void _search(String value) {
    if (value == 'SCROLL') {
      _results.addAll(_controller.searchPokemon(value));
    } else {
      _results = _controller.searchPokemon(value);
    }
    setState(() {
      _results;
    });
  }

  void _scrollListener() {
    if (_scrollController.offset >= _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      _search('SCROLL');
    }
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    _txtController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.reset();
    _scrollController.dispose();
    _txtController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Search Pokemon'),
      ),
      body: Column(
        children: [
          TextField(
            decoration: const InputDecoration(
              hintText: Label.inputHint,
              prefixIcon: Icon(Icons.search),
            ),
            controller: _txtController,
            textInputAction: TextInputAction.search,
            onChanged: _search,
          ),
          // InputWidget(onSubmit: _search, onReset: _reset),
          Text('${_results.length} of ${_controller.results} results:'),
          Expanded(
            child: _results.isNotEmpty
                ? SingleChildScrollView(
                    controller: _scrollController,
                    child: Column(
                      children: _results,
                    ),
                  )
                : const Center(),
          ),
        ],
      ),
    );
  }
}

// void _search(String search) async {
//   //TODO: mostruisità
//   if (_isLoading) {
//     return;
//   }
//   setState(() {
//     _isLoading = true;
//   });
//   final List<Widget> memoryResult = _controller.search(search);
//   if (memoryResult.isNotEmpty) {
//     _searchResult = [Column(children: memoryResult)];
//   } else {
//     final String url = '${Constant.pokemonAPI}$search';
//     final PokemonInfo? result = await Controller.getPokemonInfo(url: url);
//     if (result == null) {
//       _searchResult = [const Center(child: Text('No pokemon found'))];
//     } else {
//       final Pokemon pokemon = Pokemon(name: result.name, url: '${Constant.pokemonAPI}${result.id}');
//       _searchResult = [
//         Column(children: [CardWidget(pokemon: pokemon, pokemonInfo: result)]),
//       ];
//     }
//   }
//   setState(() {
//     _isLoading = false;
//   });
// }
//
// void _reset() {
//   setState(() => _searchResult = []);
// }
