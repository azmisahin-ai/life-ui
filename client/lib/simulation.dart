import 'dart:convert';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketService {
  late io.Socket _socket;

  SocketService() {
    _socket = io.io(
      'http://172.23.146.182:8281',
      <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': true,
      },
    );
  }

  void connect(void Function() onConnect, void Function() onDisconnect,
      void Function(Map<String, dynamic>) onData) {
    _socket.onConnect((_) {
      onConnect();
    });

    _socket.onDisconnect((_) {
      onDisconnect();
    });

    _socket.on('simulation_instance_status', (data) {
      onData(data);
    });

    _socket.connect();
  }

  void disconnect() {
    _socket.disconnect();
  }
}

class ThreeDData {
  final double x;
  final double y;
  final double z;
  final String name;

  ThreeDData({
    required this.x,
    required this.y,
    required this.z,
    required this.name,
  });
}

class ThreeDVisualizationWidget extends StatelessWidget {
  final Map<String, ThreeDData> oldData;
  final Map<String, ThreeDData> newData;
  final Size size;

  const ThreeDVisualizationWidget(
      {Key? key,
      required this.oldData,
      required this.newData,
      required this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: size,
      painter:
          ThreeDPointPainter(oldData: oldData, newData: newData, size: size),
    );
  }
}

class ThreeDPointPainter extends CustomPainter {
  final Map<String, ThreeDData> oldData;
  final Map<String, ThreeDData> newData;
  final Size size;

  ThreeDPointPainter(
      {required this.oldData, required this.newData, required this.size});

  Color stringToColor(String text) {
    int hash = jsonEncode(text).hashCode & 0xffffff;
    return Color(hash).withOpacity(1.0);
  }

  @override
  void paint(Canvas canvas, Size size) {
    newData.forEach((key, data) {
      final paint = Paint()
        ..color = stringToColor(key) // Anahtara göre renk belirle
        ..strokeWidth = 10
        ..strokeCap = StrokeCap.round;

      final double centerX = size.width / 2;
      final double centerY = size.height / 2;

      final double scaleFactor = 300 / 1e27;
      final double x = data.x * scaleFactor;
      final double y = data.y * scaleFactor;
      final double z = data.z * scaleFactor;

      final double adjustedX = centerX + x / 2;
      final double adjustedY = centerY + y / 2;

      canvas.drawPoints(
          PointMode.points, [Offset(adjustedX, adjustedY)], paint);
    });
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ThreeD Point Visualization Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SocketIOPage(),
    );
  }
}

class SocketIOPage extends StatefulWidget {
  @override
  _SocketIOPageState createState() => _SocketIOPageState();
}

class _SocketIOPageState extends State<SocketIOPage> {
  late Map<String, ThreeDData> oldData = {};
  late Map<String, ThreeDData> newData = {};
  late SocketService socketService = SocketService();
  late String connection = "";
  late String lastData = "";
  @override
  void initState() {
    super.initState();
    socketService.connect(
      () {
        setState(() {
          connection = "Connected";
          // Connected
          print('Connected');
        });
      },
      () {
        setState(() {
          connection = "Disconnected";
          // Connected
          print('Disconnected');
        });
      },
      (data) {
        // Data received
        update3DView(data);
      },
    );
  }

  void update3DView(Map<String, dynamic> data) {
    setState(() {
      // Eski veriyi yeni veri olarak güncelle
      oldData = newData;
      // Yeni veriyi güncelle
      newData[data['name']] = ThreeDData(
        x: double.parse(data['position']['x'].toString()),
        y: double.parse(data['position']['y'].toString()),
        z: double.parse(data['position']['z'].toString()),
        name: data['name'],
      );
      lastData = data['position'].toString();
    });
  }

  @override
  void dispose() {
    socketService.disconnect(); // Disconnect socket when disposing the page
    super.dispose();
  }

  Future<void> startSimulation(
      String simulationType, int numberOfInstance) async {
    final response = await http.post(
      Uri.parse('http://172.23.146.182:8281/socket/v1/simulation/start'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        "number_of_instance": numberOfInstance,
        "lifetime_seconds": 60,
        "lifecycle": 1 / 30,
        "simulation_type": simulationType,
      }),
    );

    if (response.statusCode == 200) {
      setState(() {});
    } else {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(lastData),
      ),
      body: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return ThreeDVisualizationWidget(
                oldData: oldData,
                newData: newData,
                size: constraints.biggest ?? Size.zero);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          startSimulation("Particles", 20);
        },
        backgroundColor: Colors.white,
        child: Icon(Icons.network_wifi,
            color: connection == 'Connected' ? Colors.green : Colors.red),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}
