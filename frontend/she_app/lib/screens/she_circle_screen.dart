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

    return Scaffold(
      appBar: AppBar(
        title: const Text("SHE Circle"),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: helpers.length,
        itemBuilder: (context, index) {
          final h = helpers[index];
          return Card(
            child: ListTile(
              leading: const Icon(Icons.person_pin_circle),
              title: Text(h["name"]!),
              subtitle: Text("Distance: ${h["distance"]}"),
              trailing: const Icon(Icons.check_circle, color: Colors.green),
            ),
          );
        },
      ),
    );
  }
}
