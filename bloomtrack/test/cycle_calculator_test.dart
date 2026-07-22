import 'package:flutter_test/flutter_test.dart';

import 'package:bloomtrack/core/constants.dart';
import 'package:bloomtrack/core/utils/cycle_calculator.dart';

void main() {
  // ── avgCycleLength ──────────────────────────────────────────────────

  group('avgCycleLength', () {
    test('returns kDefaultCycleLength for empty list', () {
      expect(
        CycleCalculator.avgCycleLength([]),
        equals(kDefaultCycleLength.toDouble()),
      );
    });

    test('returns single value when list has one element', () {
      expect(CycleCalculator.avgCycleLength([30]), equals(30.0));
    });

    test('averages 3 values correctly', () {
      // (28 + 30 + 26) / 3 = 28.0
      expect(CycleCalculator.avgCycleLength([28, 30, 26]), equals(28.0));
    });

    test('only uses last kCyclesForAverage (6) values for 10 values', () {
      final lengths = [20, 22, 24, 26, 28, 30, 32, 34, 36, 38];
      // Last 6: [28, 30, 32, 34, 36, 38] → sum = 198 → avg = 33.0
      expect(CycleCalculator.avgCycleLength(lengths), equals(33.0));
    });

    test('uses all values when list length equals kCyclesForAverage', () {
      final lengths = [27, 28, 29, 30, 31, 32];
      // (27+28+29+30+31+32) / 6 = 177 / 6 = 29.5
      expect(CycleCalculator.avgCycleLength(lengths), equals(29.5));
    });
  });

  // ── avgPeriodLength ─────────────────────────────────────────────────

  group('avgPeriodLength', () {
    test('returns kDefaultPeriodLength for empty list', () {
      expect(
        CycleCalculator.avgPeriodLength([]),
        equals(kDefaultPeriodLength.toDouble()),
      );
    });

    test('returns single value when list has one element', () {
      expect(CycleCalculator.avgPeriodLength([4]), equals(4.0));
    });

    test('averages 3 values correctly', () {
      // (5 + 6 + 4) / 3 = 5.0
      expect(CycleCalculator.avgPeriodLength([5, 6, 4]), equals(5.0));
    });

    test('only uses last kCyclesForAverage values for 10 values', () {
      final lengths = [3, 4, 5, 6, 7, 3, 4, 5, 6, 7];
      // Last 6: [3, 4, 5, 6, 7] → wait, [4, 5, 6, 7] → actually last 6:
      // index 4..9 → [7, 3, 4, 5, 6, 7] → sum = 32 → avg ≈ 5.333...
      expect(
        CycleCalculator.avgPeriodLength(lengths),
        closeTo(5.333, 0.01),
      );
    });

    test('uses all values when list length is less than kCyclesForAverage', () {
      expect(CycleCalculator.avgPeriodLength([4, 6]), equals(5.0));
    });
  });

  // ── nextPeriodStart ─────────────────────────────────────────────────

  group('nextPeriodStart', () {
    test('adds avgCycleLen days to last period start', () {
      final last = DateTime(2026, 6, 1);
      final next = CycleCalculator.nextPeriodStart(last, 28.0);
      expect(next, equals(DateTime(2026, 6, 29)));
    });

    test('rounds fractional cycle length', () {
      final last = DateTime(2026, 6, 1);
      // 28.6 rounds to 29
      final next = CycleCalculator.nextPeriodStart(last, 28.6);
      expect(next, equals(DateTime(2026, 6, 30)));
    });

    test('handles month boundary', () {
      final last = DateTime(2026, 1, 20);
      final next = CycleCalculator.nextPeriodStart(last, 28.0);
      expect(next, equals(DateTime(2026, 2, 17)));
    });
  });

  // ── ovulationDay ────────────────────────────────────────────────────

  group('ovulationDay', () {
    test('default luteal phase (14 days before next period)', () {
      final nextPeriod = DateTime(2026, 7, 1);
      final ovulation = CycleCalculator.ovulationDay(nextPeriod);
      // July 1 − 14 = June 17
      expect(ovulation, equals(DateTime(2026, 6, 17)));
    });

    test('custom luteal phase of 12 days', () {
      final nextPeriod = DateTime(2026, 7, 1);
      final ovulation = CycleCalculator.ovulationDay(
        nextPeriod,
        lutealPhase: 12,
      );
      // July 1 − 12 = June 19
      expect(ovulation, equals(DateTime(2026, 6, 19)));
    });

    test('custom luteal phase of 16 days', () {
      final nextPeriod = DateTime(2026, 7, 1);
      final ovulation = CycleCalculator.ovulationDay(
        nextPeriod,
        lutealPhase: 16,
      );
      // July 1 − 16 = June 15
      expect(ovulation, equals(DateTime(2026, 6, 15)));
    });
  });

  // ── fertileWindow ───────────────────────────────────────────────────

  group('fertileWindow', () {
    test('returns 6-day range ending on ovulation day', () {
      final ovulation = DateTime(2026, 6, 17);
      final (start, end) = CycleCalculator.fertileWindow(ovulation);

      // Start: June 17 − 5 = June 12
      expect(start, equals(DateTime(2026, 6, 12)));
      // End: ovulation day itself
      expect(end, equals(DateTime(2026, 6, 17)));
    });

    test('spans month boundary correctly', () {
      final ovulation = DateTime(2026, 7, 3);
      final (start, end) = CycleCalculator.fertileWindow(ovulation);

      expect(start, equals(DateTime(2026, 6, 28)));
      expect(end, equals(DateTime(2026, 7, 3)));
    });
  });

  // ── fertilityLevelForDate ───────────────────────────────────────────

  group('fertilityLevelForDate', () {
    // Scenario: last period June 1, cycle 28 days, period 5 days.
    // Next period: June 29.
    // Ovulation: June 29 − 14 = June 15.
    // Fertile window: June 10 – June 15.
    // Period: June 1 – June 5 (5 days).
    final lastPeriod = DateTime(2026, 6, 1);
    const avgCycle = 28.0;
    const avgPeriod = 5.0;

    test('period day returns FertilityLevel.period', () {
      expect(
        CycleCalculator.fertilityLevelForDate(
          date: DateTime(2026, 6, 3),
          lastPeriodStart: lastPeriod,
          avgCycleLength: avgCycle,
          avgPeriodLength: avgPeriod,
        ),
        equals(FertilityLevel.period),
      );
    });

    test('first day of period returns FertilityLevel.period', () {
      expect(
        CycleCalculator.fertilityLevelForDate(
          date: DateTime(2026, 6, 1),
          lastPeriodStart: lastPeriod,
          avgCycleLength: avgCycle,
          avgPeriodLength: avgPeriod,
        ),
        equals(FertilityLevel.period),
      );
    });

    test('ovulation day returns FertilityLevel.peak', () {
      expect(
        CycleCalculator.fertilityLevelForDate(
          date: DateTime(2026, 6, 15),
          lastPeriodStart: lastPeriod,
          avgCycleLength: avgCycle,
          avgPeriodLength: avgPeriod,
        ),
        equals(FertilityLevel.peak),
      );
    });

    test('day in fertile window (not peak) returns FertilityLevel.high', () {
      // June 12 is inside fertile window [June 10 – June 15), not the peak.
      expect(
        CycleCalculator.fertilityLevelForDate(
          date: DateTime(2026, 6, 12),
          lastPeriodStart: lastPeriod,
          avgCycleLength: avgCycle,
          avgPeriodLength: avgPeriod,
        ),
        equals(FertilityLevel.high),
      );
    });

    test('post-ovulation day returns FertilityLevel.postOvulation', () {
      // June 20 — after ovulation (June 15), before next period (June 29).
      expect(
        CycleCalculator.fertilityLevelForDate(
          date: DateTime(2026, 6, 20),
          lastPeriodStart: lastPeriod,
          avgCycleLength: avgCycle,
          avgPeriodLength: avgPeriod,
        ),
        equals(FertilityLevel.postOvulation),
      );
    });

    test('follicular phase day returns FertilityLevel.low', () {
      // June 7 — after period (ends June 5) but before fertile window (June 10).
      expect(
        CycleCalculator.fertilityLevelForDate(
          date: DateTime(2026, 6, 7),
          lastPeriodStart: lastPeriod,
          avgCycleLength: avgCycle,
          avgPeriodLength: avgPeriod,
        ),
        equals(FertilityLevel.low),
      );
    });
  });

  // ── daysUntilNextPeriod ─────────────────────────────────────────────

  group('daysUntilNextPeriod', () {
    test('returns positive days for future period', () {
      // Use a date far in the future so it is always ahead of "today".
      final lastPeriod = DateTime.now().subtract(const Duration(days: 10));
      final days = CycleCalculator.daysUntilNextPeriod(lastPeriod, 28.0);
      expect(days, equals(18));
    });

    test('returns 0 when next period is today or past', () {
      final lastPeriod = DateTime.now().subtract(const Duration(days: 30));
      final days = CycleCalculator.daysUntilNextPeriod(lastPeriod, 28.0);
      expect(days, equals(0));
    });
  });

  // ── currentCycleDay ─────────────────────────────────────────────────

  group('currentCycleDay', () {
    test('returns 1 on the first day of the period', () {
      final today = DateTime.now();
      final start = DateTime(today.year, today.month, today.day);
      expect(CycleCalculator.currentCycleDay(start), equals(1));
    });

    test('returns correct day mid-cycle', () {
      final today = DateTime.now();
      final start = DateTime(today.year, today.month, today.day)
          .subtract(const Duration(days: 13));
      expect(CycleCalculator.currentCycleDay(start), equals(14));
    });

    test('returns 1 when last period start is in the future', () {
      final futureDate = DateTime.now().add(const Duration(days: 5));
      expect(CycleCalculator.currentCycleDay(futureDate), equals(1));
    });
  });

  // ── isPeriodDay ─────────────────────────────────────────────────────

  group('isPeriodDay', () {
    test('first day of period is a period day', () {
      final start = DateTime(2026, 6, 1);
      expect(CycleCalculator.isPeriodDay(start, start, 5.0), isTrue);
    });

    test('last day of period is a period day', () {
      final start = DateTime(2026, 6, 1);
      // Period length 5 → days 1–5 → June 1, 2, 3, 4, 5.
      expect(
        CycleCalculator.isPeriodDay(DateTime(2026, 6, 5), start, 5.0),
        isTrue, // June 5 is day 5.
      );
      // June 6 is the day after.
      expect(
        CycleCalculator.isPeriodDay(DateTime(2026, 6, 6), start, 5.0),
        isFalse,
      );
    });

    test('day after period is not a period day', () {
      final start = DateTime(2026, 6, 1);
      expect(
        CycleCalculator.isPeriodDay(DateTime(2026, 6, 6), start, 5.0),
        isFalse,
      );
    });

    test('day before period is not a period day', () {
      final start = DateTime(2026, 6, 1);
      expect(
        CycleCalculator.isPeriodDay(DateTime(2026, 5, 31), start, 5.0),
        isFalse,
      );
    });

    test('handles fractional period length by rounding', () {
      final start = DateTime(2026, 6, 1);
      // 4.6 rounds to 5, so June 1–5 (end-exclusive at June 6).
      expect(
        CycleCalculator.isPeriodDay(DateTime(2026, 6, 5), start, 4.6),
        isTrue,
      );
      expect(
        CycleCalculator.isPeriodDay(DateTime(2026, 6, 4), start, 4.6),
        isTrue,
      );
    });
  });
}
