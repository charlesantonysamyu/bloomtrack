import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IsFahrenheitNotifier extends Notifier<bool> {
  @override
  bool build() {
    _load();
    return false;
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    state = prefs.getBool('is_fahrenheit') ?? false;
  }

  Future<void> toggle(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('is_fahrenheit', value);
    state = value;
  }
}

final isFahrenheitProvider = NotifierProvider<IsFahrenheitNotifier, bool>(() {
  return IsFahrenheitNotifier();
});
