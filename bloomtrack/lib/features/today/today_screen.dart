import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:bloomtrack/core/constants.dart';
import 'package:bloomtrack/core/theme.dart';
import 'package:bloomtrack/core/utils/cycle_calculator.dart';
import 'package:bloomtrack/core/utils/health_checks.dart';
import 'package:bloomtrack/data/database.dart';
import 'package:bloomtrack/data/providers/providers.dart';
import 'package:bloomtrack/features/logging/log_sheet.dart';
import 'package:bloomtrack/features/logging/log_period_sheet.dart';
import 'package:bloomtrack/shared/widgets/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bloomtrack/core/services/notification_service.dart';

/// BloomTrack home screen — shows a welcome message, cycle ring,
/// and a privacy disclaimer card.
class TodayScreen extends ConsumerWidget {
  const TodayScreen({super.key});

  Future<void> _checkAndScheduleReminder(Cycle cycle) async {
    final cycleLength = cycle.cycleLength ?? kDefaultCycleLength;
    final daysRemaining = CycleCalculator.daysUntilNextPeriod(
      cycle.startDate,
      cycleLength.toDouble(),
    );

    if (daysRemaining <= 3 && daysRemaining > 0) {
      final prefs = await SharedPreferences.getInstance();

      // Respect the user's notification preference — don't fire reminders the
      // user never opted into.
      final enabled = prefs.getBool('period_approaching') ?? false;
      if (!enabled) return;

      final todayStr = DateTime.now().toIso8601String().substring(0, 10);
      final lastReminder = prefs.getString('lastReminderDate');

      if (lastReminder != todayStr) {
        await prefs.setString('lastReminderDate', todayStr);
        // Ensure the plugin is initialised before showing anything.
        await NotificationService.init();
        await NotificationService.scheduleReminder();
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    final activeCycleAsync = ref.watch(activeCycleProvider);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.local_florist_rounded,
              color: colorScheme.primary,
              size: 28,
            ),
            const SizedBox(width: 8),
            Text(
              'BloomTrack',
              style: theme.textTheme.headlineMedium?.copyWith(
                color: colorScheme.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            children: [
              activeCycleAsync.when(
                data: (cycle) {
                  if (cycle == null) {
                    return _buildEmptyState(context);
                  }
                  _checkAndScheduleReminder(cycle);
                  return _buildActiveCycle(context, cycle, ref);
                },
                loading: () => const Padding(
                  padding: EdgeInsets.all(32.0),
                  child: Center(child: CircularProgressIndicator()),
                ),
                error: (error, stack) => Text('Error loading cycle data: $error'),
              ),
              const SizedBox(height: 24),

              // ── Privacy disclaimer ──
              Card(
                color: colorScheme.primary.withValues(alpha: 0.06),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.lock_rounded,
                        size: 20,
                        color: colorScheme.primary,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          Disclaimers.privacyPromise,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color:
                                colorScheme.onSurface.withValues(alpha: 0.7),
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const LogSheet()),
          );
        },
        icon: const Icon(Icons.add_rounded),
        label: const Text('Log Today'),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 32,
        ),
        child: Column(
          children: [
            Icon(
              Icons.spa_rounded,
              size: 48,
              color: colorScheme.primary,
            ),
            const SizedBox(height: 16),
            Text(
              'Welcome to BloomTrack',
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'To get started, log the first day of your last period.',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: colorScheme.onSurface.withValues(alpha: 0.6),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            FilledButton(
               onPressed: () {
                 showPeriodLogSheet(context);
               }, 
               child: const Text('Log First Period')
            )
          ],
        ),
      ),
    );
  }

