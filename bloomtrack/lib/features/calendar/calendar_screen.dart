import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

import 'package:bloomtrack/core/theme.dart';
import 'package:bloomtrack/core/constants.dart';
import 'package:bloomtrack/core/utils/cycle_calculator.dart';
import 'package:bloomtrack/data/database.dart';
import 'package:bloomtrack/data/providers/providers.dart';

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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (_selectedDay != null) ...[
                        Text(
                          DateFormat.yMMMMd().format(_selectedDay!),
                          style: theme.textTheme.titleLarge,
                        ),
                        const SizedBox(height: 16),
                        Builder(
                          builder: (context) {
                            final selectedLevel = _getFertilityLevelForDate(_selectedDay!, cycles);
                            if (selectedLevel == FertilityLevel.period) {
                              return _buildDayDetail(context, 'Period Day', AppColors.period);
                            } else if (selectedLevel == FertilityLevel.peak) {
                              return _buildDayDetail(context, 'Peak Fertility', AppColors.peakFertility);
                            } else if (selectedLevel == FertilityLevel.high) {
                              return _buildDayDetail(context, 'High Fertility', AppColors.highFertility);
                            } else {
                              return Text(
                                'No events logged for this day.',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                                ),
                              );
                            }
                          },
                        ),
                      ] else ...[
                        Text(
                          'Select a date',
                          style: theme.textTheme.titleLarge,
                        ),
                      ],
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
