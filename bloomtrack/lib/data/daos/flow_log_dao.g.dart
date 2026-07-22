// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flow_log_dao.dart';

// ignore_for_file: type=lint
mixin _$FlowLogDaoMixin on DatabaseAccessor<AppDatabase> {
  $FlowLogsTable get flowLogs => attachedDatabase.flowLogs;
  FlowLogDaoManager get managers => FlowLogDaoManager(this);
}

class FlowLogDaoManager {
  final _$FlowLogDaoMixin _db;
  FlowLogDaoManager(this._db);
  $$FlowLogsTableTableManager get flowLogs =>
      $$FlowLogsTableTableManager(_db.attachedDatabase, _db.flowLogs);
}
