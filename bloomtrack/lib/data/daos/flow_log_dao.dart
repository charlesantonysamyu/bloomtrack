import 'package:drift/drift.dart';

import 'package:bloomtrack/data/database.dart';
import 'package:bloomtrack/data/tables/tables.dart';

part 'flow_log_dao.g.dart';

/// Data-access object for the [FlowLogs] table.
///
/// Provides insert / delete helpers, date and date-range look-ups, and a
/// reactive stream that emits whenever the logs for a specific date change.
@DriftAccessor(tables: [FlowLogs])
class FlowLogDao extends DatabaseAccessor<AppDatabase> with _$FlowLogDaoMixin {
  FlowLogDao(super.db);

  /// Inserts a new flow log entry and returns its auto-generated id.
  Future<int> insertFlowLog(FlowLogsCompanion entry) =>
      into(flowLogs).insert(entry);

  /// Returns all flow log entries recorded on [date].
  ///
  /// Comparison is performed on the calendar day (ignoring the time component).
  Future<List<FlowLog>> getFlowLogsForDate(DateTime date) {
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    return (select(flowLogs)
          ..where((f) =>
              f.date.isBiggerOrEqualValue(startOfDay) &
              f.date.isSmallerThanValue(endOfDay)))
        .get();
  }

  /// Returns all flow log entries between [start] (inclusive) and [end]
  /// (exclusive).
  Future<List<FlowLog>> getFlowLogsForDateRange(
    DateTime start,
    DateTime end,
  ) {
    return (select(flowLogs)
          ..where((f) =>
              f.date.isBiggerOrEqualValue(start) &
              f.date.isSmallerThanValue(end))
          ..orderBy([(f) => OrderingTerm.asc(f.date)]))
        .get();
  }

  /// Deletes the flow log entry with the given [id].
  Future<int> deleteFlowLog(int id) =>
      (delete(flowLogs)..where((f) => f.id.equals(id))).go();

  /// Watches all flow log entries for [date] and emits whenever they change.
  Stream<List<FlowLog>> watchFlowLogsForDate(DateTime date) {
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    return (select(flowLogs)
          ..where((f) =>
              f.date.isBiggerOrEqualValue(startOfDay) &
              f.date.isSmallerThanValue(endOfDay)))
        .watch();
  }

  /// Returns the most recent flow log entry.
  Future<FlowLog?> getLatestFlowLog() {
    return (select(flowLogs)
          ..orderBy([(f) => OrderingTerm.desc(f.date)])
          ..limit(1))
        .getSingleOrNull();
  }
}
