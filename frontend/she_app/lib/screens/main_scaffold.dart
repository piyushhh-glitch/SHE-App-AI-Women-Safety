import 'package:flutter/material.dart';

import 'home_screen.dart';
import 'monitoring_screen.dart';
import 'she_circle_screen.dart';
import 'settings_screen.dart';
import 'she_bot_chat.dart';

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _currentIndex = 0;

  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();

    // ⚠️ SCREEN COUNT = TAB COUNT (5)
    _screens = [
      HomeScreen(),
      MonitoringScreen(),
      SheCircleScreen(),

      // ✅ SHE BOT TAB
      SheBotChatScreen(
        onTriggerSOS: () {
          // SOS already handled by backend
          // (same endpoint as HomeScreen)
        },
      ),

      SettingsScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SHE App"),
        centerTitle: true,
      ),

      // 🔹 MAIN CONTENT
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),

      // 🔹 BOTTOM NAVIGATION (5 TABS)
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
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
            icon: Icon(Icons.chat_bubble),
            label: "SHE Bot",
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
