// state/providers/data_provider.dart
import 'package:flutter/material.dart';
import 'package:ui/state/providers/counter_provider.dart';
import 'package:ui/state/providers/data_list_provider.dart';

class DataProvider with ChangeNotifier {
  final CounterProvider counter = CounterProvider();
  final DataListProvider data = DataListProvider();
}
