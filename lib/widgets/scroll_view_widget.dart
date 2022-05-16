import 'package:flutter/material.dart';
import 'package:pokemon_project/controllers/controller_api.dart';
import 'package:pokemon_project/controllers/controller_json.dart';
import 'package:pokemon_project/widgets/loading_widget.dart';

class ScrollViewWidget extends StatefulWidget {
  final ControllerApi? controllerApi;
  final ControllerJson? controllerJson;
  const ScrollViewWidget({Key? key, this.controllerJson, this.controllerApi}) : super(key: key);

  @override
  State<ScrollViewWidget> createState() => _ScrollViewWidgetState();
}

class _ScrollViewWidgetState extends State<ScrollViewWidget> {
  late final ScrollController _scrollController;
  late final dynamic _controller;
  final List<Widget> _pokemonWidgets = [];
  bool _isLoading = true;

  Future<void> _getPokemon() async {
    List<Widget> result = await _controller.getPokemon();
    _isLoading = false;
    if (result.isEmpty) {
      _scrollController.removeListener(_scrollListener);
      return;
    }
    setState(() {
      _pokemonWidgets.addAll(result);
    });
  }

  void _scrollListener() async {
    if (_scrollController.offset >= _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      await _getPokemon();
    }
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    _controller = widget.controllerJson ?? widget.controllerApi;
    _getPokemon();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _getPokemon();
    super.dispose();
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: _isLoading
          ? const LoadingWidget()
          : SingleChildScrollView(
              controller: _scrollController,
              child: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Column(children: _pokemonWidgets),
              ),
            ),
    );
  }
}
