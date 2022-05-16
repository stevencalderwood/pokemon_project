import 'package:flutter/material.dart';
import 'package:pokemon_project/constants/constants.dart';
import 'package:pokemon_project/controllers/controller_json.dart';

class SecondView extends StatefulWidget {
  const SecondView({Key? key}) : super(key: key);

  @override
  State<SecondView> createState() => _SecondViewState();
}

class _SecondViewState extends State<SecondView> {
  late final ScrollController _scrollController;
  late final ControllerJson _controller;
  final List<Widget> _pokemonToDisplay = [];
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
    //TODO: devo paginare anche i risultati e non scaricarli tutti nel widget
    setState(() {
      _searchResult = _controller.search(search);
    });
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    _controller = ControllerJson();
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
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: TextField(
                decoration: const InputDecoration(
                  hintText: Label.inputHint,
                  prefixIcon: Icon(Icons.search),
                ),
                textInputAction: TextInputAction.search,
                onChanged: _search,
              ),
            ),
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _searchResult.isEmpty
                      ? SingleChildScrollView(
                          controller: _scrollController,
                          child: Column(
                            children: [..._pokemonToDisplay],
                          ),
                        )
                      : SingleChildScrollView(
                          child: Column(
                            children: [
                              Text('${_searchResult.length} results:'),
                              ..._searchResult,
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
