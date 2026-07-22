// BloomTrack — Cycle calculation engine.
//
// Pure Dart, no Flutter imports. All methods are static and side-effect free,
// making them trivially testable and safe for isolate use.

import 'package:bloomtrack/core/constants.dart';

/// Provides all cycle-related calculations: averages, predictions,
/// fertility windows, and day classification.
class CycleCalculator {
  CycleCalculator._();

  // ── Averages ──────────────────────────────────────────────────────────

  /// Calculate the average cycle length from a list of observed cycle lengths.
  ///
  /// Only the most recent [kCyclesForAverage] values are used.
  /// Returns [kDefaultCycleLength] as a double if [cycleLengths] is empty.
  static double avgCycleLength(List<int> cycleLengths) {
    if (cycleLengths.isEmpty) return kDefaultCycleLength.toDouble();

    final recent = cycleLengths.length <= kCyclesForAverage
        ? cycleLengths
        : cycleLengths.sublist(cycleLengths.length - kCyclesForAverage);

    return recent.reduce((a, b) => a + b) / recent.length;
  }

  /// Calculate the average period length from a list of observed period lengths.
  ///
  /// Only the most recent [kCyclesForAverage] values are used.
  /// Returns [kDefaultPeriodLength] as a double if [periodLengths] is empty.
  static double avgPeriodLength(List<int> periodLengths) {
    if (periodLengths.isEmpty) return kDefaultPeriodLength.toDouble();

    final recent = periodLengths.length <= kCyclesForAverage
        ? periodLengths
        : periodLengths.sublist(periodLengths.length - kCyclesForAverage);

    return recent.reduce((a, b) => a + b) / recent.length;
  }

  // ── Predictions ───────────────────────────────────────────────────────

  /// Predict the start date of the next period.
  ///
  /// Simply adds [avgCycleLen] (rounded) days to [lastPeriodStart].
  static DateTime nextPeriodStart(
    DateTime lastPeriodStart,
    double avgCycleLen,
  ) {
    return _dateOnly(
      lastPeriodStart.add(Duration(days: avgCycleLen.round())),
    );
  }

  /// Estimate the ovulation date.
  ///
  /// Ovulation is assumed to occur [lutealPhase] days before the next period
  /// starts. The default luteal phase length is [kDefaultLutealPhase] (14 days).
  static DateTime ovulationDay(
    DateTime nextPeriodStartDate, {
    int lutealPhase = kDefaultLutealPhase,
  }) {
    return _dateOnly(
      nextPeriodStartDate.subtract(Duration(days: lutealPhase)),
    );
  }

  /// Calculate the fertile window as a 6-day range.
  ///
  /// Returns a record `(start, end)` where:
  /// - `start` = ovulation date − 5 days
  /// - `end`   = ovulation date itself
  ///
  /// This covers the ~5 days sperm can survive plus the ovulation day.
  static (DateTime start, DateTime end) fertileWindow(DateTime ovulationDate) {
    final start = _dateOnly(ovulationDate.subtract(const Duration(days: 5)));
    final end = _dateOnly(ovulationDate);
    return (start, end);
  }

  // ── Day classification ────────────────────────────────────────────────

  /// Determine the [FertilityLevel] for a specific [date].
  ///
  /// Classification rules (evaluated in order):
  /// 1. **Period** — within the predicted period window.
  /// 2. **Peak** — the ovulation day itself.
  /// 3. **High** — within the fertile window (ovulation − 5 … ovulation − 1).
  /// 4. **Post-ovulation** — after ovulation until next period.
  /// 5. **Low** — everything else (follicular phase after period ends).
  static FertilityLevel fertilityLevelForDate({
    required DateTime date,
    required DateTime lastPeriodStart,
    required double avgCycleLength,
    required double avgPeriodLength,
    int lutealPhase = kDefaultLutealPhase,
  }) {
    final normDate = _dateOnly(date);
    final normLast = _dateOnly(lastPeriodStart);

    // Period window.
    if (isPeriodDay(normDate, normLast, avgPeriodLength)) {
      return FertilityLevel.period;
    }

    final nextStart = nextPeriodStart(normLast, avgCycleLength);
    final ovulation = ovulationDay(nextStart, lutealPhase: lutealPhase);
    final (fertileStart, fertileEnd) = fertileWindow(ovulation);

    // Peak — ovulation day.
    if (normDate == ovulation) {
      return FertilityLevel.peak;
    }

    // High — inside fertile window but not peak.
    if (!normDate.isBefore(fertileStart) && normDate.isBefore(fertileEnd)) {
      return FertilityLevel.high;
    }

    // Post-ovulation — after ovulation, before next period.
    if (normDate.isAfter(ovulation) && normDate.isBefore(nextStart)) {
      return FertilityLevel.postOvulation;
    }

    // Low — follicular phase (between period end and fertile window).
    return FertilityLevel.low;
  }

  // ── Convenience helpers ───────────────────────────────────────────────

  /// Number of days until the next predicted period.
  ///
  /// Returns 0 if the next period is today or in the past.
  static int daysUntilNextPeriod(DateTime lastPeriodStart, double avgCycleLen) {
    final next = nextPeriodStart(lastPeriodStart, avgCycleLen);
    final today = _dateOnly(DateTime.now());
    final diff = next.difference(today).inDays;
    return diff < 0 ? 0 : diff;
  }

  /// The current cycle day (1-based).
  ///
  /// Day 1 is the first day of the last period. If [lastPeriodStart] is in
  /// the future, returns 1.
  static int currentCycleDay(DateTime lastPeriodStart) {
    final today = _dateOnly(DateTime.now());
    final start = _dateOnly(lastPeriodStart);
    final diff = today.difference(start).inDays;
    return diff < 0 ? 1 : diff + 1;
  }

  /// Whether [date] falls within the predicted period window.
  ///
  /// The period window runs from [periodStart] for [avgPeriodLen] days
  /// (rounded).
  static bool isPeriodDay(
    DateTime date,
    DateTime periodStart,
    double avgPeriodLen,
  ) {
    final normDate = _dateOnly(date);
    final normStart = _dateOnly(periodStart);
    final periodEnd = normStart.add(Duration(days: avgPeriodLen.round()));

    // [normStart, periodEnd) — start-inclusive, end-exclusive.
    return !normDate.isBefore(normStart) && normDate.isBefore(periodEnd);
  }

  // ── Internal ──────────────────────────────────────────────────────────

  /// Strip time components, returning local midnight on the same calendar date.
  static DateTime _dateOnly(DateTime dt) => DateTime(dt.year, dt.month, dt.day);
}
