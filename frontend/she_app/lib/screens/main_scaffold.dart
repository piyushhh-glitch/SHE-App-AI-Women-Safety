import 'package:flutter/material.dart';

import 'home_screen.dart';
import 'monitoring_screen.dart';
import 'she_circle_screen.dart';
import 'settings_screen.dart';

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    MonitoringScreen(),
    SheCircleScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SHE App"),
        centerTitle: true,
      ),

      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.red,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.shield),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.monitor_heart),
            label: "Monitor",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: "Circle",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
          ),
        ],
      ),
    );
  }
}
