import 'package:flutter/material.dart';
import 'package:pokemon_project/controllers/controller_api.dart';
import 'package:pokemon_project/controllers/controller_json.dart';
import 'package:pokemon_project/widgets/loading_widget.dart';
import 'package:pokemon_project/widgets/sort_button_widget.dart';

class ScrollViewWidget extends StatefulWidget {
  final ControllerApi? controllerApi;
  final ControllerJson? controllerJson;
  const ScrollViewWidget({Key? key, this.controllerJson, this.controllerApi}) : super(key: key);

  @override
  State<ScrollViewWidget> createState() => _ScrollViewWidgetState();
}

class _ScrollViewWidgetState extends State<ScrollViewWidget> {
  late final ScrollController _scrollController;
  final List<Widget> _pokemonWidgets = [];
  bool _isLoading = true;

  Future<void> _getPokemon() async {
    late final List<Widget> result;
    if (widget.controllerApi != null) {
      result = await widget.controllerApi!.getPokemon();
    } else {
      result = await widget.controllerJson!.getPokemon();
    }

    if (result.isEmpty) {
      _scrollController.removeListener(_scrollListener);
      return;
    }
    _pokemonWidgets.addAll(result);

    setState(() {
      _isLoading = false;
    });
  }

  void _scrollListener() async {
    if (_scrollController.offset >= _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      await _getPokemon();
    }
  }

  void _sort() {
    setState(() => _isLoading = true);
    widget.controllerJson!.sortPokemon();
    _scrollController.jumpTo(0);
    _pokemonWidgets.clear();
    _getPokemon();
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    _getPokemon();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    widget.controllerApi?.reset();
    widget.controllerJson?.reset();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.controllerJson != null)
          SortButtonWidget(sort: _sort, isAlphabetic: widget.controllerJson!.isAlphabetic),
        Expanded(
          child: _isLoading
              ? const LoadingWidget()
              : SingleChildScrollView(
                  controller: _scrollController,
                  child: Padding(padding: const EdgeInsets.only(top: 5), child: Column(children: _pokemonWidgets)),
                ),
        ),
      ],
    );
  }
}
