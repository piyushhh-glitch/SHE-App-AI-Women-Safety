import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import '../widgets/sos_button.dart';

late AnimationController _pulseController;


class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  String status = "You are safe";
  int countdown = 0;
  bool isSending = false;

  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
      lowerBound: 0.85,
      upperBound: 1.1,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  // 🔹 Status color logic
  Color getStatusColor() {
    if (status.contains("SOS")) return Colors.red;
    if (status.contains("Sending")) return Colors.orange;
    return Colors.green;
  }

  // 🔹 Call FastAPI backend
  Future<void> sendSOS() async {
    setState(() {
      isSending = true;
      status = "Sending SOS...";
    });

    try {
      final response = await http.post(
        Uri.parse("http://10.0.2.2:8000/sos"), // Android emulator → local backend
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "user_id": "flutter_user_01",
          "location": "18.5204,73.8567",
          "motion": 25,
          "voice_features": List.filled(40, 1),
        }),
      );

      if (response.statusCode == 200) {
        setState(() {
          status = "🚨 AUTO SOS Triggered";
        });

        // 🔥 Navigate to SOS Activated screen
        Navigator.pushNamed(context, '/sos');
      } else {
        setState(() {
          status = "❌ SOS Failed";
        });
      }
    } catch (e) {
      setState(() {
        status = "❌ Network Error";
      });
    } finally {
      setState(() {
        isSending = false;
      });
    }
  }

  // 🔹 Countdown logic
  void startCountdown() {
    if (isSending) return;

    setState(() {
      countdown = 3;
    });

    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        countdown--;
      });

      if (countdown == 0) {
        timer.cancel();
        sendSOS();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SHE – Dashboard"),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  /// SHIELD ICON
                  Icon(
                    Icons.shield,
                    size: 120,
                    color: getStatusColor(),
                  ),

                  const SizedBox(height: 20),

                  /// STATUS CARD
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        status,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: getStatusColor(),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),

                  /// SOS BUTTON (LONG PRESS)
                  ScaleTransition(
                    scale: _pulseController,
                    child: GestureDetector(
                      onLongPress: startCountdown,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 60,
                          vertical: 20,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.red.withOpacity(0.6),
                              blurRadius: 20,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: const Text(
                          "HOLD TO TRIGGER SOS",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    "Long press to avoid accidental alerts",
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),

          /// COUNTDOWN OVERLAY
          if (countdown > 0)
            Container(
              color: Colors.black.withOpacity(0.6),
              child: Center(
                child: Text(
                  countdown.toString(),
                  style: const TextStyle(
                    fontSize: 100,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
