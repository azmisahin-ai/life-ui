// test/utils/helpers.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:ui/utils/helpers.dart';

void main() {
  test('capitalize function test', () {
    expect(capitalize(''), '');

    expect(capitalize('test'), 'Test');

    expect(capitalize('Example'), 'Example');

    expect(capitalize('multiWord'), 'MultiWord');
  });
}
