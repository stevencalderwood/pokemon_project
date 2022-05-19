import 'package:flutter/material.dart';
import 'package:pokemon_project/constants/constants.dart';
import 'package:pokemon_project/services/validator.dart';
import 'package:pokemon_project/models/service_result.dart';

class InputWidget extends StatefulWidget {
  final TextEditingController textController;
  final void Function(String)? onSubmit;
  final void Function(String)? onChange;
  final void Function() onReset;
  const InputWidget({Key? key, required this.onReset, required this.textController, this.onSubmit, this.onChange})
      : super(key: key);

  @override
  State<InputWidget> createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  String? _errorText;

  void Function(String)? _onSubmitted() {
    if (widget.onSubmit != null) {
      return (text) {
        if (text.isEmpty) return;
        final ServiceResult result = Validator.validatePokemon(input: text);
        _errorText = result.error;
        if (_errorText != null) return;
        widget.onSubmit!(result.data.toString());
      };
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: Label.inputHint,
        errorText: _errorText,
        prefixIcon: const Icon(Icons.search),
        suffixIcon: widget.textController.text.isNotEmpty
            ? IconButton(
                onPressed: () {
                  _errorText = null;
                  widget.textController.clear();
                  widget.onReset();
                },
                icon: const Icon(Icons.clear),
              )
            : null,
      ),
      textInputAction: TextInputAction.search,
      controller: widget.textController,
      onChanged: widget.onChange,
      onSubmitted: _onSubmitted(),
    );
  }
}
