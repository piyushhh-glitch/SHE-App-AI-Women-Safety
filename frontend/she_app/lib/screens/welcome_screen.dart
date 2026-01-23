import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0E1A2B),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.shield, size: 90, color: Colors.blueAccent),
              const SizedBox(height: 20),

              const Text(
                "Welcome to SHE",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),
              const Text(
                "Your safety companion",
                style: TextStyle(color: Colors.white70),
              ),

              const SizedBox(height: 40),

              /// 🔐 BIOMETRIC LOGIN
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/main');
                },
                icon: const Icon(Icons.fingerprint),
                label: const Text("Biometric Login"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              /// 🔑 PASSWORD LOGIN
              OutlinedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/main');
                },
                child: const Text(
                  "Login with Password",
                  style: TextStyle(color: Colors.white),
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                "🔒 Encrypted • Secure",
                style: TextStyle(color: Colors.greenAccent),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
