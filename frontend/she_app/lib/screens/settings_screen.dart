import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          SettingsTile(
            icon: Icons.contacts,
            title: "Emergency Contacts",
            subtitle: "Manage trusted contacts",
          ),
          SettingsTile(
            icon: Icons.security,
            title: "Auto SOS Detection",
            subtitle: "AI-based distress detection",
          ),
          SettingsTile(
            icon: Icons.location_on,
            title: "Location Permissions",
            subtitle: "Always allow during SOS",
          ),
          SettingsTile(
            icon: Icons.notifications,
            title: "Alert Preferences",
            subtitle: "Sound, vibration & alerts",
          ),
          SettingsTile(
            icon: Icons.info_outline,
            title: "About SHE App",
            subtitle: "AI-powered women safety system",
          ),
        ],
      ),
    );
  }
}

class SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const SettingsTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.red.withOpacity(0.1),
          child: Icon(icon, color: Colors.red),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}
