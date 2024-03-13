import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui/app/theme.dart';

void main() {
  test('AppTheme Test', () {
    final ThemeData appTheme = AppTheme.getTheme();
    expect(appTheme.primaryColor, Colors.blue);

    final TextStyle displayLargeStyle = appTheme.textTheme.displayLarge!;
    expect(displayLargeStyle.fontSize, 24.0);
    expect(displayLargeStyle.fontWeight, FontWeight.bold);
    expect(displayLargeStyle.color, Colors.black);

    final TextStyle bodyLargeStyle = appTheme.textTheme.bodyLarge!;
    expect(bodyLargeStyle.fontSize, 16.0);
    expect(bodyLargeStyle.color, Colors.black);
  });
}
