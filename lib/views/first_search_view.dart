import 'package:flutter/material.dart';
import 'package:pokemon_project/constants/constants.dart';
import 'package:pokemon_project/controllers/provider.dart';
import 'package:pokemon_project/controllers/controller_api.dart';
import 'package:pokemon_project/widgets/input_widget.dart';
import 'package:pokemon_project/widgets/loading_widget.dart';

class FirstSearchView extends StatefulWidget {
  const FirstSearchView({Key? key}) : super(key: key);

  @override
  State<FirstSearchView> createState() => _FirstSearchViewState();
}

class _FirstSearchViewState extends State<FirstSearchView> {
  final ControllerApi _controller = Provider.controllerApi;
  late final ScrollController _scrollController;
  List<Widget> _results = [];
  bool _isLoading = false;

  void _search(String search) async {
    if (_isLoading) return;
    setState(() {
      _isLoading = true;
    });
    _results = await _controller.searchPokemon(search);
    _scrollController.removeListener(_scrollListener);
    if (_controller.results > 20) {
      _scrollController.addListener(_scrollListener);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void _scroll() {
    _results.addAll(_controller.searchFromMemory('SCROLL'));
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

  void _reset() {
    _controller.noResults = false;
    _controller.reset();
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
                  Text(Label.resultsNumber(displayed: _results.length, total: _controller.results)),
                  const Text(Label.maybeLookingFor),
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
                        ? const Center(child: Text(Label.pokemonNotFound))
                        : const Center(),
          ),
        ],
      ),
    );
  }
}
