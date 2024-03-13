// state/providers/data_list_provider.dart
import 'package:flutter/material.dart';

class DataListProvider with ChangeNotifier {
  final List<String> _source = [];

  List<String> get source => _source;

  void addData(String data) {
    _source.add(data);
    notifyListeners();
  }

  void removeData(String data) {
    _source.remove(data);
    notifyListeners();
  }
}
