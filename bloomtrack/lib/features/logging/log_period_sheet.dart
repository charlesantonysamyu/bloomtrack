import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' as drift;

import 'package:bloomtrack/core/constants.dart';
import 'package:bloomtrack/data/database.dart';
import 'package:bloomtrack/data/providers/providers.dart';
import 'package:bloomtrack/shared/widgets/widgets.dart';

void showPeriodLogSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (context) => const _PeriodLogSheet(),
  );
}

class _PeriodLogSheet extends ConsumerStatefulWidget {
  const _PeriodLogSheet();

  @override
  ConsumerState<_PeriodLogSheet> createState() => _PeriodLogSheetState();
}

class _PeriodLogSheetState extends ConsumerState<_PeriodLogSheet> {
  FlowLevel? _selectedFlow;
  BloodColor? _selectedColor;
  bool _hasClots = false;
  String? _clotSize;
  int _padsCount = 0;
  int _tamponsCount = 0;
  String? _notes;
  bool _isSaving = false;
  DateTime _selectedDate = DateTime.now();

  Future<void> _save() async {
    if (_selectedFlow == null) return;
    
    setState(() => _isSaving = true);
    try {
      final flowDao = ref.read(flowLogDaoProvider);
      final cycleDao = ref.read(cycleDaoProvider);
      
      final normalizedDate = DateTime(_selectedDate.year, _selectedDate.month, _selectedDate.day);
      
      final existingLogs = await flowDao.getFlowLogsForDate(normalizedDate);
      for (final log in existingLogs) {
        await flowDao.deleteFlowLog(log.id);
      }
      
      await flowDao.insertFlowLog(
        FlowLogsCompanion.insert(
          date: normalizedDate,
          flowLevel: _selectedFlow!.name,
          bloodColor: drift.Value(_selectedColor?.name),
          hasClots: drift.Value(_hasClots),
          clotSize: drift.Value(_clotSize),
          padsCount: drift.Value(_padsCount),
          tamponsCount: drift.Value(_tamponsCount),
          notes: drift.Value(_notes),
        ),
      );
      
      // Ensure we have an active cycle
      final activeCycle = await cycleDao.getActiveCycle();
      if (activeCycle == null) {
        await cycleDao.insertCycle(
          CyclesCompanion.insert(startDate: normalizedDate),
        );
      } else {
        final normalizedStart = DateTime(activeCycle.startDate.year, activeCycle.startDate.month, activeCycle.startDate.day);
        if (normalizedDate.difference(normalizedStart).inDays >= 10) {
           final endDate = normalizedDate.subtract(const Duration(days: 1));
           await cycleDao.endCycle(activeCycle.id, endDate);
           await cycleDao.insertCycle(
             CyclesCompanion.insert(startDate: normalizedDate),
           );
        }
      }
      
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
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Log Period',
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
            'Flow Intensity',
            style: theme.textTheme.titleMedium,
          ),
          const SizedBox(height: 12),
          FlowPicker(
            selected: _selectedFlow,
            onChanged: (flow) => setState(() => _selectedFlow = flow),
          ),
          const SizedBox(height: 32),
          Text(
            'Blood Color',
            style: theme.textTheme.titleMedium,
          ),
          const SizedBox(height: 12),
          ColorLegend(
            selected: _selectedColor,
            onChanged: (color) => setState(() => _selectedColor = color),
          ),
          const SizedBox(height: 24),
          SwitchListTile(
            title: const Text('Clots'),
            contentPadding: EdgeInsets.zero,
            value: _hasClots,
            onChanged: (val) {
              setState(() {
                _hasClots = val;
                if (!val) _clotSize = null;
              });
            },
          ),
          if (_hasClots) ...[
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: ['Small', 'Medium', 'Large'].map((size) {
                return ChoiceChip(
                  label: Text(size),
                  selected: _clotSize == size,
                  onSelected: (selected) {
                    setState(() => _clotSize = selected ? size : null);
                  },
                );
              }).toList(),
            ),
          ],
          const SizedBox(height: 24),
          Text(
            'Products Used',
            style: theme.textTheme.titleMedium,
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Pads'),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () {
                            if (_padsCount > 0) setState(() => _padsCount--);
                          },
                        ),
                        Text('$_padsCount'),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () => setState(() => _padsCount++),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Tampons'),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () {
                            if (_tamponsCount > 0) setState(() => _tamponsCount--);
                          },
                        ),
                        Text('$_tamponsCount'),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () => setState(() => _tamponsCount++),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          TextField(
            decoration: const InputDecoration(
              labelText: 'Notes',
              border: OutlineInputBorder(),
            ),
            maxLines: 3,
            onChanged: (val) => _notes = val.isNotEmpty ? val : null,
          ),
          const SizedBox(height: 40),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: FilledButton(
              onPressed: _selectedFlow == null || _isSaving ? null : _save,
              child: _isSaving
                  ? const CircularProgressIndicator()
                  : const Text('Save Log', style: TextStyle(fontSize: 16)),
            ),
          ),
        ],
      ),
      ),
    );
  }
}
