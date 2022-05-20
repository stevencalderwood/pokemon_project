import 'package:flutter/material.dart';
import 'package:pokemon_project/constants/constants.dart';
import 'package:pokemon_project/controllers/controller_api.dart';
import 'package:pokemon_project/controllers/controller_json.dart';
import 'package:pokemon_project/widgets/input_widget.dart';
import 'package:pokemon_project/widgets/loading_widget.dart';
import 'package:pokemon_project/widgets/results_widget.dart';

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
  List<Widget> _resultWidgets = [];
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

  /// Returns a function for the [InputWidget] if the controller is capable to handle a dynamic search.
  ///
  /// It will be called everytime the input changes.
  void Function(String)? _onChange() {
    if (widget.controllerJson != null) {
      return (String input) async {
        _resultWidgets = await widget.controllerJson!.searchPokemon(input);
        _manageScrollController(widget.controllerJson!.searchResults);
        setState(() => _resultWidgets);
      };
    }
    return null;
  }

  /// Returns a function for the [InputWidget] if the controller is not capable to handle a dynamic search.
  ///
  /// It'll be called only when the input is submitted by the user.
  void Function(String)? _onSubmit() {
    if (widget.controllerApi != null) {
      return (String input) async {
        if (_isLoading) return;
        setState(() => _isLoading = true);
        _resultWidgets = await widget.controllerApi!.searchPokemon(input);
        _manageScrollController(widget.controllerApi!.searchResults);
        setState(() => _isLoading = false);
      };
    }
    return null;
  }

  /// Called when the text input is reset by the user
  ///
  /// The Controller search history will also be cleaned.
  void _reset() {
    if (_isLoading) return;
    widget.controllerApi?.reset();
    widget.controllerJson?.reset();
    setState(() => _resultWidgets.clear());
  }

  void _scrollListener() {
    if (_scrollController.offset >= _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      _scroll();
    }
  }

  void _scroll() {
    _resultWidgets.addAll(widget.controllerApi?.scrollSearchResults() ?? widget.controllerJson!.scrollSearchResults());
    setState(() => _resultWidgets);
  }

  /// Widget displayed when the search result from the [widget.controllerApi] comes from the super class memory.
  List<Widget> _partial() {
    if (_resultWidgets.isNotEmpty && widget.controllerApi != null && widget.controllerApi!.isPartialResult) {
      return [
        Row(children: const [Padding(padding: EdgeInsets.all(10), child: Text(Label.maybeLookingFor))])
      ];
    }
    return [];
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _textController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    //  Resets the controllers search history.
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
      appBar: AppBar(title: Text(Label.titleSearch(widget.controllerApi != null))),
      body: Column(
        children: [
          InputWidget(onReset: _reset, onSubmit: _onSubmit(), onChange: _onChange(), textController: _textController),
          Expanded(
            child: _isLoading
                ? const LoadingWidget()
                : Column(
                    children: [
                      ResultsWidget(total: widget.controllerApi?.searchResults ?? widget.controllerJson!.searchResults),
                      ..._partial(),
                      Expanded(
                        child: _textController.text.isNotEmpty && _resultWidgets.isEmpty
                            ? const Center(child: Text(Label.pokemonNotFound))
                            : SingleChildScrollView(
                                controller: _scrollController,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Column(children: _resultWidgets),
                                ),
                              ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
