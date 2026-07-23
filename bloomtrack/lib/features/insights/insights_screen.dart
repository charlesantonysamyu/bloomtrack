import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:intl/intl.dart';

import 'package:bloomtrack/data/database.dart';
import 'package:bloomtrack/data/providers/providers.dart';
import 'package:bloomtrack/core/theme.dart';
import 'package:bloomtrack/features/fertility/fertility_screen.dart';

class InsightsScreen extends ConsumerWidget {
  const InsightsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recentCyclesAsync = ref.watch(recentCyclesProvider);
    final bbtLogsAsync = ref.watch(bbtLogsProvider);
    final symptomLogsAsync = ref.watch(symptomLogsProvider);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Insights'),
      ),
      body: recentCyclesAsync.when(
        data: (cycles) {
          // Filter cycles that have a valid cycleLength (completed cycles)
          final completedCycles =
              cycles.where((c) => c.cycleLength != null).toList();

          if (completedCycles.length < 2) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.insert_chart_rounded,
                        size: 64,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Log more cycles to see your insights.',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: colorScheme.onSurface,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),
                    _buildFertilityCard(context),
                  ],
                ),
              ),
            );
          }

          // Calculate average cycle length
          final double avgCycleLength = completedCycles
                  .map((c) => c.cycleLength!)
                  .reduce((a, b) => a + b) /
              completedCycles.length;

          // For the chart, we reverse the list so the oldest is on the left
          final chartData = completedCycles.reversed.toList();

          final double maxCycleLength = chartData
              .map((e) => e.cycleLength!.toDouble())
              .reduce((a, b) => a > b ? a : b);

          return SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildFertilityCard(context),
                const SizedBox(height: 24),
                _buildAverageCard(context, avgCycleLength),
                const SizedBox(height: 32),
                Text(
                  'Recent Cycle Lengths',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                _buildCycleLengthChart(chartData, maxCycleLength, theme, colorScheme),
                const SizedBox(height: 32),
                Text(
                  'Recent Period Lengths',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                _buildPeriodLengthChart(chartData, theme, colorScheme),
                const SizedBox(height: 32),
                _buildBbtChart(bbtLogsAsync, theme, colorScheme),
                const SizedBox(height: 32),
                _buildTopSymptoms(symptomLogsAsync, theme, colorScheme),
                const SizedBox(height: 32),
                Center(
                  child: FilledButton.icon(
                    onPressed: () => _exportToPdf(context, avgCycleLength),
                    icon: const Icon(Icons.picture_as_pdf),
                    label: const Text('Export to PDF'),
                  ),
                ),
              ],
            ),
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(color: AppColors.primary),
        ),
        error: (err, stack) => Center(
          child: Text(
            'Failed to load insights.\n$err',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget _buildCycleLengthChart(List<Cycle> chartData, double maxCycleLength, ThemeData theme, ColorScheme colorScheme) {
    return SizedBox(
      height: 300,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: maxCycleLength + 10,
          barTouchData: BarTouchData(
            enabled: true,
            touchTooltipData: BarTouchTooltipData(
              getTooltipColor: (_) => colorScheme.surface,
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                return BarTooltipItem(
                  '${rod.toY.round()} days',
                  theme.textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                );
              },
            ),
          ),
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      'C${value.toInt() + 1}',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurface
                            .withValues(alpha: 0.6),
                      ),
                    ),
                  );
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                getTitlesWidget: (value, meta) {
                  if (value % 10 != 0) return const SizedBox.shrink();
                  return Text(
                    value.toInt().toString(),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurface
                          .withValues(alpha: 0.6),
                    ),
                  );
                },
              ),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
          ),
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: 10,
            getDrawingHorizontalLine: (value) {
              return FlLine(
                color: theme.dividerColor.withValues(alpha: 0.5),
                strokeWidth: 1,
                dashArray: [5, 5],
              );
            },
          ),
          borderData: FlBorderData(show: false),
          barGroups: List.generate(chartData.length, (index) {
            final length = chartData[index].cycleLength!.toDouble();
            return BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  toY: length,
                  color: AppColors.primary,
                  width: 24,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(8),
                  ),
                  backDrawRodData: BackgroundBarChartRodData(
                    show: true,
                    toY: maxCycleLength + 5,
                    color: AppColors.primary.withValues(alpha: 0.1),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget _buildPeriodLengthChart(List<Cycle> chartData, ThemeData theme, ColorScheme colorScheme) {
    // Filter to cycles that have a period length recorded
    final validData = chartData.where((c) => c.periodLength != null).toList();
    if (validData.isEmpty) return const SizedBox.shrink();

    final double maxPeriodLength = validData
        .map((e) => e.periodLength!.toDouble())
        .reduce((a, b) => a > b ? a : b);

    return SizedBox(
      height: 200,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: maxPeriodLength + 5,
          barTouchData: BarTouchData(
            enabled: true,
            touchTooltipData: BarTouchTooltipData(
              getTooltipColor: (_) => colorScheme.surface,
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                return BarTooltipItem(
                  '${rod.toY.round()} days',
                  theme.textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.accent, // Use accent color (red/pink) for periods
                  ),
                );
              },
            ),
          ),
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      'C${value.toInt() + 1}',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurface
                            .withValues(alpha: 0.6),
                      ),
                    ),
                  );
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                getTitlesWidget: (value, meta) {
                  if (value % 2 != 0) return const SizedBox.shrink(); // Interval of 2 for periods
                  return Text(
                    value.toInt().toString(),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurface
                          .withValues(alpha: 0.6),
                    ),
                  );
                },
              ),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
          ),
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: 2,
            getDrawingHorizontalLine: (value) {
              return FlLine(
                color: theme.dividerColor.withValues(alpha: 0.5),
                strokeWidth: 1,
                dashArray: [5, 5],
              );
            },
          ),
          borderData: FlBorderData(show: false),
          barGroups: List.generate(validData.length, (index) {
            final length = validData[index].periodLength!.toDouble();
            return BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  toY: length,
                  color: AppColors.accent,
                  width: 24,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(8),
                  ),
                  backDrawRodData: BackgroundBarChartRodData(
                    show: true,
                    toY: maxPeriodLength + 2,
                    color: AppColors.accent.withValues(alpha: 0.1),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget _buildFertilityCard(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return Card(
      elevation: 0,
      color: colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: theme.dividerColor.withValues(alpha: 0.5)),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const FertilityScreen()),
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.child_care_rounded,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Fertility & Conception Chances',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Check today\'s likelihood of pregnancy',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurface.withValues(alpha: 0.6),
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: colorScheme.onSurface.withValues(alpha: 0.3),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAverageCard(BuildContext context, double avgCycleLength) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            AppColors.primary,
            AppColors.accent,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'Average Cycle Length',
            style: theme.textTheme.titleMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                avgCycleLength.toStringAsFixed(1),
                style: theme.textTheme.displayLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'days',
                style: theme.textTheme.titleLarge?.copyWith(
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBbtChart(AsyncValue<List<BbtLog>> bbtAsync, ThemeData theme, ColorScheme colorScheme) {
    return bbtAsync.when(
      data: (logs) {
        if (logs.isEmpty) {
          return const SizedBox.shrink();
        }
        
        logs.sort((a, b) => a.date.compareTo(b.date));
        
        final spots = <FlSpot>[];
        for (var i = 0; i < logs.length; i++) {
          spots.add(FlSpot(i.toDouble(), logs[i].temperature));
        }

        double minY = logs.map((e) => e.temperature).reduce((a, b) => a < b ? a : b) - 0.5;
        double maxY = logs.map((e) => e.temperature).reduce((a, b) => a > b ? a : b) + 0.5;

        bool thermalShiftDetected = false;
        DateTime? shiftDate;
        if (logs.length >= 6) {
          for (int i = 6; i < logs.length; i++) {
            final prevAvg = logs.sublist(i - 6, i).map((e) => e.temperature).reduce((a, b) => a + b) / 6;
            if (logs[i].temperature >= prevAvg + 0.2) {
              thermalShiftDetected = true;
              shiftDate = logs[i].date;
              break;
            }
          }
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Basal Body Temperature',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: LineChart(
                LineChartData(
                  minY: minY,
                  maxY: maxY,
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          final idx = value.toInt();
                          if (idx >= 0 && idx < logs.length && idx % (logs.length ~/ 5 + 1) == 0) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                DateFormat('MMM d').format(logs[idx].date),
                                style: theme.textTheme.bodySmall,
                              ),
                            );
                          }
                          return const SizedBox.shrink();
                        },
                        reservedSize: 30,
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            value.toStringAsFixed(1),
                            style: theme.textTheme.bodySmall,
                          );
                        },
                      ),
                    ),
                    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: spots,
                      isCurved: true,
                      color: AppColors.primary,
                      barWidth: 3,
                      dotData: const FlDotData(show: true),
                    ),
                  ],
                ),
              ),
            ),
            if (thermalShiftDetected && shiftDate != null) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.peakFertility.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.peakFertility.withValues(alpha: 0.3)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.show_chart, color: AppColors.peakFertility),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Thermal Shift Detected on ${DateFormat.MMMd().format(shiftDate)} — Potential Ovulation Confirmed.',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: AppColors.peakFertility,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) => Text('Failed to load BBT: $e'),
    );
  }

  Widget _buildTopSymptoms(AsyncValue<List<SymptomLog>> symptomAsync, ThemeData theme, ColorScheme colorScheme) {
    return symptomAsync.when(
      data: (logs) {
        if (logs.isEmpty) {
          return const SizedBox.shrink();
        }

        final counts = <String, int>{};
        for (final log in logs) {
          counts[log.symptomKey] = (counts[log.symptomKey] ?? 0) + 1;
        }

        final sorted = counts.entries.toList()
          ..sort((a, b) => b.value.compareTo(a.value));
        final top = sorted.take(5).toList();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Top Logged Symptoms',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ...top.map((e) => ListTile(
                  leading: const Icon(Icons.healing, color: AppColors.primary),
                  title: Text(e.key),
                  trailing: Text(
                    '${e.value} times',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                )),
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) => Text('Failed to load symptoms: $e'),
    );
  }

  Future<void> _exportToPdf(BuildContext context, double avgCycleLength) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              children: [
                pw.Text('Cycle History Report', style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 20),
                pw.Text('Average Cycle Length: ${avgCycleLength.toStringAsFixed(1)} days', style: pw.TextStyle(fontSize: 18)),
              ],
            ),
          );
        },
      ),
    );

    await Printing.sharePdf(bytes: await pdf.save(), filename: 'cycle_report.pdf');
  }
}
