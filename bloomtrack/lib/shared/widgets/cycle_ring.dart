import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:bloomtrack/core/theme.dart';

/// A circular ring that visually represents cycle progress.
///
/// The filled arc shows how far through the cycle the user is.
/// Period days are painted in pink/red; remaining progress in a lighter hue.
class CycleRing extends StatelessWidget {
  const CycleRing({
    required this.currentDay,
    required this.totalDays,
    this.periodDays = 5,
    this.size = 200,
    super.key,
  });

  /// The current day in the cycle (1-based).
  final int currentDay;

  /// Total number of days in the cycle.
  final int totalDays;

  /// Number of period (bleeding) days at the start of the cycle.
  final int periodDays;

  /// Diameter of the ring widget.
  final double size;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _CycleRingPainter(
          currentDay: currentDay,
          totalDays: totalDays,
          periodDays: periodDays,
          trackColor: theme.colorScheme.onSurface.withValues(alpha: 0.08),
          periodColor: AppColors.period,
          progressColor: AppColors.primaryLight,
          isDark: theme.brightness == Brightness.dark,
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '$currentDay',
                style: theme.textTheme.displayLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: theme.colorScheme.primary,
                  height: 1,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                currentDay == 1 ? 'Day 1' : 'Day $currentDay',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color:
                      theme.colorScheme.onSurface.withValues(alpha: 0.55),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'of $totalDays',
                style: theme.textTheme.bodySmall?.copyWith(
                  color:
                      theme.colorScheme.onSurface.withValues(alpha: 0.4),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Custom painter that draws the cycle ring arcs.
class _CycleRingPainter extends CustomPainter {
  _CycleRingPainter({
    required this.currentDay,
    required this.totalDays,
    required this.periodDays,
    required this.trackColor,
    required this.periodColor,
    required this.progressColor,
    required this.isDark,
  });

  final int currentDay;
  final int totalDays;
  final int periodDays;
  final Color trackColor;
  final Color periodColor;
  final Color progressColor;
  final bool isDark;

  static const double _strokeWidth = 12.0;
  static const double _startAngle = -math.pi / 2; // 12 o'clock

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (math.min(size.width, size.height) - _strokeWidth) / 2;
    final rect = Rect.fromCircle(center: center, radius: radius);

    // Background track
    final trackPaint = Paint()
      ..color = trackColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = _strokeWidth
      ..strokeCap = StrokeCap.round;
    canvas.drawCircle(center, radius, trackPaint);

    final fullSweep = 2 * math.pi;
    // Guard against divide-by-zero and clamp to [0, 1] so a cycle that runs
    // longer than its average length doesn't sweep the arc past a full circle.
    final safeTotal = totalDays <= 0 ? 1 : totalDays;
    final dayFraction = (currentDay / safeTotal).clamp(0.0, 1.0);
    final periodFraction = (periodDays / safeTotal).clamp(0.0, 1.0);

    // Determine how much of the progress falls within period days.
    final periodSweep = periodFraction * fullSweep;
    final progressSweep = dayFraction * fullSweep;

    if (currentDay <= periodDays) {
      // Still within period days — draw one arc in period color.
      final paint = Paint()
        ..color = periodColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = _strokeWidth
        ..strokeCap = StrokeCap.round;
      canvas.drawArc(rect, _startAngle, progressSweep, false, paint);
    } else {
      // Period portion
      final periodPaint = Paint()
        ..color = periodColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = _strokeWidth
        ..strokeCap = StrokeCap.round;
      canvas.drawArc(rect, _startAngle, periodSweep, false, periodPaint);

      // Remaining progress beyond period days
      final progressPaint = Paint()
        ..color = progressColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = _strokeWidth
        ..strokeCap = StrokeCap.round;
      canvas.drawArc(
        rect,
        _startAngle + periodSweep,
        progressSweep - periodSweep,
        false,
        progressPaint,
      );
    }
  }

  @override
  bool shouldRepaint(_CycleRingPainter oldDelegate) =>
      oldDelegate.currentDay != currentDay ||
      oldDelegate.totalDays != totalDays ||
      oldDelegate.periodDays != periodDays ||
      oldDelegate.isDark != isDark;
}
