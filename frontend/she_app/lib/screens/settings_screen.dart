import 'package:flutter/material.dart';
import '../services/app_settings.dart';
import 'package:geolocator/geolocator.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool autoSOS = true;
  bool sound = true;
  bool vibration = true;

  @override
  void initState() {
    super.initState();
    loadSettings();
  }

  Future<void> loadSettings() async {
    autoSOS = await AppSettings.getAutoSOS();
    sound = await AppSettings.getSound();
    vibration = await AppSettings.getVibration();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Settings"),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          /// 🚨 Emergency Contacts (placeholder for now)
          settingsTile(
            icon: Icons.contact_phone,
            title: "Emergency Contacts",
            subtitle: "Manage trusted contacts",
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Contacts screen coming next")),
              );
            },
          ),

          /// 🤖 Auto SOS
          SwitchListTile(
            title: const Text("Auto SOS Detection"),
            subtitle: const Text("AI-based distress detection"),
            value: autoSOS,
            onChanged: (value) async {
              await AppSettings.setAutoSOS(value);
              setState(() => autoSOS = value);
            },
          ),

          /// 📍 Location Permission
          settingsTile(
            icon: Icons.location_on,
            title: "Location Permissions",
            subtitle: "Always allow during SOS",
            onTap: () async {
              await Geolocator.requestPermission();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Location permission requested")),
              );
            },
          ),

          /// 🔔 Alert Preferences
          SwitchListTile(
            title: const Text("Sound Alerts"),
            value: sound,
            onChanged: (value) async {
              await AppSettings.setSound(value);
              setState(() => sound = value);
            },
          ),

          SwitchListTile(
            title: const Text("Vibration Alerts"),
            value: vibration,
            onChanged: (value) async {
              await AppSettings.setVibration(value);
              setState(() => vibration = value);
            },
          ),

          /// ℹ️ About
          settingsTile(
            icon: Icons.info,
            title: "About SHE App",
            subtitle: "AI-powered women safety system",
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: "SHE App",
                applicationVersion: "1.0.0",
                children: [
                  const Text(
                    "SHE App detects distress using AI and helps women trigger SOS quickly and safely.",
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget settingsTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon, color: Colors.red),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
