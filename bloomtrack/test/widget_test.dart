import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:bloomtrack/app.dart';
import 'package:bloomtrack/core/router.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('App smoke test — onboarding renders', (WidgetTester tester) async {
    // The router is normally configured in main(); do the same for the test.
    SharedPreferences.setMockInitialValues(<String, Object>{});
    setupRouter('/onboarding');

    await tester.pumpWidget(
      const ProviderScope(
        child: BloomTrackApp(),
      ),
    );
    await tester.pumpAndSettle();

    // The first onboarding page should render without crashing.
    expect(find.text('Welcome to BloomTrack'), findsOneWidget);
  });
}
