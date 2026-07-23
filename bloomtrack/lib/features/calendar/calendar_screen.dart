import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:drift/drift.dart' as drift;

import 'package:bloomtrack/core/theme.dart';
import 'package:bloomtrack/core/constants.dart';
import 'package:bloomtrack/core/utils/cycle_calculator.dart';
import 'package:bloomtrack/data/database.dart';
import 'package:bloomtrack/data/providers/providers.dart';
import 'package:bloomtrack/features/logging/log_sheet.dart';

class CalendarScreen extends ConsumerStatefulWidget {
  const CalendarScreen({super.key});

  @override
  ConsumerState<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends ConsumerState<CalendarScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
  }

  DateTime _dateOnly(DateTime dt) => DateTime(dt.year, dt.month, dt.day);

  FertilityLevel _getFertilityLevelForDate(DateTime day, List<Cycle> cycles) {
    if (cycles.isEmpty) return FertilityLevel.unknown;

    final date = _dateOnly(day);
    
    for (final cycle in cycles) {
      final startDate = _dateOnly(cycle.startDate);
      final periodLength = cycle.periodLength ?? kDefaultPeriodLength;
      final endDate = startDate.add(Duration(days: periodLength - 1));
      
      if (!date.isBefore(startDate) && !date.isAfter(endDate)) {
        return FertilityLevel.period;
      }
    }

    Cycle? recentCycle;
    for (final c in cycles) {
      if (!date.isBefore(_dateOnly(c.startDate))) {
        if (recentCycle == null || c.startDate.isAfter(recentCycle.startDate)) {
          recentCycle = c;
        }
      }
    }
    
    recentCycle ??= cycles.reduce((a, b) => a.startDate.isBefore(b.startDate) ? a : b);
    
    final cycleLengths = cycles.map((c) => c.cycleLength).whereType<int>().toList();
    final periodLengths = cycles.map((c) => c.periodLength).whereType<int>().toList();

    final avgCycleLength = CycleCalculator.avgCycleLength(cycleLengths);
    final avgPeriodLength = CycleCalculator.avgPeriodLength(periodLengths);

    return CycleCalculator.fertilityLevelForDate(
      date: day,
      lastPeriodStart: recentCycle.startDate,
      avgCycleLength: avgCycleLength,
      avgPeriodLength: avgPeriodLength,
    );
  }

  Widget? _buildDay(
    BuildContext context, 
    DateTime date, 
    List<Cycle> cycles, 
    {bool isSelected = false, bool isToday = false, bool isOutside = false, bool hasSymptom = false, bool hasIntimacy = false, bool isSpotting = false}
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    final fertilityLevel = _getFertilityLevelForDate(date, cycles);
    final isPeriod = fertilityLevel == FertilityLevel.period;
    final isPeak = fertilityLevel == FertilityLevel.peak;
    final isHigh = fertilityLevel == FertilityLevel.high;
    
    Color? bgColor;
    Color? textColor = isOutside 
        ? colorScheme.onSurface.withValues(alpha: 0.3) 
        : colorScheme.onSurface;
    
    if (isSelected) {
      if (isPeriod) {
        bgColor = AppColors.period;
      } else if (isPeak) {
        bgColor = AppColors.peakFertility;
      } else if (isHigh) {
        bgColor = AppColors.highFertility;
      } else {
        bgColor = colorScheme.primary;
      }
      textColor = Colors.white;
    } else if (isPeriod) {
      bgColor = AppColors.period.withValues(alpha: 0.2);
      textColor = AppColors.period;
    } else if (isPeak) {
      bgColor = AppColors.peakFertility.withValues(alpha: 0.2);
      textColor = AppColors.peakFertility;
    } else if (isHigh) {
      bgColor = AppColors.highFertility.withValues(alpha: 0.2);
      textColor = AppColors.highFertility;
    } else if (isSpotting) {
      bgColor = Colors.pink.shade100;
    } else if (isToday) {
      bgColor = colorScheme.primary.withValues(alpha: 0.1);
      textColor = colorScheme.primary;
    }

    if (isSelected && isSpotting && !isPeriod && !isPeak && !isHigh) {
      bgColor = Colors.pink.shade100;
      textColor = Colors.black87;
    }

    return Container(
      margin: const EdgeInsets.all(6.0),
      decoration: BoxDecoration(
        color: bgColor,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '${date.day}',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: textColor,
              fontWeight: isSelected || isToday || isPeriod || isPeak || isHigh ? FontWeight.bold : FontWeight.normal,
              height: 1.0,
            ),
          ),
          if (hasSymptom || hasIntimacy) const SizedBox(height: 2),
          if (hasSymptom || hasIntimacy)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (hasSymptom)
                  Container(
                    width: 4,
                    height: 4,
                    margin: const EdgeInsets.symmetric(horizontal: 1),
                    decoration: BoxDecoration(
                      color: isSelected && !isPeriod && !isPeak && !isHigh ? Colors.white : Colors.amber,
                      shape: BoxShape.circle,
                    ),
                  ),
                if (hasIntimacy)
                  Container(
                    width: 4,
                    height: 4,
                    margin: const EdgeInsets.symmetric(horizontal: 1),
                    decoration: BoxDecoration(
                      color: isSelected && !isPeriod && !isPeak && !isHigh ? Colors.white : Colors.purpleAccent,
                      shape: BoxShape.circle,
                    ),
                  ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(BuildContext context, String label, Color color) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(right: 16.0, bottom: 8.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDayDetail(BuildContext context, String label, Color color) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cyclesAsync = ref.watch(allCyclesProvider);
    final symptomDatesAsync = ref.watch(datesWithSymptomLogsProvider);
    final intimacyDatesAsync = ref.watch(datesWithIntimacyLogsProvider);
    final spottingDatesAsync = ref.watch(datesWithSpottingProvider);
    
    final symptomDates = symptomDatesAsync.value ?? {};
    final intimacyDates = intimacyDatesAsync.value ?? {};
    final spottingDates = spottingDatesAsync.value ?? {};

    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar'),
      ),
      body: cyclesAsync.when(
        data: (cycles) {
          return Column(
            children: [
              TableCalendar(
                firstDay: DateTime.now().subtract(const Duration(days: 365 * 10)),
                lastDay: DateTime.now().add(const Duration(days: 365 * 10)),
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                },
                onPageChanged: (focusedDay) {
                  _focusedDay = focusedDay;
                },
                startingDayOfWeek: StartingDayOfWeek.monday,
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                  titleTextStyle: theme.textTheme.titleLarge!,
                  leftChevronIcon: Icon(Icons.chevron_left, color: theme.colorScheme.onSurface),
                  rightChevronIcon: Icon(Icons.chevron_right, color: theme.colorScheme.onSurface),
                ),
                daysOfWeekStyle: DaysOfWeekStyle(
                  weekdayStyle: theme.textTheme.bodyMedium!,
                  weekendStyle: theme.textTheme.bodyMedium!.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),
                calendarBuilders: CalendarBuilders(
                  defaultBuilder: (context, day, focusedDay) => _buildDay(context, day, cycles, hasSymptom: symptomDates.contains(_dateOnly(day)), hasIntimacy: intimacyDates.contains(_dateOnly(day)), isSpotting: spottingDates.contains(_dateOnly(day))),
                  todayBuilder: (context, day, focusedDay) => _buildDay(context, day, cycles, isToday: true, hasSymptom: symptomDates.contains(_dateOnly(day)), hasIntimacy: intimacyDates.contains(_dateOnly(day)), isSpotting: spottingDates.contains(_dateOnly(day))),
                  selectedBuilder: (context, day, focusedDay) => _buildDay(context, day, cycles, isSelected: true, hasSymptom: symptomDates.contains(_dateOnly(day)), hasIntimacy: intimacyDates.contains(_dateOnly(day)), isSpotting: spottingDates.contains(_dateOnly(day))),
                  outsideBuilder: (context, day, focusedDay) => _buildDay(context, day, cycles, isOutside: true, hasSymptom: symptomDates.contains(_dateOnly(day)), hasIntimacy: intimacyDates.contains(_dateOnly(day)), isSpotting: spottingDates.contains(_dateOnly(day))),
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 10,
                        offset: const Offset(0, -5),
                      ),
                    ],
                  ),
                  child: _selectedDay != null
                      ? _SelectedDayDetails(
                          selectedDay: _selectedDay!,
                          cycles: cycles,
                          getFertilityLevel: _getFertilityLevelForDate,
                          buildDayDetail: _buildDayDetail,
                          buildLegendItem: _buildLegendItem,
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Select a date',
                              style: theme.textTheme.titleLarge,
                            ),
                            const SizedBox(height: 24),
                            const Divider(),
                            const SizedBox(height: 16),
                            Text(
                              'Legend',
                              style: theme.textTheme.titleMedium,
                            ),
                            const SizedBox(height: 12),
                            Wrap(
                              children: [
                                _buildLegendItem(context, 'Period', AppColors.period),
                                _buildLegendItem(context, 'Spotting', Colors.pink.shade100),
                                _buildLegendItem(context, 'High Fertility', AppColors.highFertility),
                                _buildLegendItem(context, 'Peak Fertility', AppColors.peakFertility),
                              ],
                            ),
                          ],
                        ),
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Error loading calendar: $error'),
        ),
      ),
    );
  }
}

