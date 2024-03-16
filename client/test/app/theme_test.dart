import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui/app/theme.dart';

void main() {
  test('AppTheme Test', () {
    final ThemeData appTheme = AppTheme.getTheme();
    expect(appTheme.primaryColor, const Color.fromARGB(255, 20, 18, 24));
  });
}
