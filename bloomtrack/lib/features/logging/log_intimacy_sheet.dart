import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' as drift;

import 'package:bloomtrack/core/constants.dart';
import 'package:bloomtrack/core/utils/cycle_calculator.dart';
import 'package:bloomtrack/data/database.dart';
import 'package:bloomtrack/data/providers/providers.dart';

void showIntimacyLogSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (context) => const _IntimacyLogSheet(),
  );
}

class _IntimacyLogSheet extends ConsumerStatefulWidget {
  const _IntimacyLogSheet();

  @override
  ConsumerState<_IntimacyLogSheet> createState() => _IntimacyLogSheetState();
}

class _IntimacyLogSheetState extends ConsumerState<_IntimacyLogSheet> {
  bool? _protected;
  String? _method;
  bool _isSaving = false;
  DateTime _selectedDate = DateTime.now();

  final List<String> _methods = ['Condom', 'Pill', 'None'];

  Future<void> _save() async {
    if (_protected == null) return;

    setState(() => _isSaving = true);
    try {
      final db = ref.read(databaseProvider);
      
      final normalizedDate = DateTime(_selectedDate.year, _selectedDate.month, _selectedDate.day);
      final startOfDay = normalizedDate;
      final endOfDay = normalizedDate.add(const Duration(days: 1));
      
      await (db.delete(db.intercourseLogs)
            ..where((i) => i.date.isBiggerOrEqualValue(startOfDay) & i.date.isSmallerThanValue(endOfDay)))
          .go();

      final activeCycle = ref.read(activeCycleProvider).value;
      final recentCycles = ref.read(recentCyclesProvider).value ?? [];
      final avgCycleLen = CycleCalculator.avgCycleLength(recentCycles.map((c) => c.cycleLength ?? kDefaultCycleLength).toList());
      final avgPeriodLen = CycleCalculator.avgPeriodLength(recentCycles.map((c) => c.periodLength ?? kDefaultPeriodLength).toList());

      if (activeCycle != null) {
        final fertility = CycleCalculator.fertilityLevelForDate(
          date: normalizedDate,
          lastPeriodStart: activeCycle.startDate,
          avgCycleLength: avgCycleLen,
          avgPeriodLength: avgPeriodLen,
        );
        if (fertility == FertilityLevel.peak && !_protected!) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Warning: Unprotected sex logged on a peak fertility day.'),
              ),
            );
          }
        }
      }

      await db.into(db.intercourseLogs).insert(
            IntercourseLogsCompanion.insert(
              date: normalizedDate,
              withProtection: drift.Value(_protected ?? false),
              method: drift.Value(_method),
            ),
          );

      if (mounted) Navigator.pop(context);
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Log Intimacy',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close_rounded),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(Icons.calendar_today, size: 20),
              const SizedBox(width: 8),
              TextButton(
                onPressed: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: _selectedDate,
                    firstDate: DateTime.now().subtract(const Duration(days: 365)),
                    lastDate: DateTime.now(),
                  );
                  if (picked != null) {
                    setState(() => _selectedDate = picked);
                  }
                },
                child: Text(
                  '${_selectedDate.year}-${_selectedDate.month.toString().padLeft(2, '0')}-${_selectedDate.day.toString().padLeft(2, '0')}',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            'Protection Used?',
            style: theme.textTheme.titleMedium,
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: SegmentedButton<bool>(
                  segments: const [
                    ButtonSegment<bool>(
                      value: true,
                      label: Text('Protected'),
                    ),
                    ButtonSegment<bool>(
                      value: false,
                      label: Text('Unprotected'),
                    ),
                  ],
                  selected: _protected != null ? {_protected!} : <bool>{},
                  emptySelectionAllowed: true,
                  onSelectionChanged: (Set<bool> newSelection) {
                    setState(() {
                      if (newSelection.isEmpty) {
                        _protected = null;
                        return;
                      }
                      _protected = newSelection.first;
                      if (!_protected!) {
                        _method = 'None';
                      } else if (_method == 'None') {
                        _method = null;
                      }
                    });
                  },
                ),
              ),
            ],
          ),
          if (_protected == true) ...[
            const SizedBox(height: 24),
            Text(
              'Method',
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _methods.where((m) => m != 'None').map((method) {
                final isSelected = _method == method;
                return ChoiceChip(
                  label: Text(method),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      _method = selected ? method : null;
                    });
                  },
                );
              }).toList(),
            ),
          ],
          const SizedBox(height: 40),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: FilledButton(
              onPressed: _protected == null || _isSaving ? null : _save,
              child: _isSaving
                  ? const CircularProgressIndicator()
                  : const Text('Save Log', style: TextStyle(fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }
}
