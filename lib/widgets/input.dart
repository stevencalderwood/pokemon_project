import 'package:flutter/material.dart';
import 'package:pokemon_project/controllers/pokemon_finder.dart';

class InputField extends StatefulWidget {
  final void Function(String) onSubmit;
  const InputField({Key? key, required this.onSubmit}) : super(key: key);

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  String? _errorText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(hintText: 'Insert pokemon name or id', errorText: _errorText),
      onSubmitted: (text) {
        if (text.isEmpty) return;
        final ServiceResult result = pokemonValidator(text);
        setState(() => _errorText = result.error.isNotEmpty ? result.error : null);
        if (_errorText != null) return;
        widget.onSubmit(result.data.toString());
      },
    );
  }
}
