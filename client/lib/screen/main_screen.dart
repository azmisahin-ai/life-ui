// screen/main_screen.dart
import 'package:flutter/material.dart';
import 'package:ui/screen/layout.dart';
import 'package:ui/screen/left_menu.dart';
import 'package:ui/screen/right_menu.dart';
import 'package:ui/screen/top_menu.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late Widget _currentScreen;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _currentScreen = const Layout();
  }

  void _onMenuItemSelected(Widget screen) {
    Navigator.pop(context);
    if (screen is! Layout) {
      setState(() {
        _currentScreen = screen;
      });
    } else {
      Navigator.pop(context);
    }
  }

  void _openEndDrawer() {
    _scaffoldKey.currentState?.openEndDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: TopMenu(
        onMenuIconPressed: _openEndDrawer,
      ),
      drawer: LeftMenu(onMenuItemSelected: _onMenuItemSelected),
      endDrawer: RightMenu(onMenuItemSelected: _onMenuItemSelected),
      body: _currentScreen,
    );
  }
}
