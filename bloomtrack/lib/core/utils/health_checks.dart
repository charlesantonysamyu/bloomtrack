// BloomTrack — Health-alert engine.
//
// Evaluates cycle and period data against medical reference thresholds
// (see [Disclaimers.seeDoctor] in constants.dart) and returns actionable
// alerts for the user. Pure Dart — no Flutter imports.

import 'package:bloomtrack/core/constants.dart';

// ── Alert model ─────────────────────────────────────────────────────────

/// Severity of a health alert.
enum AlertSeverity { info, warning, urgent }

/// A single health alert surfaced to the user.
class HealthAlert {
  /// Short title displayed in the alert header.
  final String title;

  /// Detailed message explaining the alert and suggested action.
  final String message;

  /// How critical this alert is.
  final AlertSeverity severity;

  const HealthAlert({
    required this.title,
    required this.message,
    required this.severity,
  });

  @override
  String toString() => 'HealthAlert($severity: $title)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HealthAlert &&
          title == other.title &&
          message == other.message &&
          severity == other.severity;

  @override
  int get hashCode => Object.hash(title, message, severity);
}

// ── Health-check engine ─────────────────────────────────────────────────

/// Runs medical-reference health checks against the user's cycle data.
///
/// All methods are static and deterministic (no I/O, no side effects).
class HealthChecks {
  HealthChecks._();

  /// Evaluate all health conditions and return matching [HealthAlert]s.
  ///
  /// Parameters:
  /// - [cycleLengths] — observed cycle lengths (most recent last).
  /// - [periodLengths] — observed period lengths (most recent last).
  /// - [missedPeriods] — consecutive missed periods count.
  /// - [lastBloodColor] — most recently reported blood colour (name string).
  /// - [padsPerHour] — pad / tampon changes per hour during heaviest flow.
  /// - [hasLargeClots] — whether large clots (> quarter-sized) were reported.
  static List<HealthAlert> checkAll({
    required List<int> cycleLengths,
    required List<int> periodLengths,
    required int missedPeriods,
    String? lastBloodColor,
    int? padsPerHour,
    bool? hasLargeClots,
  }) {
    final alerts = <HealthAlert>[];

    _checkCycleLengths(cycleLengths, alerts);
    _checkCycleVariation(cycleLengths, alerts);
    _checkPeriodLengths(periodLengths, alerts);
    _checkHeavyBleeding(padsPerHour, alerts);
    _checkBloodColor(lastBloodColor, alerts);
    _checkMissedPeriods(missedPeriods, alerts);
    _checkLargeClots(hasLargeClots, alerts);

    return alerts;
  }

  // ── Individual checks ─────────────────────────────────────────────────

  /// Flag cycles shorter than [kMinNormalCycleLength] or longer than
  /// [kMaxNormalCycleLength].
  static void _checkCycleLengths(
    List<int> cycleLengths,
    List<HealthAlert> alerts,
  ) {
    if (cycleLengths.isEmpty) return;

    final last = cycleLengths.last;

    if (last < kMinNormalCycleLength) {
      alerts.add(const HealthAlert(
        title: 'Short cycle detected',
        message:
            'Your most recent cycle was shorter than 21 days. Short cycles '
            'can be caused by stress, hormonal changes, or other conditions. '
            'Consider consulting a healthcare provider if this persists.',
        severity: AlertSeverity.warning,
      ));
    }

    if (last > kMaxNormalCycleLength) {
      alerts.add(const HealthAlert(
        title: 'Long cycle detected',
        message:
            'Your most recent cycle was longer than 35 days. Long cycles '
            'can indicate hormonal imbalances such as PCOS. Consider '
            'consulting a healthcare provider if this persists.',
        severity: AlertSeverity.warning,
      ));
    }
  }

