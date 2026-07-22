import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' as drift;

import 'package:bloomtrack/data/database.dart';
import 'package:bloomtrack/data/providers/providers.dart';

void showBbtOpkLogSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (context) => const _BbtOpkLogSheet(),
  );
}

class _BbtOpkLogSheet extends ConsumerStatefulWidget {
  const _BbtOpkLogSheet();

  @override
  ConsumerState<_BbtOpkLogSheet> createState() => _BbtOpkLogSheetState();
}

class _BbtOpkLogSheetState extends ConsumerState<_BbtOpkLogSheet> {
  final TextEditingController _tempController = TextEditingController();
  String? _opkResult;
  bool _isSaving = false;
  DateTime _selectedDate = DateTime.now();

  @override
  void dispose() {
    _tempController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final tempText = _tempController.text;
    final tempValue = double.tryParse(tempText);
    
    if (tempValue == null && _opkResult == null) return;

    setState(() => _isSaving = true);
    try {
      final db = ref.read(databaseProvider);
      
      final normalizedDate = DateTime(_selectedDate.year, _selectedDate.month, _selectedDate.day);
      final startOfDay = normalizedDate;
      final endOfDay = normalizedDate.add(const Duration(days: 1));

      final unit = ref.read(isFahrenheitProvider) ? 'F' : 'C';

      await db.transaction(() async {
        if (tempValue != null) {
          await (db.delete(db.bbtLogs)
                ..where((b) => b.date.isBiggerOrEqualValue(startOfDay) & b.date.isSmallerThanValue(endOfDay)))
              .go();

          await db.into(db.bbtLogs).insert(
                BbtLogsCompanion.insert(
                  date: normalizedDate,
                  temperature: tempValue,
                  unit: drift.Value(unit),
                ),
              );
        }

        if (_opkResult != null) {
          await (db.delete(db.opkLogs)
                ..where((o) => o.date.isBiggerOrEqualValue(startOfDay) & o.date.isSmallerThanValue(endOfDay)))
              .go();
              
          await db.into(db.opkLogs).insert(
                OpkLogsCompanion.insert(
                  date: normalizedDate,
                  result: _opkResult!,
                ),
              );
        }
      });

      if (mounted) Navigator.pop(context);
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isFahrenheit = ref.watch(isFahrenheitProvider);
    final isSaveEnabled = _tempController.text.isNotEmpty || _opkResult != null;

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
                'Log BBT & OPK',
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
            'Basal Body Temperature',
            style: theme.textTheme.titleMedium,
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _tempController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              hintText: isFahrenheit
                  ? 'Enter temperature (e.g., 97.7)'
                  : 'Enter temperature (e.g., 36.5)',
              suffixText: isFahrenheit ? '°F' : '°C',
              border: const OutlineInputBorder(),
            ),
            onChanged: (value) => setState(() {}),
          ),
          const SizedBox(height: 32),
          Text(
            'OPK Result',
            style: theme.textTheme.titleMedium,
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: SegmentedButton<String>(
                  segments: const [
                    ButtonSegment<String>(
                      value: 'Positive',
                      label: Text('Positive'),
                    ),
                    ButtonSegment<String>(
                      value: 'Negative',
                      label: Text('Negative'),
                    ),
                  ],
                  selected: _opkResult != null ? {_opkResult!} : <String>{},
                  emptySelectionAllowed: true,
                  onSelectionChanged: (Set<String> newSelection) {
                    setState(() {
                      _opkResult =
                          newSelection.isEmpty ? null : newSelection.first;
                    });
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: FilledButton(
              onPressed: !isSaveEnabled || _isSaving ? null : _save,
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
