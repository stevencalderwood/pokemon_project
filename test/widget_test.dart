// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:pokemon_project/controllers/pokemon_finder.dart';

void main() {
  final List<String> values = ['0', '1', 'aa', 'abc', 'a/cdg', '01ff', '--ff', '-f-', 'abu-abu'];
  final List<bool> error = [true, false, true, false, true, true, true, true, false];
  final List<Type> dataTypes = [Null, int, Null, String, Null, Null, Null, Null, String];
  group('data types return from serviceResult', () {
    test('serviceResult errors', () {
      for (int i = 0; i < values.length; i++) {
        final ServiceResult result = pokemonValidator(value: values[i]);
        expect(result.error != null, error[i]);
      }
    });
    test('serviceResult data', () {
      for (int i = 0; i < values.length; i++) {
        final ServiceResult result = pokemonValidator(value: values[i]);
        expect(result.data.runtimeType, dataTypes[i]);
      }
    });
  });
}
