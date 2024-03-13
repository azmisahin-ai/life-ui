// test/lib/services/fake_socket_service.dart
import 'dart:async';

import 'package:ui/services/socket_service.dart';

class FakeSocketService implements ISocketService {
  @override
  Future<bool> connect(String host, int port) async {
    return true;
  }

  @override
  Future<bool> sendData(String data) async {
    return true;
  }

  @override
  Future<String?> receiveData() async {
    return 'Fake data';
  }

  @override
  void closeConnection() {}
}
