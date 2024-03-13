// test/services/socket_service_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'fake_socket_service.dart';

void main() {
  test('SocketService should connect to the server', () async {
    final socketService = FakeSocketService();
    final isConnected = await socketService.connect('your_server_host', 12345);

    expect(isConnected, true);
  });

  test('SocketService should send and receive data', () async {
    final socketService = FakeSocketService();
    final isDataSent = await socketService.sendData('Hello, Server!');
    final receivedData = await socketService.receiveData();

    expect(isDataSent, true);
    expect(receivedData, 'Fake data');
  });

  test('SocketService should close the connection', () async {
    final socketService = FakeSocketService();

    socketService.closeConnection();
  });
}
