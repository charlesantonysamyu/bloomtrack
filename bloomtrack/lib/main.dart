import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'core/router.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  final prefs = await SharedPreferences.getInstance();
  final onboardingComplete = prefs.getBool('onboardingComplete') ?? false;
  final initialRoute = onboardingComplete ? '/today' : '/onboarding';
  
  setupRouter(initialRoute);

  runApp(
    const ProviderScope(
      child: BloomTrackApp(),
    ),
  );
}
