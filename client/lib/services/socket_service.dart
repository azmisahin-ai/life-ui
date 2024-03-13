// lib/services/socket_service.dart
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';

abstract class ISocketService {
  Future<bool> connect(String host, int port);
  Future<bool> sendData(String data);
  Future<String?> receiveData();
  void closeConnection();
}

class SocketService implements ISocketService {
  late Socket _socket;

  @override
  Future<bool> connect(String host, int port) async {
    try {
      _socket = await Socket.connect(host, port);
      return true;
    } catch (e) {
      if (kDebugMode) {
        print('Error connecting to socket: $e');
      }
      return false;
    }
  }

  @override
  Future<bool> sendData(String data) async {
    try {
      _socket.write(data);
      return true;
    } catch (e) {
      if (kDebugMode) {
        print('Error sending data: $e');
      }
      return false;
    }
  }

  @override
  Future<String?> receiveData() async {
    try {
      final completer = Completer<String>();

      _socket.listen(
        (List<int> data) {
          final receivedData = utf8.decode(data);
          completer.complete(receivedData);
        },
        onDone: () {
          completer.completeError('Connection closed');
        },
        onError: (error) {
          completer.completeError(error.toString());
        },
        cancelOnError: true,
      );

      return completer.future;
    } catch (e) {
      if (kDebugMode) {
        print('Error receiving data: $e');
      }
      return null;
    }
  }

  @override
  void closeConnection() {
    _socket.destroy();
  }
}
