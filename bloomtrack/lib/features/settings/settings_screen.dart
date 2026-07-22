// ignore_for_file: deprecated_member_use
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/app_lock.dart';
import '../../core/constants.dart';
import '../../core/services/auth_service.dart';
import '../../core/services/notification_service.dart';
import '../../app.dart';
import 'package:drift/drift.dart' as drift;
import '../../data/database.dart';
import '../../data/providers/providers.dart';
import '../../core/services/pdf_export_service.dart';
class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  bool _periodApproachingEnabled = false;
  bool _dailyNudgeEnabled = false;
  bool _pillReminderEnabled = false;
  bool _selfExamReminderEnabled = false;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _periodApproachingEnabled = prefs.getBool('period_approaching') ?? false;
      _dailyNudgeEnabled = prefs.getBool('daily_nudge') ?? false;
      _pillReminderEnabled = prefs.getBool('pill_reminder') ?? false;
      _selfExamReminderEnabled = prefs.getBool('self_exam_reminder') ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeModeProvider);
    final profileAsync = ref.watch(profileProvider);
    final isFahrenheit = ref.watch(isFahrenheitProvider);
    final biometricEnabled = ref.watch(biometricEnabledProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          const _SettingsSectionHeader(title: 'Appearance'),
          SwitchListTile(
            secondary: const Icon(Icons.brightness_6),
            title: const Text('Dark Mode'),
            value: themeMode == ThemeMode.dark,
            onChanged: (bool value) {
              ref.read(themeModeProvider.notifier).setThemeMode(
                  value ? ThemeMode.dark : ThemeMode.light);
            },
          ),
          const Divider(),
          const _SettingsSectionHeader(title: 'Cycle'),
          profileAsync.when(
            data: (profile) {
              if (profile == null) return const SizedBox.shrink();
              return Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.track_changes_outlined),
                    title: const Text('Cycle Goal'),
                    subtitle: Text(profile.cycleGoal),
                    onTap: () {
                      _showCycleGoalDialog(context, profile);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.autorenew),
                    title: const Text('Default Cycle Length'),
                    subtitle: Text('${profile.avgCycleLength} days'),
                    onTap: () {
                      _showNumberDialog(
                        context: context,
                        profile: profile,
                        title: 'Default Cycle Length',
                        currentValue: profile.avgCycleLength,
                        minValue: 15,
                        maxValue: 60,
                        onSave: (val) async {
                          final db = ref.read(databaseProvider);
                          await (db.update(db.profile)..where((t) => t.id.equals(profile.id)))
                              .write(ProfileCompanion(avgCycleLength: drift.Value(val)));
                          ref.invalidate(profileProvider);
                        },
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.water_drop_outlined),
                    title: const Text('Default Period Length'),
                    subtitle: Text('${profile.avgPeriodLength} days'),
                    onTap: () {
                      _showNumberDialog(
                        context: context,
                        profile: profile,
                        title: 'Default Period Length',
                        currentValue: profile.avgPeriodLength,
                        minValue: 1,
                        maxValue: 15,
                        onSave: (val) async {
                          final db = ref.read(databaseProvider);
                          await (db.update(db.profile)..where((t) => t.id.equals(profile.id)))
                              .write(ProfileCompanion(avgPeriodLength: drift.Value(val)));
                          ref.invalidate(profileProvider);
                        },
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.nights_stay_outlined),
                    title: const Text('Luteal Phase'),
                    subtitle: Text('${profile.lutealPhase} days'),
                    onTap: () {
                      _showNumberDialog(
                        context: context,
                        profile: profile,
                        title: 'Luteal Phase Length',
                        currentValue: profile.lutealPhase,
                        minValue: kMinLutealPhase,
                        maxValue: kMaxLutealPhase,
                        onSave: (val) async {
                          final db = ref.read(databaseProvider);
                          await (db.update(db.profile)..where((t) => t.id.equals(profile.id)))
                              .write(ProfileCompanion(lutealPhase: drift.Value(val)));
                          ref.invalidate(profileProvider);
                        },
                      );
                    },
                  ),
                ],
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, st) => Text('Error: $e'),
          ),
          const Divider(),
          const _SettingsSectionHeader(title: 'App Preferences'),
          SwitchListTile(
            secondary: const Icon(Icons.thermostat_outlined),
            title: const Text('Temperature Unit (°F)'),
            subtitle: const Text('Use Fahrenheit instead of Celsius'),
            value: isFahrenheit,
            onChanged: (bool value) {
              ref.read(isFahrenheitProvider.notifier).toggle(value);
            },
          ),
          const Divider(),
          const _SettingsSectionHeader(title: 'Data & Privacy'),
          ListTile(
            leading: const Icon(Icons.file_download_outlined),
            title: const Text('Export Data'),
            onTap: () => _showExportOptions(context),
          ),
          SwitchListTile(
            secondary: const Icon(Icons.fingerprint),
            title: const Text('Biometric Lock'),
            subtitle: const Text('Require authentication to open the app'),
            value: biometricEnabled,
            onChanged: (bool value) async {
              final messenger = ScaffoldMessenger.of(context);
              if (value) {
                // Verify the user can actually authenticate before turning it on.
                final authenticated = await AuthService.authenticate();
                if (authenticated) {
                  await ref
                      .read(biometricEnabledProvider.notifier)
                      .setEnabled(true);
                } else {
                  messenger.showSnackBar(
                    const SnackBar(
                      content: Text('Authentication failed.'),
                    ),
                  );
                }
              } else {
                await ref
                    .read(biometricEnabledProvider.notifier)
                    .setEnabled(false);
              }
            },
          ),
          const Divider(),
          const _SettingsSectionHeader(title: 'Notifications'),
          SwitchListTile(
            secondary: const Icon(Icons.notifications_active_outlined),
            title: const Text('Period Approaching'),
            value: _periodApproachingEnabled,
            onChanged: (bool value) async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.setBool('period_approaching', value);
              if (value) {
                await NotificationService.init();
                await NotificationService.scheduleReminder();
              } else {
                await NotificationService.cancelReminder(1);
              }
              setState(() {
                _periodApproachingEnabled = value;
              });
            },
          ),
          SwitchListTile(
            secondary: const Icon(Icons.edit_calendar_outlined),
            title: const Text('Daily Logging Nudge'),
            value: _dailyNudgeEnabled,
            onChanged: (bool value) async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.setBool('daily_nudge', value);
              if (value) {
                await NotificationService.init();
                await NotificationService.scheduleDailyNudge();
              } else {
                await NotificationService.cancelReminder(2);
              }
              setState(() {
                _dailyNudgeEnabled = value;
              });
            },
          ),
          SwitchListTile(
            secondary: const Icon(Icons.medication_outlined),
            title: const Text('Pill Reminder'),
            value: _pillReminderEnabled,
            onChanged: (bool value) async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.setBool('pill_reminder', value);
              if (value) {
                await NotificationService.init();
                await NotificationService.schedulePillReminder();
              } else {
                await NotificationService.cancelReminder(3);
              }
              setState(() {
                _pillReminderEnabled = value;
              });
            },
          ),
          SwitchListTile(
            secondary: const Icon(Icons.health_and_safety_outlined),
            title: const Text('Self-exam Reminder'),
            value: _selfExamReminderEnabled,
            onChanged: (bool value) async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.setBool('self_exam_reminder', value);
              if (value) {
                await NotificationService.init();
                await NotificationService.scheduleSelfExamReminder();
              } else {
                await NotificationService.cancelReminder(4);
              }
              setState(() {
                _selfExamReminderEnabled = value;
              });
            },
          ),
          const Divider(),
          const _SettingsSectionHeader(title: 'About'),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('About'),
            subtitle: const Text('Version 1.0.0'),
            onTap: () {},
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.error,
                foregroundColor: Theme.of(context).colorScheme.onError,
              ),
              onPressed: () => _showDeleteConfirmation(context),
              child: const Text('Delete All Data'),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  void _showExportOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.table_chart),
                title: const Text('Export as CSV'),
                onTap: () {
                  Navigator.of(context).pop();
                  _exportDataAsCsv();
                },
              ),
              ListTile(
                leading: const Icon(Icons.picture_as_pdf),
                title: const Text('Export as PDF'),
                onTap: () {
                  Navigator.of(context).pop();
                  _exportDataAsPdf();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _exportDataAsCsv() async {
    final db = ref.read(databaseProvider);
    final cycles = await db.select(db.cycles).get();
    
    List<List<dynamic>> rows = [
      ['ID', 'Start Date', 'End Date', 'Cycle Length', 'Period Length', 'Notes']
    ];
    
    for (final cycle in cycles) {
      rows.add([
        cycle.id,
        cycle.startDate.toIso8601String(),
        cycle.endDate?.toIso8601String() ?? '',
        cycle.cycleLength ?? '',
        cycle.periodLength ?? '',
        cycle.notes ?? '',
      ]);
    }
    
    final StringBuffer csvBuffer = StringBuffer();
    for (final row in rows) {
      final line = row.map((e) => '"${e.toString().replaceAll('"', '""')}"').join(',');
      csvBuffer.writeln(line);
    }
    String csv = csvBuffer.toString();
    
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/bloomtrack_data.csv');
    await file.writeAsString(csv);
    
    if (mounted) {
      final box = context.findRenderObject() as RenderBox?;
      await Share.shareXFiles(
        [XFile(file.path)],
        text: 'My BloomTrack Data',
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
      );
    }
  }

  Future<void> _exportDataAsPdf() async {
    final db = ref.read(databaseProvider);
    final cycles = await db.select(db.cycles).get();
    final profile = await ref.read(profileProvider.future);
    
    final file = await PdfExportService.generateCycleHistoryPdf(cycles, profile);
    
    if (mounted) {
      final box = context.findRenderObject() as RenderBox?;
      await Share.shareXFiles(
        [XFile(file.path)],
        text: 'My BloomTrack Cycle History',
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
      );
    }
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete All Data'),
          content: const Text(
            'Are you sure you want to delete all data? This action cannot be undone.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.error,
                foregroundColor: Theme.of(context).colorScheme.onError,
              ),
              onPressed: () async {
                Navigator.of(context).pop();
                final db = ref.read(databaseProvider);
                await db.delete(db.cycles).go();
                await db.delete(db.flowLogs).go();
                await db.delete(db.symptomLogs).go();
                await db.delete(db.mucusLogs).go();
                await db.delete(db.bbtLogs).go();
                await db.delete(db.opkLogs).go();
                await db.delete(db.intercourseLogs).go();
                await db.delete(db.predictions).go();
                await db.delete(db.reminders).go();
                await db.delete(db.profile).go();
                
                ref.invalidate(profileProvider);
                
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('All data deleted successfully'),
                    ),
                  );
                }
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void _showCycleGoalDialog(BuildContext context, ProfileData profile) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select Cycle Goal'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('Track'),
                onTap: () async {
                  final db = ref.read(databaseProvider);
                  await (db.update(db.profile)..where((t) => t.id.equals(profile.id)))
                      .write(ProfileCompanion(cycleGoal: const drift.Value('Track')));
                  ref.invalidate(profileProvider);
                  if (context.mounted) Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: const Text('Conceive'),
                onTap: () async {
                  final db = ref.read(databaseProvider);
                  await (db.update(db.profile)..where((t) => t.id.equals(profile.id)))
                      .write(ProfileCompanion(cycleGoal: const drift.Value('Conceive')));
                  ref.invalidate(profileProvider);
                  if (context.mounted) Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: const Text('Avoid'),
                onTap: () async {
                  final db = ref.read(databaseProvider);
                  await (db.update(db.profile)..where((t) => t.id.equals(profile.id)))
                      .write(ProfileCompanion(cycleGoal: const drift.Value('Avoid')));
                  ref.invalidate(profileProvider);
                  if (context.mounted) Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showNumberDialog({
    required BuildContext context,
    required ProfileData profile,
    required String title,
    required int currentValue,
    required Function(int) onSave,
    required int minValue,
    required int maxValue,
  }) {
    final controller = TextEditingController(text: currentValue.toString());
    final messenger = ScaffoldMessenger.of(context);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Days',
              helperText: 'Enter a value between $minValue and $maxValue',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                final val = int.tryParse(controller.text.trim());
                if (val == null || val < minValue || val > maxValue) {
                  messenger.showSnackBar(
                    SnackBar(
                      content: Text(
                        'Please enter a whole number between $minValue and $maxValue.',
                      ),
                    ),
                  );
                  return;
                }
                onSave(val);
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    ).then((_) => controller.dispose());
  }
}

class _SettingsSectionHeader extends StatelessWidget {
  final String title;

  const _SettingsSectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
      ),
    );
  }
}
