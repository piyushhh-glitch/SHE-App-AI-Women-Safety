import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';
import 'screens/main_scaffold.dart';
import 'screens/sos_active_screen.dart';

void main() {
  runApp(const SHEApp());
}

class SHEApp extends StatelessWidget {
  const SHEApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SHE App',
      theme: ThemeData(primarySwatch: Colors.red),
      home: const MainScaffold(),
      routes: {
        '/main': (context) => const MainScaffold(),
        '/sos': (context) => const SOSActiveScreen(),
      },
    );
  }
}
