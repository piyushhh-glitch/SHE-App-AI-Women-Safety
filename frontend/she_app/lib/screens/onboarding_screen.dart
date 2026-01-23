import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int index = 0;

  final List<Map<String, String>> pages = [
    {
      "title": "Safe Mode",
      "desc":
          "Activate Safe Mode to automatically detect distress and trigger SOS."
    },
    {
      "title": "Live Location",
      "desc":
          "Your location is shared securely with trusted contacts during emergencies."
    },
    {
      "title": "SHE Circle",
      "desc":
          "Nearby verified users and responders can help you instantly."
    },
  ];

  void next() {
    if (index < pages.length - 1) {
      setState(() => index++);
    } else {
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    final page = pages[index];

    return Scaffold(
      backgroundColor: const Color(0xFFF7F4FF),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: () =>
                      Navigator.pushReplacementNamed(context, '/home'),
                  child: const Text("Skip"),
                ),
              ),

              const Spacer(),

              Icon(Icons.security,
                  size: 100, color: Colors.deepPurple),

              const SizedBox(height: 30),

              Text(
                page["title"]!,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              Text(
                page["desc"]!,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, color: Colors.black54),
              ),

              const Spacer(),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  pages.length,
                  (i) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: index == i ? 14 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: index == i
                          ? Colors.deepPurple
                          : Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              ElevatedButton(
                onPressed: next,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 80, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  index == pages.length - 1
                      ? "Get Started"
                      : "Next",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
