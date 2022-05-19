import 'package:flutter/material.dart';
import 'package:pokemon_project/constants/constants.dart';
import 'package:pokemon_project/controllers/controller_api.dart';
import 'package:pokemon_project/controllers/controller_json.dart';
import 'package:pokemon_project/widgets/input_widget.dart';
import 'package:pokemon_project/widgets/loading_widget.dart';

// TODO: sarebbe bello poter usare lo scroll widget della home page!
class SearchView extends StatefulWidget {
  final ControllerApi? controllerApi;
  final ControllerJson? controllerJson;
  const SearchView({Key? key, this.controllerApi, this.controllerJson}) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  late final ScrollController _scrollController;
  late final TextEditingController _textController;
  List<Widget> _results = [];
  bool _isLoading = false;

  void _manageScrollController(int results) {
    _scrollController.removeListener(_scrollListener);
    if (results > 20) {
      _scrollController.addListener(_scrollListener);
    }
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(0);
    }
  }

  void Function(String)? _onChange() {
    if (widget.controllerJson != null) {
      return (String input) async {
        _results = await widget.controllerJson!.searchPokemon(input);
        _manageScrollController(widget.controllerJson!.searchResults);
        setState(() {
          _results;
        });
      };
    }
    return null;
  }

  void Function(String)? _onSubmit() {
    if (widget.controllerApi != null) {
      return (String input) async {
        if (_isLoading) return;
        setState(() {
          _isLoading = true;
        });
        _results = await widget.controllerApi!.searchPokemon(input);
        _manageScrollController(widget.controllerApi!.searchResults);
        setState(() {
          _isLoading = false;
        });
      };
    }
    return null;
  }

  void _reset() {
    widget.controllerApi?.reset();
    widget.controllerJson?.reset();
    setState(() {
      _results.clear();
    });
  }

  void _scrollListener() {
    if (_scrollController.offset >= _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      _scroll();
    }
  }

  void _scroll() {
    // TODO: brutta
    _results.addAll(widget.controllerApi != null
        ? widget.controllerApi!.scrollSearchResults()
        : widget.controllerJson!.scrollSearchResults());
    setState(() {
      _results;
    });
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _textController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    widget.controllerApi?.reset();
    widget.controllerJson?.reset();
    _scrollController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: const Text(Label.titleSearch)),
      body: Column(
        children: [
          InputWidget(onReset: _reset, onSubmit: _onSubmit(), onChange: _onChange(), textController: _textController),
          if (_results.isNotEmpty) ...[
            Text(Label.resultsNumber(
              displayed: _results.length,
              total: widget.controllerApi != null
                  ? widget.controllerApi!.searchResults
                  : widget.controllerJson!.searchResults,
            )),
            if (widget.controllerApi != null && widget.controllerApi!.partialResult) const Text(Label.maybeLookingFor),
          ],
          Expanded(
            child: _isLoading
                ? const LoadingWidget()
                : _textController.text.isNotEmpty && _results.isEmpty
                    ? const Center(child: Text(Label.pokemonNotFound))
                    : SingleChildScrollView(controller: _scrollController, child: Column(children: _results)),
          ),
        ],
      ),
    );
  }
}
