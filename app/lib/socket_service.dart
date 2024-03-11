import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService extends ChangeNotifier {
  late IO.Socket socket;
  List<String> logs = [];
  String status = "Connecting...";

  final _logsController = StreamController<List<String>>.broadcast();
  Stream<List<String>> get logsStream => _logsController.stream;

  final _durationController = StreamController<int>.broadcast();
  Stream<int> get durationStream => _durationController.stream;

  // Yeni eklenen StreamController
  final _notifyLogsUpdateController = StreamController<void>.broadcast();
  Stream<void> get notifyLogsUpdateStream => _notifyLogsUpdateController.stream;

  int durationTime = 5;

  SocketService(String serverAddress) {
    logs.add("status: $status");
    initSocket(serverAddress);
  }

  void initSocket(serverAddress) {
    socket = IO.io(serverAddress, <String, dynamic>{
      'transports': ['websocket']
    });

    socket.onConnect((_) {
      status = "connected!";
      logs.add("status: $status");

      Timer? timer;

      void startTimer() {
        timer = Timer.periodic(Duration(seconds: durationTime), (timer) {
          var endpoint = '/api/v1/time';
          logs.add("sending: $endpoint");
          socket.emit('get', endpoint);
        });
      }

      startTimer(); //

      _durationController.stream.listen((newDurationTime) {
        timer?.cancel();
        durationTime = newDurationTime;
        startTimer();
      });
    });

    socket.on('/api/v1/time', (data) {
      String currentTime = data["current_time"];
      logs.add("/api/v1/time: $currentTime");
      _logsController.add(logs.toList());
      _notifyLogsUpdateController.add(null);
    });

    socket.on('message', (data) {
      logs.add("message: $data");
      _logsController.add(logs.toList());
      _notifyLogsUpdateController.add(null);
    });

    socket.onDisconnect((_) {
      logs.add("Disconnect: ");
      _logsController.add(logs.toList());
      _notifyLogsUpdateController.add(null);
    });

    socket.onError((error) {
      logs.add("error:");
      _logsController.add(logs.toList());
      _notifyLogsUpdateController.add(null);
    });
  }

  void decreaseDuration() {
    durationTime = durationTime > 1 ? durationTime - 1 : 1;
    _durationController.add(durationTime);
    _notifyLogsUpdateController.add(null);
  }

  void increaseDuration() {
    durationTime += 1;
    _durationController.add(durationTime);
    _notifyLogsUpdateController.add(null);
  }

  //
  void notifyLogsUpdate() {
    _notifyLogsUpdateController.add(null);
  }

  @override
  void dispose() {
    super.dispose();
    socket.dispose();
    _logsController.close();
    _durationController.close();
    _notifyLogsUpdateController.close();
  }
}
