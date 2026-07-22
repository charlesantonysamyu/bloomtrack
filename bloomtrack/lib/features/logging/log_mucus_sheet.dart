import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' as drift;

import 'package:bloomtrack/data/database.dart';
import 'package:bloomtrack/data/providers/providers.dart';

void showMucusLogSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (context) => const _MucusLogSheet(),
  );
}

class _MucusLogSheet extends ConsumerStatefulWidget {
  const _MucusLogSheet();

  @override
  ConsumerState<_MucusLogSheet> createState() => _MucusLogSheetState();
}

class _MucusLogSheetState extends ConsumerState<_MucusLogSheet> {
  String? _selectedType;
  bool _isSaving = false;
  DateTime _selectedDate = DateTime.now();

  final List<String> _mucusTypes = [
    'Dry',
    'Sticky',
    'Creamy',
    'Watery',
    'Eggwhite',
  ];

  Future<void> _save() async {
    if (_selectedType == null) return;

    setState(() => _isSaving = true);
    try {
      final db = ref.read(databaseProvider);
      
      final normalizedDate = DateTime(_selectedDate.year, _selectedDate.month, _selectedDate.day);
      final startOfDay = normalizedDate;
      final endOfDay = normalizedDate.add(const Duration(days: 1));
      
      await (db.delete(db.mucusLogs)
            ..where((m) => m.date.isBiggerOrEqualValue(startOfDay) & m.date.isSmallerThanValue(endOfDay)))
          .go();

      await db.into(db.mucusLogs).insert(
            MucusLogsCompanion.insert(
              date: normalizedDate,
              type: _selectedType!,
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
                'Log Cervical Mucus',
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
            'Mucus Type',
            style: theme.textTheme.titleMedium,
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _mucusTypes.map((type) {
              final isSelected = _selectedType == type;
              return ChoiceChip(
                label: Text(type),
                selected: isSelected,
                onSelected: (selected) {
                  setState(() {
                    _selectedType = selected ? type : null;
                  });
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 40),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: FilledButton(
              onPressed: _selectedType == null || _isSaving ? null : _save,
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