class _SelectedDayDetails extends ConsumerWidget {
  final DateTime selectedDay;
  final List<Cycle> cycles;
  final FertilityLevel Function(DateTime, List<Cycle>) getFertilityLevel;
  final Widget Function(BuildContext, String, Color) buildDayDetail;
  final Widget Function(BuildContext, String, Color) buildLegendItem;

  const _SelectedDayDetails({
    required this.selectedDay,
    required this.cycles,
    required this.getFertilityLevel,
    required this.buildDayDetail,
    required this.buildLegendItem,
  });

  Future<bool> _confirmDelete(BuildContext context, String itemLabel) async {
    return await showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Delete $itemLabel?'),
            content: Text('Are you sure you want to delete this $itemLabel log?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx, false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(ctx, true),
                style: TextButton.styleFrom(foregroundColor: Colors.red),
                child: const Text('Delete'),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final date = DateTime(selectedDay.year, selectedDay.month, selectedDay.day);

    final flowLogsAsync = ref.watch(flowLogsForDateProvider(date));
    final symptomLogsAsync = ref.watch(symptomLogsForDateProvider(date));
    final intimacyLogsAsync = ref.watch(intercourseLogsForDateProvider(date));
    final mucusLogsAsync = ref.watch(mucusLogsForDateProvider(date));
    final bbtLogsAsync = ref.watch(bbtLogsForDateProvider(date));
    final opkLogsAsync = ref.watch(opkLogsForDateProvider(date));

    final flowLogs = flowLogsAsync.value ?? [];
    final symptomLogs = symptomLogsAsync.value ?? [];
    final intimacyLogs = intimacyLogsAsync.value ?? [];
    final mucusLogs = mucusLogsAsync.value ?? [];
    final bbtLogs = bbtLogsAsync.value ?? [];
    final opkLogs = opkLogsAsync.value ?? [];

    final hasAnyLogs = flowLogs.isNotEmpty ||
        symptomLogs.isNotEmpty ||
        intimacyLogs.isNotEmpty ||
        mucusLogs.isNotEmpty ||
        bbtLogs.isNotEmpty ||
        opkLogs.isNotEmpty;

    final selectedLevel = getFertilityLevel(selectedDay, cycles);

    // Collect notes
    final notesList = <String>[];
    for (final log in flowLogs) {
      if (log.notes != null && log.notes!.isNotEmpty) {
        notesList.add('Period: ${log.notes}');
      }
    }
    for (final log in symptomLogs) {
      if (log.notes != null && log.notes!.isNotEmpty) {
        notesList.add('Symptom (${log.symptomKey}): ${log.notes}');
      }
    }
    for (final log in intimacyLogs) {
      if (log.notes != null && log.notes!.isNotEmpty) {
        notesList.add('Intimacy: ${log.notes}');
      }
    }
    for (final log in mucusLogs) {
      if (log.notes != null && log.notes!.isNotEmpty) {
        notesList.add('Mucus: ${log.notes}');
      }
    }

    final db = ref.read(databaseProvider);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  DateFormat.yMMMMd().format(selectedDay),
                  style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              IconButton(
                onPressed: () => LogSheet.show(context, initialDate: selectedDay),
                icon: const Icon(Icons.add_circle_outline),
                tooltip: 'Add Log',
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (selectedLevel == FertilityLevel.period)
            buildDayDetail(context, 'Period Day', AppColors.period)
          else if (selectedLevel == FertilityLevel.peak)
            buildDayDetail(context, 'Peak Fertility', AppColors.peakFertility)
          else if (selectedLevel == FertilityLevel.high)
            buildDayDetail(context, 'High Fertility', AppColors.highFertility),
          const SizedBox(height: 12),
          if (hasAnyLogs) ...[
            Text('Logged Items:', style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                if (flowLogs.isNotEmpty)
                  Chip(
                    avatar: const Icon(Icons.water_drop, size: 16, color: AppColors.period),
                    label: Text('Flow: ${flowLogs.first.flowLevel}'),
                    onDeleted: () async {
                      if (await _confirmDelete(context, 'Period Flow')) {
                        final flowDao = ref.read(flowLogDaoProvider);
                        await flowDao.deleteFlowLog(flowLogs.first.id);
                      }
                    },
                  ),
                if (symptomLogs.isNotEmpty)
                  Chip(
                    avatar: const Icon(Icons.sentiment_satisfied_alt, size: 16, color: AppColors.secondary),
                    label: Text('Symptoms: ${symptomLogs.map((s) => s.symptomKey).join(', ')}'),
                    onDeleted: () async {
                      if (await _confirmDelete(context, 'Symptoms')) {
                        final startOfDay = date;
                        final endOfDay = startOfDay.add(const Duration(days: 1));
                        await (db.delete(db.symptomLogs)
                              ..where((s) => s.date.isBiggerOrEqualValue(startOfDay) & s.date.isSmallerThanValue(endOfDay)))
                            .go();
                      }
                    },
                  ),
                if (intimacyLogs.isNotEmpty)
                  Chip(
                    avatar: const Icon(Icons.favorite, size: 16, color: AppColors.intercourse),
                    label: Text('Intimacy: ${intimacyLogs.first.withProtection ? "Protected" : "Unprotected"}'),
                    onDeleted: () async {
                      if (await _confirmDelete(context, 'Intimacy')) {
                        final startOfDay = date;
                        final endOfDay = startOfDay.add(const Duration(days: 1));
                        await (db.delete(db.intercourseLogs)
                              ..where((i) => i.date.isBiggerOrEqualValue(startOfDay) & i.date.isSmallerThanValue(endOfDay)))
                            .go();
                      }
                    },
                  ),
                if (mucusLogs.isNotEmpty)
                  Chip(
                    avatar: const Icon(Icons.opacity, size: 16, color: AppColors.info),
                    label: Text('Mucus: ${mucusLogs.first.type}'),
                    onDeleted: () async {
                      if (await _confirmDelete(context, 'Mucus')) {
                        final startOfDay = date;
                        final endOfDay = startOfDay.add(const Duration(days: 1));
                        await (db.delete(db.mucusLogs)
                              ..where((m) => m.date.isBiggerOrEqualValue(startOfDay) & m.date.isSmallerThanValue(endOfDay)))
                            .go();
                      }
                    },
                  ),
                if (bbtLogs.isNotEmpty)
                  Chip(
                    avatar: const Icon(Icons.thermostat, size: 16, color: AppColors.accent),
                    label: Text('BBT: ${bbtLogs.first.temperature}°${bbtLogs.first.unit}'),
                    onDeleted: () async {
                      if (await _confirmDelete(context, 'BBT')) {
                        final startOfDay = date;
                        final endOfDay = startOfDay.add(const Duration(days: 1));
                        await (db.delete(db.bbtLogs)
                              ..where((b) => b.date.isBiggerOrEqualValue(startOfDay) & b.date.isSmallerThanValue(endOfDay)))
                            .go();
                      }
                    },
                  ),
                if (opkLogs.isNotEmpty)
                  Chip(
                    avatar: const Icon(Icons.science, size: 16, color: AppColors.peakFertility),
                    label: Text('OPK: ${opkLogs.first.result}'),
                    onDeleted: () async {
                      if (await _confirmDelete(context, 'OPK')) {
                        final startOfDay = date;
                        final endOfDay = startOfDay.add(const Duration(days: 1));
                        await (db.delete(db.opkLogs)
                              ..where((o) => o.date.isBiggerOrEqualValue(startOfDay) & o.date.isSmallerThanValue(endOfDay)))
                            .go();
                      }
                    },
                  ),
              ],
            ),
            const SizedBox(height: 16),
          ] else ...[
            Text(
              'No custom logs for this date.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
            const SizedBox(height: 16),
          ],
          if (notesList.isNotEmpty) ...[
            Text('Notes:', style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(height: 6),
            ...notesList.map((note) => Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.note_alt_outlined, size: 16),
                        const SizedBox(width: 8),
                        Expanded(child: Text(note, style: theme.textTheme.bodyMedium)),
                      ],
                    ),
                  ),
                )),
            const SizedBox(height: 16),
          ],
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: () => LogSheet.show(context, initialDate: selectedDay),
              icon: const Icon(Icons.edit_calendar),
              label: Text('Log Data for ${DateFormat.MMMd().format(selectedDay)}'),
            ),
          ),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 12),
          Text(
            'Legend',
            style: theme.textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Wrap(
            children: [
              buildLegendItem(context, 'Period', AppColors.period),
              buildLegendItem(context, 'Spotting', Colors.pink.shade100),
              buildLegendItem(context, 'High Fertility', AppColors.highFertility),
              buildLegendItem(context, 'Peak Fertility', AppColors.peakFertility),
            ],
          ),
        ],
      ),
    );
  }
}

