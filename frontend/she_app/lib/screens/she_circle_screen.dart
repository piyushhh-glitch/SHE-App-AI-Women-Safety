import 'package:flutter/material.dart';

class SheCircleScreen extends StatelessWidget {
  const SheCircleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final helpers = [
      {"name": "Police Control", "distance": "0.5 km"},
      {"name": "Campus Security", "distance": "0.8 km"},
      {"name": "Verified SHE User", "distance": "1.2 km"},
    ];

    return SafeArea(
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: helpers.length,
        itemBuilder: (context, index) {
          final h = helpers[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: const Icon(Icons.person_pin_circle),
              title: Text(h["name"]!),
              subtitle: Text("Distance: ${h["distance"]}"),
              trailing:
                  const Icon(Icons.check_circle, color: Colors.green),
            ),
          );
        },
      ),
    );
  }
}
