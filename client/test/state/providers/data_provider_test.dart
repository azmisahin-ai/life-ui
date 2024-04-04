// test/state/providers/data_provider_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:ui/state/providers/data_provider.dart';

void main() {
  test('DataProvider should increment counter and manipulate data list', () {
    final dataProvider = DataProvider();

    expect(dataProvider.counter.count, 0);
    expect(dataProvider.data.source, isEmpty);

    dataProvider.counter.increment();

    expect(dataProvider.counter.count, 1);

    dataProvider.data.addData('Item 1');
    dataProvider.data.addData('Item 2');

    expect(dataProvider.data.source, ['Item 1', 'Item 2']);

    dataProvider.data.removeData('Item 1');

    expect(dataProvider.data.source, ['Item 2']);
  });
}
