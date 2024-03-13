// test/state/providers/data_list_provider_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:ui/state/providers/data_list_provider.dart';

void main() {
  test('DataListProvider should add and remove data', () {
    final dataListProvider = DataListProvider();
    expect(dataListProvider.source, isEmpty);

    dataListProvider.addData('Item 1');
    dataListProvider.addData('Item 2');

    expect(dataListProvider.source, ['Item 1', 'Item 2']);

    dataListProvider.removeData('Item 1');
    expect(dataListProvider.source, ['Item 2']);
  });
}