  /// Flag when the difference between the longest and shortest recent
  /// cycles exceeds [kCycleVariationAlert] days.
  static void _checkCycleVariation(
    List<int> cycleLengths,
    List<HealthAlert> alerts,
  ) {
    if (cycleLengths.length < 2) return;

    final recent = cycleLengths.length <= kCyclesForAverage
        ? cycleLengths
        : cycleLengths.sublist(cycleLengths.length - kCyclesForAverage);

    final sorted = List<int>.from(recent)..sort();
    final variation = sorted.last - sorted.first;

    if (variation > kCycleVariationAlert) {
      alerts.add(HealthAlert(
        title: 'Irregular cycle pattern',
        message:
            'Your recent cycles vary by $variation days (more than '
            '$kCycleVariationAlert). Highly irregular cycles may warrant '
            'a conversation with your doctor.',
        severity: AlertSeverity.warning,
      ));
    }
  }

  /// Flag periods longer than [kMaxNormalPeriodLength].
  static void _checkPeriodLengths(
    List<int> periodLengths,
    List<HealthAlert> alerts,
  ) {
    if (periodLengths.isEmpty) return;

    final last = periodLengths.last;
    if (last > kMaxNormalPeriodLength) {
      alerts.add(const HealthAlert(
        title: 'Long period detected',
        message:
            'Your most recent period lasted more than 7 days. Prolonged '
            'periods can lead to anemia and may signal an underlying '
            'condition. Please consult a healthcare provider.',
        severity: AlertSeverity.warning,
      ));
    }
  }

  /// Flag soaking through more than one pad / tampon per hour.
  static void _checkHeavyBleeding(
    int? padsPerHour,
    List<HealthAlert> alerts,
  ) {
    if (padsPerHour == null) return;

    if (padsPerHour > 1) {
      alerts.add(const HealthAlert(
        title: 'Heavy bleeding',
        message:
            'Soaking through more than one pad or tampon per hour is '
            'considered heavy menstrual bleeding (menorrhagia). Please '
            'seek medical attention promptly.',
        severity: AlertSeverity.urgent,
      ));
    }
  }

  /// Flag gray or orange blood colours as medically concerning.
  static void _checkBloodColor(
    String? lastBloodColor,
    List<HealthAlert> alerts,
  ) {
    if (lastBloodColor == null) return;

    final color = lastBloodColor.toLowerCase();

    if (color == 'gray') {
      alerts.add(const HealthAlert(
        title: 'Unusual blood color — gray',
        message:
            'Gray discharge may indicate bacterial vaginosis or, during '
            'pregnancy, a possible miscarriage. Please consult a '
            'healthcare provider as soon as possible.',
        severity: AlertSeverity.urgent,
      ));
    }

    if (color == 'orange') {
      alerts.add(const HealthAlert(
        title: 'Unusual blood color — orange',
        message:
            'Orange discharge can indicate an infection, especially when '
            'accompanied by an unusual odor. Consider consulting a '
            'healthcare provider.',
        severity: AlertSeverity.warning,
      ));
    }
  }

  /// Flag [kMissedPeriodsAlert] or more consecutive missed periods.
  static void _checkMissedPeriods(
    int missedPeriods,
    List<HealthAlert> alerts,
  ) {
    if (missedPeriods >= kMissedPeriodsAlert) {
      alerts.add(HealthAlert(
        title: 'Missed periods',
        message:
            'You have missed $missedPeriods consecutive periods. This could '
            'be due to pregnancy, stress, significant weight change, or a '
            'hormonal condition. Please consult a healthcare provider.',
        severity: AlertSeverity.warning,
      ));
    }
  }

  /// Flag large clots (larger than quarter-sized).
  static void _checkLargeClots(
    bool? hasLargeClots,
    List<HealthAlert> alerts,
  ) {
    if (hasLargeClots != true) return;

    alerts.add(const HealthAlert(
      title: 'Large blood clots',
      message:
          'Passing blood clots larger than a quarter can be a sign of '
          'heavy menstrual bleeding or other conditions. Consider '
          'consulting a healthcare provider.',
      severity: AlertSeverity.warning,
    ));
  }
}
