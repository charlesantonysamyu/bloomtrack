import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import 'package:bloomtrack/data/tables/tables.dart';
import 'package:bloomtrack/data/daos/cycle_dao.dart';
import 'package:bloomtrack/data/daos/flow_log_dao.dart';

part 'database.g.dart';

/// The single Drift database for BloomTrack.
///
/// Contains all ten domain tables and exposes typed DAOs for the most common
/// query patterns. Use the [open] factory to obtain a ready-to-use instance
/// backed by a SQLite file on the device.
@DriftDatabase(
  tables: [
    Profile,
    Cycles,
    FlowLogs,
    SymptomLogs,
    MucusLogs,
    BbtLogs,
    OpkLogs,
    IntercourseLogs,
    Predictions,
    Reminders,
  ],
  daos: [
    CycleDao,
    FlowLogDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  /// Creates an [AppDatabase] from an existing [QueryExecutor].
  ///
  /// Prefer using the [open] factory instead of calling this directly.
  AppDatabase(super.e);

  @override
  int get schemaVersion => 1;

  /// Opens (or creates) the BloomTrack database file on disk.
  ///
  /// The [driftDatabase] helper from `drift_flutter` automatically resolves the
  /// correct application-support directory on each platform. If an
  /// [encryptionKey] is supplied it can be forwarded to a native encryption
  /// build (e.g. `sqlcipher_flutter_libs`) — this is left as a future
  /// enhancement.
  static AppDatabase open({String? encryptionKey}) {
    return AppDatabase(
      driftDatabase(name: 'bloomtrack'),
    );
  }
}
