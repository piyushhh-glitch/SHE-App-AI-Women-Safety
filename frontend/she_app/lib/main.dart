import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String statusText = "You are safe";

  // 🔹 Status-based color logic
  Color getStatusColor() {
    if (statusText.contains("SOS")) {
      return Colors.red;
    } else if (statusText.contains("Sending")) {
      return Colors.orange;
    }
    return Colors.green;
  }

  // 🔹 Trigger SOS (Long Press)
  Future<void> triggerSOS() async {
    setState(() {
      statusText = "Sending SOS...";
    });

    try {
      final response = await http.post(
        Uri.parse("http://10.0.2.2:8000/sos"), // Android Emulator
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "user_id": "flutter_user_01",
          "location": "18.5204,73.8567",
          "motion": 20,
          "voice_features": List.filled(40, 1),
        }),
      );

      if (response.statusCode == 200) {
        setState(() {
          statusText = "🚨 AUTO SOS Triggered";
        });
      } else {
        setState(() {
          statusText = "❌ SOS Failed";
        });
      }
    } catch (e) {
      setState(() {
        statusText = "❌ Network Error";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SHE – Women Safety"),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 🔹 Reactive Shield Icon
              Icon(
                Icons.shield,
                size: 110,
                color: getStatusColor(),
              ),

              const SizedBox(height: 30),

              // 🔹 Status Text
              Text(
                statusText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: getStatusColor(),
                ),
              ),

              const SizedBox(height: 50),

              // 🔹 Long-Press SOS Button
              GestureDetector(
                onLongPress: triggerSOS,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 60,
                    vertical: 20,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Text(
                    "HOLD TO TRIGGER SOS",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                "Long press to avoid accidental alerts",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
