import 'package:flutter/material.dart';
import 'package:pokemon_project/constants/constants.dart';
import 'package:pokemon_project/widgets/input_widget.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  void _search(String value) {
    print(value);
  }

  void _reset() {
    print('reset');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Pokemon'),
      ),
      body: Column(
        children: [
          //TODO: one widget only for inputs??
          TextField(
            decoration: const InputDecoration(
              hintText: Label.inputHint,
              prefixIcon: Icon(Icons.search),
            ),
            textInputAction: TextInputAction.search,
            onChanged: _search,
          ),
          InputWidget(onSubmit: _search, onReset: _reset),
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

// void _search(String search) {
//   //TODO: devo paginare anche i risultati e non scaricarli tutti nel widget
//   setState(() {
//     _searchResult = _controller.search(search);
//   });
// }

// Widget result = SingleChildScrollView(
//   child: Column(
//     children: [
//       Text('${_searchResult.length} results:'),
//       ..._searchResult,
//     ],
//   ),
// );