  Widget _buildActiveCycle(BuildContext context, Cycle cycle, WidgetRef ref) {
     final theme = Theme.of(context);
     final colorScheme = theme.colorScheme;
     
     final currentDay = CycleCalculator.currentCycleDay(cycle.startDate);
     final cycleLength = cycle.cycleLength ?? kDefaultCycleLength;
     final periodLength = cycle.periodLength ?? kDefaultPeriodLength;

     final recentCycles = ref.watch(recentCyclesProvider).value ?? [];
     final latestFlowLog = ref.watch(latestFlowLogProvider).value;
     
     final completedCycles = recentCycles.reversed.toList();
     
     final cycleLengths = completedCycles
         .where((c) => c.cycleLength != null)
         .map((c) => c.cycleLength!)
         .toList();
     
     final periodLengths = completedCycles
         .where((c) => c.periodLength != null)
         .map((c) => c.periodLength!)
         .toList();

     var missedPeriods = (DateTime.now().difference(cycle.startDate).inDays / (cycle.cycleLength ?? 28)).floor() - 1;
     if (missedPeriods < 0) missedPeriods = 0;

     final alerts = HealthChecks.checkAll(
       cycleLengths: cycleLengths,
       periodLengths: periodLengths,
       missedPeriods: missedPeriods,
       lastBloodColor: latestFlowLog?.bloodColor,
       hasLargeClots: latestFlowLog?.hasClots,
       padsPerHour: (latestFlowLog?.padsCount ?? 0) >= 8 ? 2 : 0,
     ).where((a) => a.severity == AlertSeverity.urgent || a.severity == AlertSeverity.warning).toList();
     
     return Column(
        children: [
           // ── Cycle ring preview ──
           CycleRing(
             currentDay: currentDay,
             totalDays: cycleLength,
             periodDays: periodLength,
           ),

           const SizedBox(height: 24),

           if (cycle.endDate == null) ...[
             FilledButton.tonal(
               onPressed: () async {
                 final pickedDate = await showDatePicker(
                   context: context,
                   initialDate: DateTime.now(),
                   firstDate: cycle.startDate,
                   lastDate: DateTime.now(),
                 );
                 if (pickedDate != null) {
                   final normalizedPicked = DateTime(pickedDate.year, pickedDate.month, pickedDate.day);
                   final normalizedStart = DateTime(cycle.startDate.year, cycle.startDate.month, cycle.startDate.day);
                   final calcPeriodLength = normalizedPicked.difference(normalizedStart).inDays + 1;
                   ref.read(cycleDaoProvider).updatePeriodLength(cycle.id, calcPeriodLength);
                 }
               },
               child: const Text('End Period'),
             ),
             const SizedBox(height: 24),
           ],

           // ── Quick stats row ──
           Row(
             children: [
               Expanded(
                 child: _StatCard(
                   icon: Icons.timer_outlined,
                   label: 'Cycle length',
                   value: '$cycleLength days',
                   color: colorScheme.primary,
                 ),
               ),
               const SizedBox(width: 12),
               Expanded(
                 child: _StatCard(
                   icon: Icons.water_drop_outlined,
                   label: 'Period length',
                   value: '$periodLength days',
                   color: AppColors.accent,
                 ),
               ),
             ],
           ),

           if (alerts.isNotEmpty) ...[
             const SizedBox(height: 24),
             ...alerts.map((alert) => _buildAlertCard(context, alert)),
           ],
        ]
     );
  }

  Widget _buildAlertCard(BuildContext context, HealthAlert alert) {
    final isUrgent = alert.severity == AlertSeverity.urgent;
    final color = isUrgent ? Colors.red.shade700 : Colors.orange.shade800;
    final bgColor = isUrgent ? Colors.red.shade50 : Colors.orange.shade50;
    final iconColor = isUrgent ? Colors.red : Colors.orange;

    return Card(
      color: bgColor,
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: color.withValues(alpha: 0.3), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              isUrgent ? Icons.warning_rounded : Icons.info_outline_rounded,
              color: iconColor,
              size: 28,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    alert.title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: color,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    alert.message,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.black87,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Small stat card used in the quick-stats row.
class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 24, color: color),
            const SizedBox(height: 12),
            Text(
              label,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
