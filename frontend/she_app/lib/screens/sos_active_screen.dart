import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class SOSActiveScreen extends StatefulWidget {
  const SOSActiveScreen({super.key});

  @override
  State<SOSActiveScreen> createState() => _SOSActiveScreenState();
}

class _SOSActiveScreenState extends State<SOSActiveScreen> {
  Timer? _locationTimer;
  String locationStatus = "Fetching location...";

  @override
  void initState() {
    super.initState();
    startLiveLocation();
  }

  @override
  void dispose() {
    _locationTimer?.cancel();
    super.dispose();
  }

  /// 🔴 START LIVE LOCATION LOOP
  void startLiveLocation() {
    _locationTimer = Timer.periodic(const Duration(seconds: 5), (_) async {
      await sendLocation();
    });
  }

  /// 📍 GET GPS + SEND TO BACKEND
  Future<void> sendLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() => locationStatus = "Location disabled");
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      await http.post(
        Uri.parse("http://10.0.2.2:8000/location"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "user_id": "flutter_user_01",
          "lat": position.latitude,
          "lng": position.longitude,
        }),
      );

      setState(() {
        locationStatus =
            "📍 ${position.latitude.toStringAsFixed(4)}, ${position.longitude.toStringAsFixed(4)}";
      });
    } catch (e) {
      setState(() => locationStatus = "Location error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text("SOS Active"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            _locationTimer?.cancel();
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.location_on,
                  size: 90, color: Colors.red),

              const SizedBox(height: 20),

              const Text(
                "Live Location Sharing Active",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              Text(
                locationStatus,
                style: const TextStyle(color: Colors.grey),
              ),

              const SizedBox(height: 40),

              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/monitoring');
                },
                child: const Text("View Live Monitoring"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
