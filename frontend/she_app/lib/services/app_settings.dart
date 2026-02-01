import 'package:shared_preferences/shared_preferences.dart';

class AppSettings {
  static const _autoSOSKey = 'auto_sos';
  static const _soundKey = 'alert_sound';
  static const _vibrationKey = 'alert_vibration';

  /// Auto SOS
  static Future<bool> getAutoSOS() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_autoSOSKey) ?? true;
  }

  static Future<void> setAutoSOS(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_autoSOSKey, value);
  }

  /// Sound
  static Future<bool> getSound() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_soundKey) ?? true;
  }

  static Future<void> setSound(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_soundKey, value);
  }

  /// Vibration
  static Future<bool> getVibration() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_vibrationKey) ?? true;
  }

  static Future<void> setVibration(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_vibrationKey, value);
  }
}
