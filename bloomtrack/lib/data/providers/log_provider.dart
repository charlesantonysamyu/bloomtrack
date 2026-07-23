import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart';
import 'package:bloomtrack/data/database.dart';
import 'package:bloomtrack/data/providers/database_provider.dart';

final profileProvider = FutureProvider<ProfileData?>((ref) async {
  final db = ref.watch(databaseProvider);
  final profiles = await db.select(db.profile).get();
  if (profiles.isEmpty) {
    await db.into(db.profile).insert(
      ProfileCompanion.insert(
        cycleGoal: 'Track',
        createdAt: DateTime.now(),
      ),
    );
    final newProfiles = await db.select(db.profile).get();
    return newProfiles.firstOrNull;
  }
  return profiles.first;
});

final flowLogsForDateProvider = StreamProvider.family<List<FlowLog>, DateTime>((ref, date) {
  final flowLogDao = ref.watch(flowLogDaoProvider);
  return flowLogDao.watchFlowLogsForDate(date);
});

final latestFlowLogProvider = FutureProvider<FlowLog?>((ref) {
  final flowLogDao = ref.watch(flowLogDaoProvider);
  return flowLogDao.getLatestFlowLog();
});

final bbtLogsProvider = StreamProvider<List<BbtLog>>((ref) {
  final db = ref.watch(databaseProvider);
  return db.select(db.bbtLogs).watch();
});

final symptomLogsProvider = StreamProvider<List<SymptomLog>>((ref) {
  final db = ref.watch(databaseProvider);
  return db.select(db.symptomLogs).watch();
});

final datesWithSymptomLogsProvider = StreamProvider<Set<DateTime>>((ref) {
  final db = ref.watch(databaseProvider);
  return db.select(db.symptomLogs).watch().map((logs) {
    return logs.map((l) => DateTime(l.date.year, l.date.month, l.date.day)).toSet();
  });
});

final datesWithIntimacyLogsProvider = StreamProvider<Set<DateTime>>((ref) {
  final db = ref.watch(databaseProvider);
  return db.select(db.intercourseLogs).watch().map((logs) {
    return logs.map((l) => DateTime(l.date.year, l.date.month, l.date.day)).toSet();
  });
});

final datesWithSpottingProvider = StreamProvider<Set<DateTime>>((ref) {
  final db = ref.watch(databaseProvider);
  return (db.select(db.flowLogs)..where((t) => t.flowLevel.equals('Spotting')))
      .watch()
      .map((logs) {
    return logs.map((l) => DateTime(l.date.year, l.date.month, l.date.day)).toSet();
  });
});

final symptomLogsForDateProvider = StreamProvider.family<List<SymptomLog>, DateTime>((ref, date) {
  final db = ref.watch(databaseProvider);
  final startOfDay = DateTime(date.year, date.month, date.day);
  final endOfDay = startOfDay.add(const Duration(days: 1));
  return (db.select(db.symptomLogs)
        ..where((s) => s.date.isBiggerOrEqualValue(startOfDay) & s.date.isSmallerThanValue(endOfDay)))
      .watch();
});

final mucusLogsForDateProvider = StreamProvider.family<List<MucusLog>, DateTime>((ref, date) {
  final db = ref.watch(databaseProvider);
  final startOfDay = DateTime(date.year, date.month, date.day);
  final endOfDay = startOfDay.add(const Duration(days: 1));
  return (db.select(db.mucusLogs)
        ..where((m) => m.date.isBiggerOrEqualValue(startOfDay) & m.date.isSmallerThanValue(endOfDay)))
      .watch();
});

final bbtLogsForDateProvider = StreamProvider.family<List<BbtLog>, DateTime>((ref, date) {
  final db = ref.watch(databaseProvider);
  final startOfDay = DateTime(date.year, date.month, date.day);
  final endOfDay = startOfDay.add(const Duration(days: 1));
  return (db.select(db.bbtLogs)
        ..where((b) => b.date.isBiggerOrEqualValue(startOfDay) & b.date.isSmallerThanValue(endOfDay)))
      .watch();
});

final opkLogsForDateProvider = StreamProvider.family<List<OpkLog>, DateTime>((ref, date) {
  final db = ref.watch(databaseProvider);
  final startOfDay = DateTime(date.year, date.month, date.day);
  final endOfDay = startOfDay.add(const Duration(days: 1));
  return (db.select(db.opkLogs)
        ..where((o) => o.date.isBiggerOrEqualValue(startOfDay) & o.date.isSmallerThanValue(endOfDay)))
      .watch();
});

final intercourseLogsForDateProvider = StreamProvider.family<List<IntercourseLog>, DateTime>((ref, date) {
  final db = ref.watch(databaseProvider);
  final startOfDay = DateTime(date.year, date.month, date.day);
  final endOfDay = startOfDay.add(const Duration(days: 1));
  return (db.select(db.intercourseLogs)
        ..where((i) => i.date.isBiggerOrEqualValue(startOfDay) & i.date.isSmallerThanValue(endOfDay)))
      .watch();
});
