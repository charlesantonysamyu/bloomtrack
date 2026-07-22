import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bloomtrack/core/constants.dart';
import 'package:bloomtrack/core/theme.dart';
import 'package:bloomtrack/core/utils/cycle_calculator.dart';
import 'package:bloomtrack/data/providers/providers.dart';
import 'package:bloomtrack/data/database.dart';

class FertilityScreen extends ConsumerWidget {
  const FertilityScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeCycleAsync = ref.watch(activeCycleProvider);
    final profileAsync = ref.watch(profileProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Fertility Chances'),
      ),
      body: activeCycleAsync.when(
        data: (cycle) {
          if (cycle == null) {
            return _buildEmptyState(context);
          }
          return profileAsync.when(
            data: (profile) {
              if (profile == null) {
                return _buildEmptyState(context);
              }
              return _buildContent(context, cycle, profile);
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, st) => Center(child: Text('Error: $err')),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, st) => Center(child: Text('Error: $err')),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.calendar_month, size: 64, color: AppColors.primary),
            const SizedBox(height: 16),
            Text(
              'No Active Cycle',
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Please log a period to see your fertility predictions.',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, Cycle cycle, ProfileData profile) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    final level = CycleCalculator.fertilityLevelForDate(
      date: DateTime.now(),
      lastPeriodStart: cycle.startDate,
      avgCycleLength: profile.avgCycleLength.toDouble(),
      avgPeriodLength: profile.avgPeriodLength.toDouble(),
      lutealPhase: profile.lutealPhase,
    );

    final color = _getColorForFertilityLevel(level);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            color: color.withValues(alpha: 0.1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
              side: BorderSide(color: color.withValues(alpha: 0.3)),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      level.emoji,
                      style: const TextStyle(fontSize: 48),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Today',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    level.label,
                    style: theme.textTheme.displaySmall?.copyWith(
                      color: color,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    level.description,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: colorScheme.onSurface.withValues(alpha: 0.8),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),
          Text(
            'What this means',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _buildInfoRow(
            context,
            'Peak Fertility',
            'Ovulation is imminent. This is your highest chance of pregnancy.',
            AppColors.peakFertility,
          ),
          _buildInfoRow(
            context,
            'High Fertility',
            'Sperm can survive up to 5 days inside the body. Sex on these days can lead to pregnancy.',
            AppColors.highFertility,
          ),
          _buildInfoRow(
            context,
            'Low Fertility',
            'Pregnancy is less likely, but not impossible.',
            AppColors.lowFertility,
          ),
          _buildInfoRow(
            context,
            'Post-ovulation',
            'The egg is gone. Conception is very unlikely until your next cycle.',
            AppColors.postOvulation,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(
      BuildContext context, String title, String description, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 12,
            height: 12,
            margin: const EdgeInsets.only(top: 6, right: 16),
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getColorForFertilityLevel(FertilityLevel level) {
    switch (level) {
      case FertilityLevel.peak:
        return AppColors.peakFertility;
      case FertilityLevel.high:
        return AppColors.highFertility;
      case FertilityLevel.low:
        return AppColors.lowFertility;
      case FertilityLevel.postOvulation:
        return AppColors.postOvulation;
      case FertilityLevel.period:
        return AppColors.period;
      case FertilityLevel.unknown:
        return Colors.grey;
    }
  }
}
