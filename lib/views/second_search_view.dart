import 'package:flutter/material.dart';
import 'package:pokemon_project/controllers/controller_json.dart';
import 'package:pokemon_project/controllers/provider.dart';
import 'package:pokemon_project/constants/constants.dart';

class SecondSearchView extends StatefulWidget {
  const SecondSearchView({Key? key}) : super(key: key);

  @override
  State<SecondSearchView> createState() => _SecondSearchViewState();
}

class _SecondSearchViewState extends State<SecondSearchView> {
  final ControllerJson _controller = Provider.json;
  late final ScrollController _scrollController;
  List<Widget> _results = [];

  void _search(String value) {
    _results = _controller.searchPokemon(value);
    setState(() {
      _results;
    });
  }

  void _scroll() {
    _results.addAll(_controller.searchPokemon('SCROLL'));
    setState(() {
      _results;
    });
  }

  void _scrollListener() {
    if (_scrollController.offset >= _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      _scroll();
    }
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _controller.reset();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(Label.titleSearch),
      ),
      body: Column(
        children: [
          TextField(
            decoration: const InputDecoration(
              hintText: Label.inputHint,
              prefixIcon: Icon(Icons.search),
            ),
            textInputAction: TextInputAction.search,
            onChanged: _search,
          ),
          ..._results.isNotEmpty
              ? [Text(Label.resultsNumber(displayed: _results.length, total: _controller.results))]
              : [],
          ..._results.isNotEmpty
              ? [
                  Expanded(
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      child: Column(children: _results),
                    ),
                  )
                ]
              : []
        ],
      ),
    );
  }
}
