import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bloomtrack/data/database.dart';
import 'package:bloomtrack/data/daos/cycle_dao.dart';
import 'package:bloomtrack/data/daos/flow_log_dao.dart';

final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase.open();
  ref.onDispose(() {
    db.close();
  });
  return db;
});

final cycleDaoProvider = Provider<CycleDao>((ref) {
  return ref.watch(databaseProvider).cycleDao;
});

final flowLogDaoProvider = Provider<FlowLogDao>((ref) {
  return ref.watch(databaseProvider).flowLogDao;
});
