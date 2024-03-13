// test/state/providers/counter_provider_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:ui/state/providers/counter_provider.dart';

void main() {
  group('CounterProvider Test', () {
    test('Increment and Decrement Counter', () {
      final counterProvider = CounterProvider();
      expect(counterProvider.count, 0);

      counterProvider.increment();
      expect(counterProvider.count, 1);

      counterProvider.decrement();
      expect(counterProvider.count, 0);
    });

    test('Reset Counter', () {
      final counterProvider = CounterProvider();

      counterProvider.increment();
      counterProvider.reset();
      expect(counterProvider.count, 0);
    });
  });
}
