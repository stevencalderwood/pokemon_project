import 'package:flutter/material.dart';
import 'package:pokemon_project/controllers/controller_api.dart';
import 'package:pokemon_project/controllers/controller_json.dart';
import 'package:pokemon_project/widgets/results_widget.dart';
import 'package:pokemon_project/widgets/scaffold_widget.dart';
import 'package:pokemon_project/widgets/loading_widget.dart';
import 'package:pokemon_project/widgets/buttons_widget.dart';
import 'package:pokemon_project/constants/constants.dart';

class HomeView extends StatefulWidget {
  final ControllerApi? controllerApi;
  final ControllerJson? controllerJson;
  const HomeView({Key? key, this.controllerJson, this.controllerApi}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final ScrollController _scrollController;
  final List<Widget> _pokemonWidgets = [];
  bool _isLoading = true;

  /// Handles all the user requests to the controller
  Future<void> _getPokemon() async {
    final List<Widget> result = await widget.controllerApi?.getPokemon() ?? await widget.controllerJson!.getPokemon();
    if (result.isEmpty) {
      _scrollController.removeListener(_scrollListener);
      return;
    }
    _pokemonWidgets.addAll(result);
    setState(() => _isLoading = false);
  }

  void _scrollListener() async {
    if (_scrollController.offset >= _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      await _getPokemon();
    }
  }

  /// Returns a function for the Sort Button if the controller allows this functionality.
  void Function()? _sort() {
    if (widget.controllerJson != null) {
      return () {
        setState(() => _isLoading = true);
        widget.controllerJson!.sortPokemon();
        _scrollController.jumpTo(0);
        _pokemonWidgets.clear();
        _getPokemon();
      };
    }
    return null;
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
    widget.controllerJson?.reset();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      isFirstVersion: widget.controllerApi != null,
      body: _isLoading
          ? const LoadingWidget()
          : Column(
              children: [
                ButtonsWidget(
                  scrollController: _scrollController,
                  sort: _sort(),
                  isAlphabetic: widget.controllerJson?.isAlphabetic,
                ),
                const ResultsWidget(total: Constant.pokemonMax),
                Expanded(
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Column(children: _pokemonWidgets),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
