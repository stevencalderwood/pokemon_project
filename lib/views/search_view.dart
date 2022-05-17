import 'package:flutter/material.dart';
import 'package:pokemon_project/constants/constants.dart';
import 'package:pokemon_project/controllers/controller.dart';
import 'package:pokemon_project/controllers/controller_json.dart';
import '../controllers/controller_api.dart';
import '../models/pokemon.dart';
import '../widgets/card_widget.dart';
import '../widgets/input_widget.dart';
import '../widgets/loading_widget.dart';

class SearchViewSecond extends StatefulWidget {
  const SearchViewSecond({Key? key}) : super(key: key);

  @override
  State<SearchViewSecond> createState() => _SearchViewSecondState();
}

class _SearchViewSecondState extends State<SearchViewSecond> {
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
        title: const Text(Label.titleSearch),
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
          ..._results.isNotEmpty ? [Text('${_results.length} of ${_controller.results} results:')] : [],
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

class SearchViewFirst extends StatefulWidget {
  const SearchViewFirst({Key? key}) : super(key: key);

  @override
  State<SearchViewFirst> createState() => _SearchViewFirstState();
}

class _SearchViewFirstState extends State<SearchViewFirst> {
  final ControllerApi _controller = Provider.api;
  late final ScrollController _scrollController;
  List<Widget> _results = [];
  bool _isLoading = false;

  void _search(String search) async {
    if (_isLoading) return;
    setState(() {
      _isLoading = true;
    });
    _results = await _controller.searchPokemon(search);
    // TODO: need to also handle scrolling, careful with adding and removing listener
    setState(() {
      _isLoading = false;
    });
  }

  void _scrollListener() {
    if (_scrollController.offset >= _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      print('sto scrollando');
    }
  }

  void _reset() {
    _controller.noResults = false;
    setState(() {
      _results = [];
    });
  }

  @override
  void initState() {
    _scrollController = ScrollController();
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
          InputWidget(onSubmit: _search, onReset: _reset),
          ..._controller.results > 0
              ? [
                  Text('${_results.length} of ${_controller.results} results:'),
                  const Text('Maybe you were looking for...'),
                ]
              : [],
          Expanded(
            child: _isLoading
                ? const LoadingWidget()
                : _results.isNotEmpty
                    ? SingleChildScrollView(
                        controller: _scrollController,
                        child: Column(
                          children: _results,
                        ),
                      )
                    : _controller.noResults
                        ? const Center(child: Text('No pokemon found'))
                        : const Center(),
          ),
        ],
      ),
    );
  }
}
