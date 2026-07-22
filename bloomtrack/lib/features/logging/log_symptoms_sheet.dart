import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' as drift;

import 'package:bloomtrack/data/database.dart';
import 'package:bloomtrack/data/providers/providers.dart';

void showSymptomsLogSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (context) => const _SymptomsLogSheet(),
  );
}

class _SymptomsLogSheet extends ConsumerStatefulWidget {
  const _SymptomsLogSheet();

  @override
  ConsumerState<_SymptomsLogSheet> createState() => _SymptomsLogSheetState();
}

class _SymptomsLogSheetState extends ConsumerState<_SymptomsLogSheet> {
  final Map<String, Set<String>> _selectedSymptoms = {
    'Mood': {},
    'Body': {},
    'Digestion': {},
  };

  final Map<String, List<String>> _symptoms = {
    'Mood': ['Happy', 'Sad', 'Anxious', 'Irritable', 'Mood Swings'],
    'Body': ['Cramps', 'Headache', 'Backache', 'Tender Breasts', 'Acne', 'Fatigue'],
    'Digestion': ['Bloating', 'Nausea', 'Cravings'],
  };

  bool _isSaving = false;
  DateTime _selectedDate = DateTime.now();

  bool get _hasSelection {
    return _selectedSymptoms.values.any((set) => set.isNotEmpty);
  }

  Future<void> _save() async {
    if (!_hasSelection) return;

    setState(() => _isSaving = true);
    try {
      final db = ref.read(databaseProvider);
      
      final normalizedDate = DateTime(_selectedDate.year, _selectedDate.month, _selectedDate.day);
      final startOfDay = normalizedDate;
      final endOfDay = normalizedDate.add(const Duration(days: 1));
      
      await (db.delete(db.symptomLogs)
            ..where((s) => s.date.isBiggerOrEqualValue(startOfDay) & s.date.isSmallerThanValue(endOfDay)))
          .go();
          
      final inserts = <SymptomLogsCompanion>[];

      for (final entry in _selectedSymptoms.entries) {
        final category = entry.key;
        for (final symptom in entry.value) {
          inserts.add(
            SymptomLogsCompanion.insert(
              date: normalizedDate,
              category: category,
              symptomKey: symptom,
            ),
          );
        }
      }

      await db.batch((batch) {
        batch.insertAll(db.symptomLogs, inserts);
      });

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
                'Log Symptoms',
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
          const SizedBox(height: 16),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _symptoms.entries.map((entry) {
                  final category = entry.key;
                  final symptomsList = entry.value;

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          category,
                          style: theme.textTheme.titleMedium,
                        ),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: symptomsList.map((symptom) {
                            final isSelected =
                                _selectedSymptoms[category]!.contains(symptom);
                            return FilterChip(
                              label: Text(symptom),
                              selected: isSelected,
                              onSelected: (selected) {
                                setState(() {
                                  if (selected) {
                                    _selectedSymptoms[category]!.add(symptom);
                                  } else {
                                    _selectedSymptoms[category]!.remove(symptom);
                                  }
                                });
                              },
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: FilledButton(
              onPressed: !_hasSelection || _isSaving ? null : _save,
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
