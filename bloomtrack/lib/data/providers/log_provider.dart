import 'package:flutter_riverpod/flutter_riverpod.dart';
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
