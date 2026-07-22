import 'package:flutter_test/flutter_test.dart';

import 'package:bloomtrack/core/utils/health_checks.dart';

void main() {
  // ── Helpers ────────────────────────────────────────────────────────────

  /// Baseline "everything is normal" call — should produce zero alerts.
  List<HealthAlert> checkNormal() => HealthChecks.checkAll(
        cycleLengths: [28, 29, 27, 28],
        periodLengths: [5, 4, 5, 5],
        missedPeriods: 0,
      );

  // ── Normal case ────────────────────────────────────────────────────────

  group('Normal values', () {
    test('return no alerts', () {
      expect(checkNormal(), isEmpty);
    });

    test('empty lists with zero missed periods return no alerts', () {
      final alerts = HealthChecks.checkAll(
        cycleLengths: [],
        periodLengths: [],
        missedPeriods: 0,
      );
      expect(alerts, isEmpty);
    });
  });

  // ── Cycle length ───────────────────────────────────────────────────────

  group('Cycle length checks', () {
    test('short cycle (< 21 days) triggers warning', () {
      final alerts = HealthChecks.checkAll(
        cycleLengths: [20],
        periodLengths: [5],
        missedPeriods: 0,
      );
      expect(alerts, hasLength(1));
      expect(alerts.first.title, contains('Short cycle'));
      expect(alerts.first.severity, AlertSeverity.warning);
    });

    test('long cycle (> 35 days) triggers warning', () {
      final alerts = HealthChecks.checkAll(
        cycleLengths: [40],
        periodLengths: [5],
        missedPeriods: 0,
      );
      expect(alerts, hasLength(1));
      expect(alerts.first.title, contains('Long cycle'));
      expect(alerts.first.severity, AlertSeverity.warning);
    });

    test('cycle at 21 days does not trigger short cycle alert', () {
      final alerts = HealthChecks.checkAll(
        cycleLengths: [21],
        periodLengths: [5],
        missedPeriods: 0,
      );
      expect(alerts.where((a) => a.title.contains('Short')), isEmpty);
    });

    test('cycle at 35 days does not trigger long cycle alert', () {
      final alerts = HealthChecks.checkAll(
        cycleLengths: [35],
        periodLengths: [5],
        missedPeriods: 0,
      );
      expect(alerts.where((a) => a.title.contains('Long')), isEmpty);
    });
  });

  // ── Cycle variation ────────────────────────────────────────────────────

  group('Cycle variation check', () {
    test('high variation (> 9 days) triggers warning', () {
      // Min = 24, Max = 34 → variation = 10 (> 9).
      final alerts = HealthChecks.checkAll(
        cycleLengths: [24, 34],
        periodLengths: [5, 5],
        missedPeriods: 0,
      );
      expect(
        alerts.where((a) => a.title.contains('Irregular')),
        hasLength(1),
      );
      expect(
        alerts.firstWhere((a) => a.title.contains('Irregular')).severity,
        AlertSeverity.warning,
      );
    });

    test('variation of exactly 9 days does not trigger alert', () {
      // Min = 25, Max = 34 → variation = 9 (not > 9).
      final alerts = HealthChecks.checkAll(
        cycleLengths: [25, 34],
        periodLengths: [5, 5],
        missedPeriods: 0,
      );
      expect(alerts.where((a) => a.title.contains('Irregular')), isEmpty);
    });

    test('single cycle does not trigger variation check', () {
      final alerts = HealthChecks.checkAll(
        cycleLengths: [20],
        periodLengths: [5],
        missedPeriods: 0,
      );
      expect(alerts.where((a) => a.title.contains('Irregular')), isEmpty);
    });
  });

  // ── Period length ──────────────────────────────────────────────────────

  group('Period length check', () {
    test('long period (> 7 days) triggers warning', () {
      final alerts = HealthChecks.checkAll(
        cycleLengths: [28],
        periodLengths: [8],
        missedPeriods: 0,
      );
      expect(alerts, hasLength(1));
      expect(alerts.first.title, contains('Long period'));
      expect(alerts.first.severity, AlertSeverity.warning);
    });

    test('period of exactly 7 days does not trigger alert', () {
      final alerts = HealthChecks.checkAll(
        cycleLengths: [28],
        periodLengths: [7],
        missedPeriods: 0,
      );
      expect(alerts.where((a) => a.title.contains('Long period')), isEmpty);
    });
  });

  // ── Heavy bleeding ────────────────────────────────────────────────────

  group('Heavy bleeding check', () {
    test('pads > 1 per hour triggers urgent alert', () {
      final alerts = HealthChecks.checkAll(
        cycleLengths: [28],
        periodLengths: [5],
        missedPeriods: 0,
        padsPerHour: 2,
      );
      expect(
        alerts.where((a) => a.title.contains('Heavy bleeding')),
        hasLength(1),
      );
      expect(
        alerts.firstWhere((a) => a.title.contains('Heavy')).severity,
        AlertSeverity.urgent,
      );
    });

    test('pads = 1 per hour does not trigger alert', () {
      final alerts = HealthChecks.checkAll(
        cycleLengths: [28],
        periodLengths: [5],
        missedPeriods: 0,
        padsPerHour: 1,
      );
      expect(alerts.where((a) => a.title.contains('Heavy')), isEmpty);
    });

    test('null padsPerHour does not trigger alert', () {
      final alerts = HealthChecks.checkAll(
        cycleLengths: [28],
        periodLengths: [5],
        missedPeriods: 0,
      );
      expect(alerts.where((a) => a.title.contains('Heavy')), isEmpty);
    });
  });

  // ── Blood color ────────────────────────────────────────────────────────

  group('Blood color check', () {
    test('gray blood color triggers urgent alert', () {
      final alerts = HealthChecks.checkAll(
        cycleLengths: [28],
        periodLengths: [5],
        missedPeriods: 0,
        lastBloodColor: 'gray',
      );
      expect(
        alerts.where((a) => a.title.contains('gray')),
        hasLength(1),
      );
      expect(
        alerts.firstWhere((a) => a.title.contains('gray')).severity,
        AlertSeverity.urgent,
      );
    });

    test('Gray (mixed case) triggers alert', () {
      final alerts = HealthChecks.checkAll(
        cycleLengths: [28],
        periodLengths: [5],
        missedPeriods: 0,
        lastBloodColor: 'Gray',
      );
      expect(alerts.where((a) => a.title.contains('gray')), hasLength(1));
    });

    test('orange blood color triggers warning alert', () {
      final alerts = HealthChecks.checkAll(
        cycleLengths: [28],
        periodLengths: [5],
        missedPeriods: 0,
        lastBloodColor: 'orange',
      );
      expect(
        alerts.where((a) => a.title.contains('orange')),
        hasLength(1),
      );
      expect(
        alerts.firstWhere((a) => a.title.contains('orange')).severity,
        AlertSeverity.warning,
      );
    });

    test('normal blood colors do not trigger alerts', () {
      for (final color in ['bright red', 'dark red', 'brown', 'pink', 'black']) {
        final alerts = HealthChecks.checkAll(
          cycleLengths: [28],
          periodLengths: [5],
          missedPeriods: 0,
          lastBloodColor: color,
        );
        expect(
          alerts.where((a) => a.title.contains('blood color')),
          isEmpty,
          reason: '$color should not trigger an alert',
        );
      }
    });
  });

  // ── Missed periods ─────────────────────────────────────────────────────

  group('Missed periods check', () {
    test('3+ missed periods triggers warning', () {
      final alerts = HealthChecks.checkAll(
        cycleLengths: [28],
        periodLengths: [5],
        missedPeriods: 3,
      );
      expect(
        alerts.where((a) => a.title.contains('Missed')),
        hasLength(1),
      );
      expect(
        alerts.firstWhere((a) => a.title.contains('Missed')).severity,
        AlertSeverity.warning,
      );
    });

    test('2 missed periods does not trigger alert', () {
      final alerts = HealthChecks.checkAll(
        cycleLengths: [28],
        periodLengths: [5],
        missedPeriods: 2,
      );
      expect(alerts.where((a) => a.title.contains('Missed')), isEmpty);
    });
  });

  // ── Large clots ────────────────────────────────────────────────────────

  group('Large clots check', () {
    test('large clots triggers warning', () {
      final alerts = HealthChecks.checkAll(
        cycleLengths: [28],
        periodLengths: [5],
        missedPeriods: 0,
        hasLargeClots: true,
      );
      expect(
        alerts.where((a) => a.title.contains('clots')),
        hasLength(1),
      );
      expect(
        alerts.firstWhere((a) => a.title.contains('clots')).severity,
        AlertSeverity.warning,
      );
    });

    test('no large clots does not trigger alert', () {
      final alerts = HealthChecks.checkAll(
        cycleLengths: [28],
        periodLengths: [5],
        missedPeriods: 0,
        hasLargeClots: false,
      );
      expect(alerts.where((a) => a.title.contains('clots')), isEmpty);
    });
  });

  // ── Multiple issues ────────────────────────────────────────────────────

  group('Multiple issues', () {
    test('return multiple alerts', () {
      final alerts = HealthChecks.checkAll(
        cycleLengths: [18], // short cycle
        periodLengths: [9], // long period
        missedPeriods: 4,   // missed periods
        padsPerHour: 3,     // heavy bleeding
        lastBloodColor: 'gray', // urgent color
        hasLargeClots: true,    // large clots
      );

      // Expected alerts:
      //   1. Short cycle (warning)
      //   2. Long period (warning)
      //   3. Heavy bleeding (urgent)
      //   4. Gray color (urgent)
      //   5. Missed periods (warning)
      //   6. Large clots (warning)
      expect(alerts, hasLength(6));

      final urgentAlerts =
          alerts.where((a) => a.severity == AlertSeverity.urgent);
      expect(urgentAlerts, hasLength(2)); // heavy bleeding + gray

      final warningAlerts =
          alerts.where((a) => a.severity == AlertSeverity.warning);
      expect(warningAlerts, hasLength(4));
    });
  });
}
