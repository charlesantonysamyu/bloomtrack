import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bloomtrack/data/database.dart';
import 'package:bloomtrack/data/providers/database_provider.dart';

final activeCycleProvider = StreamProvider<Cycle?>((ref) {
  final cycleDao = ref.watch(cycleDaoProvider);
  return cycleDao.watchActiveCycle();
});

final recentCyclesProvider = FutureProvider<List<Cycle>>((ref) async {
  final cycleDao = ref.watch(cycleDaoProvider);
  return cycleDao.getLastNCycles(6);
});

final allCyclesProvider = StreamProvider<List<Cycle>>((ref) {
  final cycleDao = ref.watch(cycleDaoProvider);
  return cycleDao.getAllCycles().asStream();
});
