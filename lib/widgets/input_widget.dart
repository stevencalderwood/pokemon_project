import 'package:flutter/material.dart';
import 'package:pokemon_project/constants/constants.dart';
import 'package:pokemon_project/controllers/pokemon_finder.dart';
import 'package:pokemon_project/models/service_result.dart';

class InputWidget extends StatefulWidget {
  final void Function(String) onSubmit;
  final void Function() onReset;
  const InputWidget({Key? key, required this.onSubmit, required this.onReset}) : super(key: key);

  @override
  State<InputWidget> createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  String? _errorText;
  late final TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: Label.inputHint,
        errorText: _errorText,
        prefixIcon: const Icon(Icons.search),
        suffixIcon: _controller.text.isNotEmpty
            ? IconButton(
                onPressed: () {
                  _errorText = null;
                  setState(() => _controller.clear());
                  widget.onReset();
                },
                icon: const Icon(Icons.clear),
              )
            : null,
      ),
      textInputAction: TextInputAction.search,
      controller: _controller,
      onSubmitted: (text) {
        if (text.isEmpty) return;
        final ServiceResult result = pokemonValidator(value: text);
        setState(() => _errorText = result.error);
        if (_errorText != null) return;
        widget.onSubmit(result.data.toString());
      },
    );
  }
}
