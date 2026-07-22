import 'package:drift/drift.dart';

import 'package:bloomtrack/data/database.dart';
import 'package:bloomtrack/data/tables/tables.dart';

part 'cycle_dao.g.dart';

/// Data-access object for the [Cycles] table.
///
/// Provides insert / update helpers, active-cycle look-ups, and both one-shot
/// and streaming queries ordered by start date.
@DriftAccessor(tables: [Cycles])
class CycleDao extends DatabaseAccessor<AppDatabase> with _$CycleDaoMixin {
  CycleDao(super.db);

  /// Inserts a new cycle and returns its auto-generated id.
  Future<int> insertCycle(CyclesCompanion entry) =>
      into(cycles).insert(entry);

  /// Updates an existing [cycle] row. Returns `true` if exactly one row was
  /// affected.
  Future<bool> updateCycle(Cycle cycle) => update(cycles).replace(cycle);

  /// Returns the currently-active cycle (one whose [Cycles.endDate] is null),
  /// or `null` if no cycle is active.
  Future<Cycle?> getActiveCycle() =>
      (select(cycles)..where((c) => c.endDate.isNull())).getSingleOrNull();

  /// Returns the most recent [n] cycles ordered by [Cycles.startDate]
  /// descending.
  Future<List<Cycle>> getLastNCycles(int n) => (select(cycles)
        ..orderBy([(c) => OrderingTerm.desc(c.startDate)])
        ..limit(n))
      .get();

  /// Returns every cycle in the database ordered by [Cycles.startDate]
  /// descending.
  Future<List<Cycle>> getAllCycles() => (select(cycles)
        ..orderBy([(c) => OrderingTerm.desc(c.startDate)]))
      .get();

  /// Watches the active cycle and emits a new value whenever it changes.
  Stream<Cycle?> watchActiveCycle() =>
      (select(cycles)..where((c) => c.endDate.isNull()))
          .watchSingleOrNull();

  /// Marks the cycle with the given [id] as ended on [endDate] (the day before the next period).
  Future<void> endCycle(int id, DateTime endDate) async {
    final cycleRow = await (select(cycles)
          ..where((c) => c.id.equals(id)))
        .getSingle();

    // +1 because if cycle started Jan 1 and ended Jan 28, it's 28 days long (28 - 1 = 27; +1 = 28)
    final cycleLength = endDate.difference(cycleRow.startDate).inDays + 1;

    await (update(cycles)..where((c) => c.id.equals(id))).write(
      CyclesCompanion(
        endDate: Value(endDate),
        cycleLength: Value(cycleLength),
      ),
    );
  }

  /// Updates the period length of a cycle without ending it.
  Future<void> updatePeriodLength(int id, int periodLength) async {
    await (update(cycles)..where((c) => c.id.equals(id))).write(
      CyclesCompanion(
        periodLength: Value(periodLength),
      ),
    );
  }
}
