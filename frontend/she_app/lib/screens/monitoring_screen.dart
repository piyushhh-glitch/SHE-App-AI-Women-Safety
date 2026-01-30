import 'package:flutter/material.dart';

class MonitoringScreen extends StatelessWidget {
  const MonitoringScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Text(
              "AI Monitoring Active",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            _monitorCard("Motion Activity", 0.8),
            _monitorCard("Voice Stress", 0.6),
            _monitorCard("Location Tracking", 1.0),

            const Spacer(),

            ElevatedButton(
              onPressed: () {
                // TEMP: keep empty or handle inside tab system
              },
              child: const Text("View SHE Circle"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _monitorCard(String label, double value) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            LinearProgressIndicator(value: value),
          ],
        ),
      ),
    );
  }
}
