import 'package:flutter/material.dart';

import 'package:bloomtrack/core/theme.dart';
import 'package:bloomtrack/features/logging/log_period_sheet.dart';
import 'package:bloomtrack/features/logging/log_symptoms_sheet.dart';
import 'package:bloomtrack/features/logging/log_intimacy_sheet.dart';
import 'package:bloomtrack/features/logging/log_mucus_sheet.dart';
import 'package:bloomtrack/features/logging/log_bbt_opk_sheet.dart';

import 'package:intl/intl.dart';

/// Quick-log screen — a grid of tappable action cards for fast daily logging.
class LogSheet extends StatelessWidget {
  final DateTime? initialDate;

  const LogSheet({super.key, this.initialDate});

  static void show(BuildContext context, {DateTime? initialDate}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.85,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        clipBehavior: Clip.antiAlias,
        child: LogSheet(initialDate: initialDate),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final actions = _getLogActions(initialDate);
    final dateStr = initialDate != null ? DateFormat.yMMMMd().format(initialDate!) : 'today';

    return Scaffold(
      appBar: AppBar(
        title: Text(initialDate != null ? 'Log for ${DateFormat.yMMMd().format(initialDate!)}' : 'Log'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'What would you like to log?',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Tap an option to record data for $dateStr.',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
              const SizedBox(height: 20),
              ...actions.map(
                (action) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _LogActionCard(
                    icon: action.icon,
                    title: action.title,
                    subtitle: action.subtitle,
                    color: action.color,
                    onTap: action.onTap != null 
                        ? () => action.onTap!(context) 
                        : null,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Data model for a log action card.
class _LogAction {
  const _LogAction({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final void Function(BuildContext)? onTap;
}

/// Predefined log actions with initialDate.
List<_LogAction> _getLogActions(DateTime? initialDate) => [
  _LogAction(
    icon: Icons.water_drop_rounded,
    title: 'Log Period',
    subtitle: 'Flow level and blood color',
    color: AppColors.period,
    onTap: (ctx) => showPeriodLogSheet(ctx, initialDate: initialDate),
  ),
  _LogAction(
    icon: Icons.sentiment_satisfied_alt_rounded,
    title: 'Log Symptoms',
    subtitle: 'Mood, pain, energy & more',
    color: AppColors.secondary,
    onTap: (ctx) => showSymptomsLogSheet(ctx, initialDate: initialDate),
  ),
  _LogAction(
    icon: Icons.favorite_rounded,
    title: 'Log Intimacy',
    subtitle: 'Activity and protection used',
    color: AppColors.intercourse,
    onTap: (ctx) => showIntimacyLogSheet(ctx, initialDate: initialDate),
  ),
  _LogAction(
    icon: Icons.opacity_rounded,
    title: 'Log Mucus',
    subtitle: 'Cervical mucus observations',
    color: AppColors.info,
    onTap: (ctx) => showMucusLogSheet(ctx, initialDate: initialDate),
  ),
  _LogAction(
    icon: Icons.thermostat_rounded,
    title: 'Log Temperature',
    subtitle: 'Basal body temperature',
    color: AppColors.accent,
    onTap: (ctx) => showBbtOpkLogSheet(ctx, initialDate: initialDate),
  ),
  _LogAction(
    icon: Icons.science_rounded,
    title: 'Log OPK',
    subtitle: 'Ovulation predictor kit result',
    color: AppColors.peakFertility,
    onTap: (ctx) => showBbtOpkLogSheet(ctx, initialDate: initialDate),
  ),
];

/// A single tappable log-action card.
class _LogActionCard extends StatelessWidget {
  const _LogActionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap ?? () {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text('$title — coming soon!'),
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                duration: const Duration(seconds: 2),
              ),
            );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 26),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurface
                            .withValues(alpha: 0.55),
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color:
                    theme.colorScheme.onSurface.withValues(alpha: 0.3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
