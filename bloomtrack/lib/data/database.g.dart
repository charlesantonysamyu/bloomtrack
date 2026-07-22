// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $ProfileTable extends Profile with TableInfo<$ProfileTable, ProfileData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProfileTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _cycleGoalMeta = const VerificationMeta(
    'cycleGoal',
  );
  @override
  late final GeneratedColumn<String> cycleGoal = GeneratedColumn<String>(
    'cycle_goal',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _avgCycleLengthMeta = const VerificationMeta(
    'avgCycleLength',
  );
  @override
  late final GeneratedColumn<int> avgCycleLength = GeneratedColumn<int>(
    'avg_cycle_length',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(28),
  );
  static const VerificationMeta _avgPeriodLengthMeta = const VerificationMeta(
    'avgPeriodLength',
  );
  @override
  late final GeneratedColumn<int> avgPeriodLength = GeneratedColumn<int>(
    'avg_period_length',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(5),
  );
  static const VerificationMeta _lutealPhaseMeta = const VerificationMeta(
    'lutealPhase',
  );
  @override
  late final GeneratedColumn<int> lutealPhase = GeneratedColumn<int>(
    'luteal_phase',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(14),
  );
  static const VerificationMeta _dobMeta = const VerificationMeta('dob');
  @override
  late final GeneratedColumn<DateTime> dob = GeneratedColumn<DateTime>(
    'dob',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _remindersEnabledMeta = const VerificationMeta(
    'remindersEnabled',
  );
  @override
  late final GeneratedColumn<bool> remindersEnabled = GeneratedColumn<bool>(
    'reminders_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("reminders_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    cycleGoal,
    avgCycleLength,
    avgPeriodLength,
    lutealPhase,
    dob,
    remindersEnabled,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'profile';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProfileData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('cycle_goal')) {
      context.handle(
        _cycleGoalMeta,
        cycleGoal.isAcceptableOrUnknown(data['cycle_goal']!, _cycleGoalMeta),
      );
    } else if (isInserting) {
      context.missing(_cycleGoalMeta);
    }
    if (data.containsKey('avg_cycle_length')) {
      context.handle(
        _avgCycleLengthMeta,
        avgCycleLength.isAcceptableOrUnknown(
          data['avg_cycle_length']!,
          _avgCycleLengthMeta,
        ),
      );
    }
    if (data.containsKey('avg_period_length')) {
      context.handle(
        _avgPeriodLengthMeta,
        avgPeriodLength.isAcceptableOrUnknown(
          data['avg_period_length']!,
          _avgPeriodLengthMeta,
        ),
      );
    }
    if (data.containsKey('luteal_phase')) {
      context.handle(
        _lutealPhaseMeta,
        lutealPhase.isAcceptableOrUnknown(
          data['luteal_phase']!,
          _lutealPhaseMeta,
        ),
      );
    }
    if (data.containsKey('dob')) {
      context.handle(
        _dobMeta,
        dob.isAcceptableOrUnknown(data['dob']!, _dobMeta),
      );
    }
    if (data.containsKey('reminders_enabled')) {
      context.handle(
        _remindersEnabledMeta,
        remindersEnabled.isAcceptableOrUnknown(
          data['reminders_enabled']!,
          _remindersEnabledMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProfileData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProfileData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      cycleGoal: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cycle_goal'],
      )!,
      avgCycleLength: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}avg_cycle_length'],
      )!,
      avgPeriodLength: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}avg_period_length'],
      )!,
      lutealPhase: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}luteal_phase'],
      )!,
      dob: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}dob'],
      ),
      remindersEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}reminders_enabled'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $ProfileTable createAlias(String alias) {
    return $ProfileTable(attachedDatabase, alias);
  }
}

class ProfileData extends DataClass implements Insertable<ProfileData> {
  final int id;
  final String cycleGoal;
  final int avgCycleLength;
  final int avgPeriodLength;
  final int lutealPhase;
  final DateTime? dob;
  final bool remindersEnabled;
  final DateTime createdAt;
  const ProfileData({
    required this.id,
    required this.cycleGoal,
    required this.avgCycleLength,
    required this.avgPeriodLength,
    required this.lutealPhase,
    this.dob,
    required this.remindersEnabled,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['cycle_goal'] = Variable<String>(cycleGoal);
    map['avg_cycle_length'] = Variable<int>(avgCycleLength);
    map['avg_period_length'] = Variable<int>(avgPeriodLength);
    map['luteal_phase'] = Variable<int>(lutealPhase);
    if (!nullToAbsent || dob != null) {
      map['dob'] = Variable<DateTime>(dob);
    }
    map['reminders_enabled'] = Variable<bool>(remindersEnabled);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ProfileCompanion toCompanion(bool nullToAbsent) {
    return ProfileCompanion(
      id: Value(id),
      cycleGoal: Value(cycleGoal),
      avgCycleLength: Value(avgCycleLength),
      avgPeriodLength: Value(avgPeriodLength),
      lutealPhase: Value(lutealPhase),
      dob: dob == null && nullToAbsent ? const Value.absent() : Value(dob),
      remindersEnabled: Value(remindersEnabled),
      createdAt: Value(createdAt),
    );
  }

  factory ProfileData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProfileData(
      id: serializer.fromJson<int>(json['id']),
      cycleGoal: serializer.fromJson<String>(json['cycleGoal']),
      avgCycleLength: serializer.fromJson<int>(json['avgCycleLength']),
      avgPeriodLength: serializer.fromJson<int>(json['avgPeriodLength']),
      lutealPhase: serializer.fromJson<int>(json['lutealPhase']),
      dob: serializer.fromJson<DateTime?>(json['dob']),
      remindersEnabled: serializer.fromJson<bool>(json['remindersEnabled']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'cycleGoal': serializer.toJson<String>(cycleGoal),
      'avgCycleLength': serializer.toJson<int>(avgCycleLength),
      'avgPeriodLength': serializer.toJson<int>(avgPeriodLength),
      'lutealPhase': serializer.toJson<int>(lutealPhase),
      'dob': serializer.toJson<DateTime?>(dob),
      'remindersEnabled': serializer.toJson<bool>(remindersEnabled),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  ProfileData copyWith({
    int? id,
    String? cycleGoal,
    int? avgCycleLength,
    int? avgPeriodLength,
    int? lutealPhase,
    Value<DateTime?> dob = const Value.absent(),
    bool? remindersEnabled,
    DateTime? createdAt,
  }) => ProfileData(
    id: id ?? this.id,
    cycleGoal: cycleGoal ?? this.cycleGoal,
    avgCycleLength: avgCycleLength ?? this.avgCycleLength,
    avgPeriodLength: avgPeriodLength ?? this.avgPeriodLength,
    lutealPhase: lutealPhase ?? this.lutealPhase,
    dob: dob.present ? dob.value : this.dob,
    remindersEnabled: remindersEnabled ?? this.remindersEnabled,
    createdAt: createdAt ?? this.createdAt,
  );
  ProfileData copyWithCompanion(ProfileCompanion data) {
    return ProfileData(
      id: data.id.present ? data.id.value : this.id,
      cycleGoal: data.cycleGoal.present ? data.cycleGoal.value : this.cycleGoal,
      avgCycleLength: data.avgCycleLength.present
          ? data.avgCycleLength.value
          : this.avgCycleLength,
      avgPeriodLength: data.avgPeriodLength.present
          ? data.avgPeriodLength.value
          : this.avgPeriodLength,
      lutealPhase: data.lutealPhase.present
          ? data.lutealPhase.value
          : this.lutealPhase,
      dob: data.dob.present ? data.dob.value : this.dob,
      remindersEnabled: data.remindersEnabled.present
          ? data.remindersEnabled.value
          : this.remindersEnabled,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProfileData(')
          ..write('id: $id, ')
          ..write('cycleGoal: $cycleGoal, ')
          ..write('avgCycleLength: $avgCycleLength, ')
          ..write('avgPeriodLength: $avgPeriodLength, ')
          ..write('lutealPhase: $lutealPhase, ')
          ..write('dob: $dob, ')
          ..write('remindersEnabled: $remindersEnabled, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    cycleGoal,
    avgCycleLength,
    avgPeriodLength,
    lutealPhase,
    dob,
    remindersEnabled,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProfileData &&
          other.id == this.id &&
          other.cycleGoal == this.cycleGoal &&
          other.avgCycleLength == this.avgCycleLength &&
          other.avgPeriodLength == this.avgPeriodLength &&
          other.lutealPhase == this.lutealPhase &&
          other.dob == this.dob &&
          other.remindersEnabled == this.remindersEnabled &&
          other.createdAt == this.createdAt);
}

class ProfileCompanion extends UpdateCompanion<ProfileData> {
  final Value<int> id;
  final Value<String> cycleGoal;
  final Value<int> avgCycleLength;
  final Value<int> avgPeriodLength;
  final Value<int> lutealPhase;
  final Value<DateTime?> dob;
  final Value<bool> remindersEnabled;
  final Value<DateTime> createdAt;
  const ProfileCompanion({
    this.id = const Value.absent(),
    this.cycleGoal = const Value.absent(),
    this.avgCycleLength = const Value.absent(),
    this.avgPeriodLength = const Value.absent(),
    this.lutealPhase = const Value.absent(),
    this.dob = const Value.absent(),
    this.remindersEnabled = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  ProfileCompanion.insert({
    this.id = const Value.absent(),
    required String cycleGoal,
    this.avgCycleLength = const Value.absent(),
    this.avgPeriodLength = const Value.absent(),
    this.lutealPhase = const Value.absent(),
    this.dob = const Value.absent(),
    this.remindersEnabled = const Value.absent(),
    required DateTime createdAt,
  }) : cycleGoal = Value(cycleGoal),
       createdAt = Value(createdAt);
  static Insertable<ProfileData> custom({
    Expression<int>? id,
    Expression<String>? cycleGoal,
    Expression<int>? avgCycleLength,
    Expression<int>? avgPeriodLength,
    Expression<int>? lutealPhase,
    Expression<DateTime>? dob,
    Expression<bool>? remindersEnabled,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (cycleGoal != null) 'cycle_goal': cycleGoal,
      if (avgCycleLength != null) 'avg_cycle_length': avgCycleLength,
      if (avgPeriodLength != null) 'avg_period_length': avgPeriodLength,
      if (lutealPhase != null) 'luteal_phase': lutealPhase,
      if (dob != null) 'dob': dob,
      if (remindersEnabled != null) 'reminders_enabled': remindersEnabled,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  ProfileCompanion copyWith({
    Value<int>? id,
    Value<String>? cycleGoal,
    Value<int>? avgCycleLength,
    Value<int>? avgPeriodLength,
    Value<int>? lutealPhase,
    Value<DateTime?>? dob,
    Value<bool>? remindersEnabled,
    Value<DateTime>? createdAt,
  }) {
    return ProfileCompanion(
      id: id ?? this.id,
      cycleGoal: cycleGoal ?? this.cycleGoal,
      avgCycleLength: avgCycleLength ?? this.avgCycleLength,
      avgPeriodLength: avgPeriodLength ?? this.avgPeriodLength,
      lutealPhase: lutealPhase ?? this.lutealPhase,
      dob: dob ?? this.dob,
      remindersEnabled: remindersEnabled ?? this.remindersEnabled,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (cycleGoal.present) {
      map['cycle_goal'] = Variable<String>(cycleGoal.value);
    }
    if (avgCycleLength.present) {
      map['avg_cycle_length'] = Variable<int>(avgCycleLength.value);
    }
    if (avgPeriodLength.present) {
      map['avg_period_length'] = Variable<int>(avgPeriodLength.value);
    }
    if (lutealPhase.present) {
      map['luteal_phase'] = Variable<int>(lutealPhase.value);
    }
    if (dob.present) {
      map['dob'] = Variable<DateTime>(dob.value);
    }
    if (remindersEnabled.present) {
      map['reminders_enabled'] = Variable<bool>(remindersEnabled.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProfileCompanion(')
          ..write('id: $id, ')
          ..write('cycleGoal: $cycleGoal, ')
          ..write('avgCycleLength: $avgCycleLength, ')
          ..write('avgPeriodLength: $avgPeriodLength, ')
          ..write('lutealPhase: $lutealPhase, ')
          ..write('dob: $dob, ')
          ..write('remindersEnabled: $remindersEnabled, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $CyclesTable extends Cycles with TableInfo<$CyclesTable, Cycle> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CyclesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _startDateMeta = const VerificationMeta(
    'startDate',
  );
  @override
  late final GeneratedColumn<DateTime> startDate = GeneratedColumn<DateTime>(
    'start_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endDateMeta = const VerificationMeta(
    'endDate',
  );
  @override
  late final GeneratedColumn<DateTime> endDate = GeneratedColumn<DateTime>(
    'end_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _cycleLengthMeta = const VerificationMeta(
    'cycleLength',
  );
  @override
  late final GeneratedColumn<int> cycleLength = GeneratedColumn<int>(
    'cycle_length',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _periodLengthMeta = const VerificationMeta(
    'periodLength',
  );
  @override
  late final GeneratedColumn<int> periodLength = GeneratedColumn<int>(
    'period_length',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    startDate,
    endDate,
    cycleLength,
    periodLength,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cycles';
  @override
  VerificationContext validateIntegrity(
    Insertable<Cycle> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('start_date')) {
      context.handle(
        _startDateMeta,
        startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta),
      );
    } else if (isInserting) {
      context.missing(_startDateMeta);
    }
    if (data.containsKey('end_date')) {
      context.handle(
        _endDateMeta,
        endDate.isAcceptableOrUnknown(data['end_date']!, _endDateMeta),
      );
    }
    if (data.containsKey('cycle_length')) {
      context.handle(
        _cycleLengthMeta,
        cycleLength.isAcceptableOrUnknown(
          data['cycle_length']!,
          _cycleLengthMeta,
        ),
      );
    }
    if (data.containsKey('period_length')) {
      context.handle(
        _periodLengthMeta,
        periodLength.isAcceptableOrUnknown(
          data['period_length']!,
          _periodLengthMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Cycle map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Cycle(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      startDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start_date'],
      )!,
      endDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}end_date'],
      ),
      cycleLength: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cycle_length'],
      ),
      periodLength: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}period_length'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
    );
  }

  @override
  $CyclesTable createAlias(String alias) {
    return $CyclesTable(attachedDatabase, alias);
  }
}

class Cycle extends DataClass implements Insertable<Cycle> {
  final int id;
  final DateTime startDate;
  final DateTime? endDate;
  final int? cycleLength;
  final int? periodLength;
  final String? notes;
  const Cycle({
    required this.id,
    required this.startDate,
    this.endDate,
    this.cycleLength,
    this.periodLength,
    this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['start_date'] = Variable<DateTime>(startDate);
    if (!nullToAbsent || endDate != null) {
      map['end_date'] = Variable<DateTime>(endDate);
    }
    if (!nullToAbsent || cycleLength != null) {
      map['cycle_length'] = Variable<int>(cycleLength);
    }
    if (!nullToAbsent || periodLength != null) {
      map['period_length'] = Variable<int>(periodLength);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  CyclesCompanion toCompanion(bool nullToAbsent) {
    return CyclesCompanion(
      id: Value(id),
      startDate: Value(startDate),
      endDate: endDate == null && nullToAbsent
          ? const Value.absent()
          : Value(endDate),
      cycleLength: cycleLength == null && nullToAbsent
          ? const Value.absent()
          : Value(cycleLength),
      periodLength: periodLength == null && nullToAbsent
          ? const Value.absent()
          : Value(periodLength),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
    );
  }

  factory Cycle.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Cycle(
      id: serializer.fromJson<int>(json['id']),
      startDate: serializer.fromJson<DateTime>(json['startDate']),
      endDate: serializer.fromJson<DateTime?>(json['endDate']),
      cycleLength: serializer.fromJson<int?>(json['cycleLength']),
      periodLength: serializer.fromJson<int?>(json['periodLength']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'startDate': serializer.toJson<DateTime>(startDate),
      'endDate': serializer.toJson<DateTime?>(endDate),
      'cycleLength': serializer.toJson<int?>(cycleLength),
      'periodLength': serializer.toJson<int?>(periodLength),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  Cycle copyWith({
    int? id,
    DateTime? startDate,
    Value<DateTime?> endDate = const Value.absent(),
    Value<int?> cycleLength = const Value.absent(),
    Value<int?> periodLength = const Value.absent(),
    Value<String?> notes = const Value.absent(),
  }) => Cycle(
    id: id ?? this.id,
    startDate: startDate ?? this.startDate,
    endDate: endDate.present ? endDate.value : this.endDate,
    cycleLength: cycleLength.present ? cycleLength.value : this.cycleLength,
    periodLength: periodLength.present ? periodLength.value : this.periodLength,
    notes: notes.present ? notes.value : this.notes,
  );
  Cycle copyWithCompanion(CyclesCompanion data) {
    return Cycle(
      id: data.id.present ? data.id.value : this.id,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      endDate: data.endDate.present ? data.endDate.value : this.endDate,
      cycleLength: data.cycleLength.present
          ? data.cycleLength.value
          : this.cycleLength,
      periodLength: data.periodLength.present
          ? data.periodLength.value
          : this.periodLength,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Cycle(')
          ..write('id: $id, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('cycleLength: $cycleLength, ')
          ..write('periodLength: $periodLength, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, startDate, endDate, cycleLength, periodLength, notes);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Cycle &&
          other.id == this.id &&
          other.startDate == this.startDate &&
          other.endDate == this.endDate &&
          other.cycleLength == this.cycleLength &&
          other.periodLength == this.periodLength &&
          other.notes == this.notes);
}

class CyclesCompanion extends UpdateCompanion<Cycle> {
  final Value<int> id;
  final Value<DateTime> startDate;
  final Value<DateTime?> endDate;
  final Value<int?> cycleLength;
  final Value<int?> periodLength;
  final Value<String?> notes;
  const CyclesCompanion({
    this.id = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.cycleLength = const Value.absent(),
    this.periodLength = const Value.absent(),
    this.notes = const Value.absent(),
  });
  CyclesCompanion.insert({
    this.id = const Value.absent(),
    required DateTime startDate,
    this.endDate = const Value.absent(),
    this.cycleLength = const Value.absent(),
    this.periodLength = const Value.absent(),
    this.notes = const Value.absent(),
  }) : startDate = Value(startDate);
  static Insertable<Cycle> custom({
    Expression<int>? id,
    Expression<DateTime>? startDate,
    Expression<DateTime>? endDate,
    Expression<int>? cycleLength,
    Expression<int>? periodLength,
    Expression<String>? notes,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (startDate != null) 'start_date': startDate,
      if (endDate != null) 'end_date': endDate,
      if (cycleLength != null) 'cycle_length': cycleLength,
      if (periodLength != null) 'period_length': periodLength,
      if (notes != null) 'notes': notes,
    });
  }

  CyclesCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? startDate,
    Value<DateTime?>? endDate,
    Value<int?>? cycleLength,
    Value<int?>? periodLength,
    Value<String?>? notes,
  }) {
    return CyclesCompanion(
      id: id ?? this.id,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      cycleLength: cycleLength ?? this.cycleLength,
      periodLength: periodLength ?? this.periodLength,
      notes: notes ?? this.notes,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<DateTime>(startDate.value);
    }
    if (endDate.present) {
      map['end_date'] = Variable<DateTime>(endDate.value);
    }
    if (cycleLength.present) {
      map['cycle_length'] = Variable<int>(cycleLength.value);
    }
    if (periodLength.present) {
      map['period_length'] = Variable<int>(periodLength.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CyclesCompanion(')
          ..write('id: $id, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('cycleLength: $cycleLength, ')
          ..write('periodLength: $periodLength, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }
}

class $FlowLogsTable extends FlowLogs with TableInfo<$FlowLogsTable, FlowLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FlowLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _flowLevelMeta = const VerificationMeta(
    'flowLevel',
  );
  @override
  late final GeneratedColumn<String> flowLevel = GeneratedColumn<String>(
    'flow_level',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bloodColorMeta = const VerificationMeta(
    'bloodColor',
  );
  @override
  late final GeneratedColumn<String> bloodColor = GeneratedColumn<String>(
    'blood_color',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _hasClotsMeta = const VerificationMeta(
    'hasClots',
  );
  @override
  late final GeneratedColumn<bool> hasClots = GeneratedColumn<bool>(
    'has_clots',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("has_clots" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _clotSizeMeta = const VerificationMeta(
    'clotSize',
  );
  @override
  late final GeneratedColumn<String> clotSize = GeneratedColumn<String>(
    'clot_size',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _padsCountMeta = const VerificationMeta(
    'padsCount',
  );
  @override
  late final GeneratedColumn<int> padsCount = GeneratedColumn<int>(
    'pads_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _tamponsCountMeta = const VerificationMeta(
    'tamponsCount',
  );
  @override
  late final GeneratedColumn<int> tamponsCount = GeneratedColumn<int>(
    'tampons_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _cupDiscMeta = const VerificationMeta(
    'cupDisc',
  );
  @override
  late final GeneratedColumn<bool> cupDisc = GeneratedColumn<bool>(
    'cup_disc',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("cup_disc" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    date,
    flowLevel,
    bloodColor,
    hasClots,
    clotSize,
    padsCount,
    tamponsCount,
    cupDisc,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'flow_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<FlowLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('flow_level')) {
      context.handle(
        _flowLevelMeta,
        flowLevel.isAcceptableOrUnknown(data['flow_level']!, _flowLevelMeta),
      );
    } else if (isInserting) {
      context.missing(_flowLevelMeta);
    }
    if (data.containsKey('blood_color')) {
      context.handle(
        _bloodColorMeta,
        bloodColor.isAcceptableOrUnknown(data['blood_color']!, _bloodColorMeta),
      );
    }
    if (data.containsKey('has_clots')) {
      context.handle(
        _hasClotsMeta,
        hasClots.isAcceptableOrUnknown(data['has_clots']!, _hasClotsMeta),
      );
    }
    if (data.containsKey('clot_size')) {
      context.handle(
        _clotSizeMeta,
        clotSize.isAcceptableOrUnknown(data['clot_size']!, _clotSizeMeta),
      );
    }
    if (data.containsKey('pads_count')) {
      context.handle(
        _padsCountMeta,
        padsCount.isAcceptableOrUnknown(data['pads_count']!, _padsCountMeta),
      );
    }
    if (data.containsKey('tampons_count')) {
      context.handle(
        _tamponsCountMeta,
        tamponsCount.isAcceptableOrUnknown(
          data['tampons_count']!,
          _tamponsCountMeta,
        ),
      );
    }
    if (data.containsKey('cup_disc')) {
      context.handle(
        _cupDiscMeta,
        cupDisc.isAcceptableOrUnknown(data['cup_disc']!, _cupDiscMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FlowLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FlowLog(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      flowLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}flow_level'],
      )!,
      bloodColor: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}blood_color'],
      ),
      hasClots: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}has_clots'],
      )!,
      clotSize: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}clot_size'],
      ),
      padsCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pads_count'],
      )!,
      tamponsCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tampons_count'],
      )!,
      cupDisc: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}cup_disc'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
    );
  }

  @override
  $FlowLogsTable createAlias(String alias) {
    return $FlowLogsTable(attachedDatabase, alias);
  }
}

class FlowLog extends DataClass implements Insertable<FlowLog> {
  final int id;
  final DateTime date;
  final String flowLevel;
  final String? bloodColor;
  final bool hasClots;
  final String? clotSize;
  final int padsCount;
  final int tamponsCount;
  final bool cupDisc;
  final String? notes;
  const FlowLog({
    required this.id,
    required this.date,
    required this.flowLevel,
    this.bloodColor,
    required this.hasClots,
    this.clotSize,
    required this.padsCount,
    required this.tamponsCount,
    required this.cupDisc,
    this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['date'] = Variable<DateTime>(date);
    map['flow_level'] = Variable<String>(flowLevel);
    if (!nullToAbsent || bloodColor != null) {
      map['blood_color'] = Variable<String>(bloodColor);
    }
    map['has_clots'] = Variable<bool>(hasClots);
    if (!nullToAbsent || clotSize != null) {
      map['clot_size'] = Variable<String>(clotSize);
    }
    map['pads_count'] = Variable<int>(padsCount);
    map['tampons_count'] = Variable<int>(tamponsCount);
    map['cup_disc'] = Variable<bool>(cupDisc);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  FlowLogsCompanion toCompanion(bool nullToAbsent) {
    return FlowLogsCompanion(
      id: Value(id),
      date: Value(date),
      flowLevel: Value(flowLevel),
      bloodColor: bloodColor == null && nullToAbsent
          ? const Value.absent()
          : Value(bloodColor),
      hasClots: Value(hasClots),
      clotSize: clotSize == null && nullToAbsent
          ? const Value.absent()
          : Value(clotSize),
      padsCount: Value(padsCount),
      tamponsCount: Value(tamponsCount),
      cupDisc: Value(cupDisc),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
    );
  }

  factory FlowLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FlowLog(
      id: serializer.fromJson<int>(json['id']),
      date: serializer.fromJson<DateTime>(json['date']),
      flowLevel: serializer.fromJson<String>(json['flowLevel']),
      bloodColor: serializer.fromJson<String?>(json['bloodColor']),
      hasClots: serializer.fromJson<bool>(json['hasClots']),
      clotSize: serializer.fromJson<String?>(json['clotSize']),
      padsCount: serializer.fromJson<int>(json['padsCount']),
      tamponsCount: serializer.fromJson<int>(json['tamponsCount']),
      cupDisc: serializer.fromJson<bool>(json['cupDisc']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'date': serializer.toJson<DateTime>(date),
      'flowLevel': serializer.toJson<String>(flowLevel),
      'bloodColor': serializer.toJson<String?>(bloodColor),
      'hasClots': serializer.toJson<bool>(hasClots),
      'clotSize': serializer.toJson<String?>(clotSize),
      'padsCount': serializer.toJson<int>(padsCount),
      'tamponsCount': serializer.toJson<int>(tamponsCount),
      'cupDisc': serializer.toJson<bool>(cupDisc),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  FlowLog copyWith({
    int? id,
    DateTime? date,
    String? flowLevel,
    Value<String?> bloodColor = const Value.absent(),
    bool? hasClots,
    Value<String?> clotSize = const Value.absent(),
    int? padsCount,
    int? tamponsCount,
    bool? cupDisc,
    Value<String?> notes = const Value.absent(),
  }) => FlowLog(
    id: id ?? this.id,
    date: date ?? this.date,
    flowLevel: flowLevel ?? this.flowLevel,
    bloodColor: bloodColor.present ? bloodColor.value : this.bloodColor,
    hasClots: hasClots ?? this.hasClots,
    clotSize: clotSize.present ? clotSize.value : this.clotSize,
    padsCount: padsCount ?? this.padsCount,
    tamponsCount: tamponsCount ?? this.tamponsCount,
    cupDisc: cupDisc ?? this.cupDisc,
    notes: notes.present ? notes.value : this.notes,
  );
  FlowLog copyWithCompanion(FlowLogsCompanion data) {
    return FlowLog(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      flowLevel: data.flowLevel.present ? data.flowLevel.value : this.flowLevel,
      bloodColor: data.bloodColor.present
          ? data.bloodColor.value
          : this.bloodColor,
      hasClots: data.hasClots.present ? data.hasClots.value : this.hasClots,
      clotSize: data.clotSize.present ? data.clotSize.value : this.clotSize,
      padsCount: data.padsCount.present ? data.padsCount.value : this.padsCount,
      tamponsCount: data.tamponsCount.present
          ? data.tamponsCount.value
          : this.tamponsCount,
      cupDisc: data.cupDisc.present ? data.cupDisc.value : this.cupDisc,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FlowLog(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('flowLevel: $flowLevel, ')
          ..write('bloodColor: $bloodColor, ')
          ..write('hasClots: $hasClots, ')
          ..write('clotSize: $clotSize, ')
          ..write('padsCount: $padsCount, ')
          ..write('tamponsCount: $tamponsCount, ')
          ..write('cupDisc: $cupDisc, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    date,
    flowLevel,
    bloodColor,
    hasClots,
    clotSize,
    padsCount,
    tamponsCount,
    cupDisc,
    notes,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FlowLog &&
          other.id == this.id &&
          other.date == this.date &&
          other.flowLevel == this.flowLevel &&
          other.bloodColor == this.bloodColor &&
          other.hasClots == this.hasClots &&
          other.clotSize == this.clotSize &&
          other.padsCount == this.padsCount &&
          other.tamponsCount == this.tamponsCount &&
          other.cupDisc == this.cupDisc &&
          other.notes == this.notes);
}

class FlowLogsCompanion extends UpdateCompanion<FlowLog> {
  final Value<int> id;
  final Value<DateTime> date;
  final Value<String> flowLevel;
  final Value<String?> bloodColor;
  final Value<bool> hasClots;
  final Value<String?> clotSize;
  final Value<int> padsCount;
  final Value<int> tamponsCount;
  final Value<bool> cupDisc;
  final Value<String?> notes;
  const FlowLogsCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.flowLevel = const Value.absent(),
    this.bloodColor = const Value.absent(),
    this.hasClots = const Value.absent(),
    this.clotSize = const Value.absent(),
    this.padsCount = const Value.absent(),
    this.tamponsCount = const Value.absent(),
    this.cupDisc = const Value.absent(),
    this.notes = const Value.absent(),
  });
  FlowLogsCompanion.insert({
    this.id = const Value.absent(),
    required DateTime date,
    required String flowLevel,
    this.bloodColor = const Value.absent(),
    this.hasClots = const Value.absent(),
    this.clotSize = const Value.absent(),
    this.padsCount = const Value.absent(),
    this.tamponsCount = const Value.absent(),
    this.cupDisc = const Value.absent(),
    this.notes = const Value.absent(),
  }) : date = Value(date),
       flowLevel = Value(flowLevel);
  static Insertable<FlowLog> custom({
    Expression<int>? id,
    Expression<DateTime>? date,
    Expression<String>? flowLevel,
    Expression<String>? bloodColor,
    Expression<bool>? hasClots,
    Expression<String>? clotSize,
    Expression<int>? padsCount,
    Expression<int>? tamponsCount,
    Expression<bool>? cupDisc,
    Expression<String>? notes,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (flowLevel != null) 'flow_level': flowLevel,
      if (bloodColor != null) 'blood_color': bloodColor,
      if (hasClots != null) 'has_clots': hasClots,
      if (clotSize != null) 'clot_size': clotSize,
      if (padsCount != null) 'pads_count': padsCount,
      if (tamponsCount != null) 'tampons_count': tamponsCount,
      if (cupDisc != null) 'cup_disc': cupDisc,
      if (notes != null) 'notes': notes,
    });
  }

  FlowLogsCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? date,
    Value<String>? flowLevel,
    Value<String?>? bloodColor,
    Value<bool>? hasClots,
    Value<String?>? clotSize,
    Value<int>? padsCount,
    Value<int>? tamponsCount,
    Value<bool>? cupDisc,
    Value<String?>? notes,
  }) {
    return FlowLogsCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      flowLevel: flowLevel ?? this.flowLevel,
      bloodColor: bloodColor ?? this.bloodColor,
      hasClots: hasClots ?? this.hasClots,
      clotSize: clotSize ?? this.clotSize,
      padsCount: padsCount ?? this.padsCount,
      tamponsCount: tamponsCount ?? this.tamponsCount,
      cupDisc: cupDisc ?? this.cupDisc,
      notes: notes ?? this.notes,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (flowLevel.present) {
      map['flow_level'] = Variable<String>(flowLevel.value);
    }
    if (bloodColor.present) {
      map['blood_color'] = Variable<String>(bloodColor.value);
    }
    if (hasClots.present) {
      map['has_clots'] = Variable<bool>(hasClots.value);
    }
    if (clotSize.present) {
      map['clot_size'] = Variable<String>(clotSize.value);
    }
    if (padsCount.present) {
      map['pads_count'] = Variable<int>(padsCount.value);
    }
    if (tamponsCount.present) {
      map['tampons_count'] = Variable<int>(tamponsCount.value);
    }
    if (cupDisc.present) {
      map['cup_disc'] = Variable<bool>(cupDisc.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FlowLogsCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('flowLevel: $flowLevel, ')
          ..write('bloodColor: $bloodColor, ')
          ..write('hasClots: $hasClots, ')
          ..write('clotSize: $clotSize, ')
          ..write('padsCount: $padsCount, ')
          ..write('tamponsCount: $tamponsCount, ')
          ..write('cupDisc: $cupDisc, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }
}

class $SymptomLogsTable extends SymptomLogs
    with TableInfo<$SymptomLogsTable, SymptomLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SymptomLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _symptomKeyMeta = const VerificationMeta(
    'symptomKey',
  );
  @override
  late final GeneratedColumn<String> symptomKey = GeneratedColumn<String>(
    'symptom_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _severityMeta = const VerificationMeta(
    'severity',
  );
  @override
  late final GeneratedColumn<int> severity = GeneratedColumn<int>(
    'severity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    date,
    category,
    symptomKey,
    severity,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'symptom_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<SymptomLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('symptom_key')) {
      context.handle(
        _symptomKeyMeta,
        symptomKey.isAcceptableOrUnknown(data['symptom_key']!, _symptomKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_symptomKeyMeta);
    }
    if (data.containsKey('severity')) {
      context.handle(
        _severityMeta,
        severity.isAcceptableOrUnknown(data['severity']!, _severityMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SymptomLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SymptomLog(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      symptomKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}symptom_key'],
      )!,
      severity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}severity'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
    );
  }

  @override
  $SymptomLogsTable createAlias(String alias) {
    return $SymptomLogsTable(attachedDatabase, alias);
  }
}

class SymptomLog extends DataClass implements Insertable<SymptomLog> {
  final int id;
  final DateTime date;
  final String category;
  final String symptomKey;
  final int severity;
  final String? notes;
  const SymptomLog({
    required this.id,
    required this.date,
    required this.category,
    required this.symptomKey,
    required this.severity,
    this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['date'] = Variable<DateTime>(date);
    map['category'] = Variable<String>(category);
    map['symptom_key'] = Variable<String>(symptomKey);
    map['severity'] = Variable<int>(severity);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  SymptomLogsCompanion toCompanion(bool nullToAbsent) {
    return SymptomLogsCompanion(
      id: Value(id),
      date: Value(date),
      category: Value(category),
      symptomKey: Value(symptomKey),
      severity: Value(severity),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
    );
  }

  factory SymptomLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SymptomLog(
      id: serializer.fromJson<int>(json['id']),
      date: serializer.fromJson<DateTime>(json['date']),
      category: serializer.fromJson<String>(json['category']),
      symptomKey: serializer.fromJson<String>(json['symptomKey']),
      severity: serializer.fromJson<int>(json['severity']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'date': serializer.toJson<DateTime>(date),
      'category': serializer.toJson<String>(category),
      'symptomKey': serializer.toJson<String>(symptomKey),
      'severity': serializer.toJson<int>(severity),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  SymptomLog copyWith({
    int? id,
    DateTime? date,
    String? category,
    String? symptomKey,
    int? severity,
    Value<String?> notes = const Value.absent(),
  }) => SymptomLog(
    id: id ?? this.id,
    date: date ?? this.date,
    category: category ?? this.category,
    symptomKey: symptomKey ?? this.symptomKey,
    severity: severity ?? this.severity,
    notes: notes.present ? notes.value : this.notes,
  );
  SymptomLog copyWithCompanion(SymptomLogsCompanion data) {
    return SymptomLog(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      category: data.category.present ? data.category.value : this.category,
      symptomKey: data.symptomKey.present
          ? data.symptomKey.value
          : this.symptomKey,
      severity: data.severity.present ? data.severity.value : this.severity,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SymptomLog(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('category: $category, ')
          ..write('symptomKey: $symptomKey, ')
          ..write('severity: $severity, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, date, category, symptomKey, severity, notes);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SymptomLog &&
          other.id == this.id &&
          other.date == this.date &&
          other.category == this.category &&
          other.symptomKey == this.symptomKey &&
          other.severity == this.severity &&
          other.notes == this.notes);
}

class SymptomLogsCompanion extends UpdateCompanion<SymptomLog> {
  final Value<int> id;
  final Value<DateTime> date;
  final Value<String> category;
  final Value<String> symptomKey;
  final Value<int> severity;
  final Value<String?> notes;
  const SymptomLogsCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.category = const Value.absent(),
    this.symptomKey = const Value.absent(),
    this.severity = const Value.absent(),
    this.notes = const Value.absent(),
  });
  SymptomLogsCompanion.insert({
    this.id = const Value.absent(),
    required DateTime date,
    required String category,
    required String symptomKey,
    this.severity = const Value.absent(),
    this.notes = const Value.absent(),
  }) : date = Value(date),
       category = Value(category),
       symptomKey = Value(symptomKey);
  static Insertable<SymptomLog> custom({
    Expression<int>? id,
    Expression<DateTime>? date,
    Expression<String>? category,
    Expression<String>? symptomKey,
    Expression<int>? severity,
    Expression<String>? notes,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (category != null) 'category': category,
      if (symptomKey != null) 'symptom_key': symptomKey,
      if (severity != null) 'severity': severity,
      if (notes != null) 'notes': notes,
    });
  }

  SymptomLogsCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? date,
    Value<String>? category,
    Value<String>? symptomKey,
    Value<int>? severity,
    Value<String?>? notes,
  }) {
    return SymptomLogsCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      category: category ?? this.category,
      symptomKey: symptomKey ?? this.symptomKey,
      severity: severity ?? this.severity,
      notes: notes ?? this.notes,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (symptomKey.present) {
      map['symptom_key'] = Variable<String>(symptomKey.value);
    }
    if (severity.present) {
      map['severity'] = Variable<int>(severity.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SymptomLogsCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('category: $category, ')
          ..write('symptomKey: $symptomKey, ')
          ..write('severity: $severity, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }
}

class $MucusLogsTable extends MucusLogs
    with TableInfo<$MucusLogsTable, MucusLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MucusLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, date, type, notes];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'mucus_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<MucusLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MucusLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MucusLog(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
    );
  }

  @override
  $MucusLogsTable createAlias(String alias) {
    return $MucusLogsTable(attachedDatabase, alias);
  }
}

class MucusLog extends DataClass implements Insertable<MucusLog> {
  final int id;
  final DateTime date;
  final String type;
  final String? notes;
  const MucusLog({
    required this.id,
    required this.date,
    required this.type,
    this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['date'] = Variable<DateTime>(date);
    map['type'] = Variable<String>(type);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  MucusLogsCompanion toCompanion(bool nullToAbsent) {
    return MucusLogsCompanion(
      id: Value(id),
      date: Value(date),
      type: Value(type),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
    );
  }

  factory MucusLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MucusLog(
      id: serializer.fromJson<int>(json['id']),
      date: serializer.fromJson<DateTime>(json['date']),
      type: serializer.fromJson<String>(json['type']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'date': serializer.toJson<DateTime>(date),
      'type': serializer.toJson<String>(type),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  MucusLog copyWith({
    int? id,
    DateTime? date,
    String? type,
    Value<String?> notes = const Value.absent(),
  }) => MucusLog(
    id: id ?? this.id,
    date: date ?? this.date,
    type: type ?? this.type,
    notes: notes.present ? notes.value : this.notes,
  );
  MucusLog copyWithCompanion(MucusLogsCompanion data) {
    return MucusLog(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      type: data.type.present ? data.type.value : this.type,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MucusLog(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('type: $type, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, date, type, notes);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MucusLog &&
          other.id == this.id &&
          other.date == this.date &&
          other.type == this.type &&
          other.notes == this.notes);
}

class MucusLogsCompanion extends UpdateCompanion<MucusLog> {
  final Value<int> id;
  final Value<DateTime> date;
  final Value<String> type;
  final Value<String?> notes;
  const MucusLogsCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.type = const Value.absent(),
    this.notes = const Value.absent(),
  });
  MucusLogsCompanion.insert({
    this.id = const Value.absent(),
    required DateTime date,
    required String type,
    this.notes = const Value.absent(),
  }) : date = Value(date),
       type = Value(type);
  static Insertable<MucusLog> custom({
    Expression<int>? id,
    Expression<DateTime>? date,
    Expression<String>? type,
    Expression<String>? notes,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (type != null) 'type': type,
      if (notes != null) 'notes': notes,
    });
  }

  MucusLogsCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? date,
    Value<String>? type,
    Value<String?>? notes,
  }) {
    return MucusLogsCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      type: type ?? this.type,
      notes: notes ?? this.notes,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MucusLogsCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('type: $type, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }
}

class $BbtLogsTable extends BbtLogs with TableInfo<$BbtLogsTable, BbtLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BbtLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _temperatureMeta = const VerificationMeta(
    'temperature',
  );
  @override
  late final GeneratedColumn<double> temperature = GeneratedColumn<double>(
    'temperature',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitMeta = const VerificationMeta('unit');
  @override
  late final GeneratedColumn<String> unit = GeneratedColumn<String>(
    'unit',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('C'),
  );
  static const VerificationMeta _timeTakenMeta = const VerificationMeta(
    'timeTaken',
  );
  @override
  late final GeneratedColumn<String> timeTaken = GeneratedColumn<String>(
    'time_taken',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    date,
    temperature,
    unit,
    timeTaken,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'bbt_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<BbtLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('temperature')) {
      context.handle(
        _temperatureMeta,
        temperature.isAcceptableOrUnknown(
          data['temperature']!,
          _temperatureMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_temperatureMeta);
    }
    if (data.containsKey('unit')) {
      context.handle(
        _unitMeta,
        unit.isAcceptableOrUnknown(data['unit']!, _unitMeta),
      );
    }
    if (data.containsKey('time_taken')) {
      context.handle(
        _timeTakenMeta,
        timeTaken.isAcceptableOrUnknown(data['time_taken']!, _timeTakenMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BbtLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BbtLog(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      temperature: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}temperature'],
      )!,
      unit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unit'],
      )!,
      timeTaken: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}time_taken'],
      ),
    );
  }

  @override
  $BbtLogsTable createAlias(String alias) {
    return $BbtLogsTable(attachedDatabase, alias);
  }
}

class BbtLog extends DataClass implements Insertable<BbtLog> {
  final int id;
  final DateTime date;
  final double temperature;
  final String unit;
  final String? timeTaken;
  const BbtLog({
    required this.id,
    required this.date,
    required this.temperature,
    required this.unit,
    this.timeTaken,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['date'] = Variable<DateTime>(date);
    map['temperature'] = Variable<double>(temperature);
    map['unit'] = Variable<String>(unit);
    if (!nullToAbsent || timeTaken != null) {
      map['time_taken'] = Variable<String>(timeTaken);
    }
    return map;
  }

  BbtLogsCompanion toCompanion(bool nullToAbsent) {
    return BbtLogsCompanion(
      id: Value(id),
      date: Value(date),
      temperature: Value(temperature),
      unit: Value(unit),
      timeTaken: timeTaken == null && nullToAbsent
          ? const Value.absent()
          : Value(timeTaken),
    );
  }

  factory BbtLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BbtLog(
      id: serializer.fromJson<int>(json['id']),
      date: serializer.fromJson<DateTime>(json['date']),
      temperature: serializer.fromJson<double>(json['temperature']),
      unit: serializer.fromJson<String>(json['unit']),
      timeTaken: serializer.fromJson<String?>(json['timeTaken']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'date': serializer.toJson<DateTime>(date),
      'temperature': serializer.toJson<double>(temperature),
      'unit': serializer.toJson<String>(unit),
      'timeTaken': serializer.toJson<String?>(timeTaken),
    };
  }

  BbtLog copyWith({
    int? id,
    DateTime? date,
    double? temperature,
    String? unit,
    Value<String?> timeTaken = const Value.absent(),
  }) => BbtLog(
    id: id ?? this.id,
    date: date ?? this.date,
    temperature: temperature ?? this.temperature,
    unit: unit ?? this.unit,
    timeTaken: timeTaken.present ? timeTaken.value : this.timeTaken,
  );
  BbtLog copyWithCompanion(BbtLogsCompanion data) {
    return BbtLog(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      temperature: data.temperature.present
          ? data.temperature.value
          : this.temperature,
      unit: data.unit.present ? data.unit.value : this.unit,
      timeTaken: data.timeTaken.present ? data.timeTaken.value : this.timeTaken,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BbtLog(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('temperature: $temperature, ')
          ..write('unit: $unit, ')
          ..write('timeTaken: $timeTaken')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, date, temperature, unit, timeTaken);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BbtLog &&
          other.id == this.id &&
          other.date == this.date &&
          other.temperature == this.temperature &&
          other.unit == this.unit &&
          other.timeTaken == this.timeTaken);
}

class BbtLogsCompanion extends UpdateCompanion<BbtLog> {
  final Value<int> id;
  final Value<DateTime> date;
  final Value<double> temperature;
  final Value<String> unit;
  final Value<String?> timeTaken;
  const BbtLogsCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.temperature = const Value.absent(),
    this.unit = const Value.absent(),
    this.timeTaken = const Value.absent(),
  });
  BbtLogsCompanion.insert({
    this.id = const Value.absent(),
    required DateTime date,
    required double temperature,
    this.unit = const Value.absent(),
    this.timeTaken = const Value.absent(),
  }) : date = Value(date),
       temperature = Value(temperature);
  static Insertable<BbtLog> custom({
    Expression<int>? id,
    Expression<DateTime>? date,
    Expression<double>? temperature,
    Expression<String>? unit,
    Expression<String>? timeTaken,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (temperature != null) 'temperature': temperature,
      if (unit != null) 'unit': unit,
      if (timeTaken != null) 'time_taken': timeTaken,
    });
  }

  BbtLogsCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? date,
    Value<double>? temperature,
    Value<String>? unit,
    Value<String?>? timeTaken,
  }) {
    return BbtLogsCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      temperature: temperature ?? this.temperature,
      unit: unit ?? this.unit,
      timeTaken: timeTaken ?? this.timeTaken,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (temperature.present) {
      map['temperature'] = Variable<double>(temperature.value);
    }
    if (unit.present) {
      map['unit'] = Variable<String>(unit.value);
    }
    if (timeTaken.present) {
      map['time_taken'] = Variable<String>(timeTaken.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BbtLogsCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('temperature: $temperature, ')
          ..write('unit: $unit, ')
          ..write('timeTaken: $timeTaken')
          ..write(')'))
        .toString();
  }
}

class $OpkLogsTable extends OpkLogs with TableInfo<$OpkLogsTable, OpkLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OpkLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _resultMeta = const VerificationMeta('result');
  @override
  late final GeneratedColumn<String> result = GeneratedColumn<String>(
    'result',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, date, result];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'opk_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<OpkLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('result')) {
      context.handle(
        _resultMeta,
        result.isAcceptableOrUnknown(data['result']!, _resultMeta),
      );
    } else if (isInserting) {
      context.missing(_resultMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  OpkLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return OpkLog(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      result: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}result'],
      )!,
    );
  }

  @override
  $OpkLogsTable createAlias(String alias) {
    return $OpkLogsTable(attachedDatabase, alias);
  }
}

class OpkLog extends DataClass implements Insertable<OpkLog> {
  final int id;
  final DateTime date;
  final String result;
  const OpkLog({required this.id, required this.date, required this.result});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['date'] = Variable<DateTime>(date);
    map['result'] = Variable<String>(result);
    return map;
  }

  OpkLogsCompanion toCompanion(bool nullToAbsent) {
    return OpkLogsCompanion(
      id: Value(id),
      date: Value(date),
      result: Value(result),
    );
  }

  factory OpkLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return OpkLog(
      id: serializer.fromJson<int>(json['id']),
      date: serializer.fromJson<DateTime>(json['date']),
      result: serializer.fromJson<String>(json['result']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'date': serializer.toJson<DateTime>(date),
      'result': serializer.toJson<String>(result),
    };
  }

  OpkLog copyWith({int? id, DateTime? date, String? result}) => OpkLog(
    id: id ?? this.id,
    date: date ?? this.date,
    result: result ?? this.result,
  );
  OpkLog copyWithCompanion(OpkLogsCompanion data) {
    return OpkLog(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      result: data.result.present ? data.result.value : this.result,
    );
  }

  @override
  String toString() {
    return (StringBuffer('OpkLog(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('result: $result')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, date, result);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OpkLog &&
          other.id == this.id &&
          other.date == this.date &&
          other.result == this.result);
}

class OpkLogsCompanion extends UpdateCompanion<OpkLog> {
  final Value<int> id;
  final Value<DateTime> date;
  final Value<String> result;
  const OpkLogsCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.result = const Value.absent(),
  });
  OpkLogsCompanion.insert({
    this.id = const Value.absent(),
    required DateTime date,
    required String result,
  }) : date = Value(date),
       result = Value(result);
  static Insertable<OpkLog> custom({
    Expression<int>? id,
    Expression<DateTime>? date,
    Expression<String>? result,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (result != null) 'result': result,
    });
  }

  OpkLogsCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? date,
    Value<String>? result,
  }) {
    return OpkLogsCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      result: result ?? this.result,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (result.present) {
      map['result'] = Variable<String>(result.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OpkLogsCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('result: $result')
          ..write(')'))
        .toString();
  }
}

class $IntercourseLogsTable extends IntercourseLogs
    with TableInfo<$IntercourseLogsTable, IntercourseLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $IntercourseLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _withProtectionMeta = const VerificationMeta(
    'withProtection',
  );
  @override
  late final GeneratedColumn<bool> withProtection = GeneratedColumn<bool>(
    'with_protection',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("with_protection" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _methodMeta = const VerificationMeta('method');
  @override
  late final GeneratedColumn<String> method = GeneratedColumn<String>(
    'method',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    date,
    withProtection,
    method,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'intercourse_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<IntercourseLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('with_protection')) {
      context.handle(
        _withProtectionMeta,
        withProtection.isAcceptableOrUnknown(
          data['with_protection']!,
          _withProtectionMeta,
        ),
      );
    }
    if (data.containsKey('method')) {
      context.handle(
        _methodMeta,
        method.isAcceptableOrUnknown(data['method']!, _methodMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  IntercourseLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return IntercourseLog(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      withProtection: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}with_protection'],
      )!,
      method: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}method'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
    );
  }

  @override
  $IntercourseLogsTable createAlias(String alias) {
    return $IntercourseLogsTable(attachedDatabase, alias);
  }
}

class IntercourseLog extends DataClass implements Insertable<IntercourseLog> {
  final int id;
  final DateTime date;
  final bool withProtection;
  final String? method;
  final String? notes;
  const IntercourseLog({
    required this.id,
    required this.date,
    required this.withProtection,
    this.method,
    this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['date'] = Variable<DateTime>(date);
    map['with_protection'] = Variable<bool>(withProtection);
    if (!nullToAbsent || method != null) {
      map['method'] = Variable<String>(method);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  IntercourseLogsCompanion toCompanion(bool nullToAbsent) {
    return IntercourseLogsCompanion(
      id: Value(id),
      date: Value(date),
      withProtection: Value(withProtection),
      method: method == null && nullToAbsent
          ? const Value.absent()
          : Value(method),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
    );
  }

  factory IntercourseLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return IntercourseLog(
      id: serializer.fromJson<int>(json['id']),
      date: serializer.fromJson<DateTime>(json['date']),
      withProtection: serializer.fromJson<bool>(json['withProtection']),
      method: serializer.fromJson<String?>(json['method']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'date': serializer.toJson<DateTime>(date),
      'withProtection': serializer.toJson<bool>(withProtection),
      'method': serializer.toJson<String?>(method),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  IntercourseLog copyWith({
    int? id,
    DateTime? date,
    bool? withProtection,
    Value<String?> method = const Value.absent(),
    Value<String?> notes = const Value.absent(),
  }) => IntercourseLog(
    id: id ?? this.id,
    date: date ?? this.date,
    withProtection: withProtection ?? this.withProtection,
    method: method.present ? method.value : this.method,
    notes: notes.present ? notes.value : this.notes,
  );
  IntercourseLog copyWithCompanion(IntercourseLogsCompanion data) {
    return IntercourseLog(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      withProtection: data.withProtection.present
          ? data.withProtection.value
          : this.withProtection,
      method: data.method.present ? data.method.value : this.method,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('IntercourseLog(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('withProtection: $withProtection, ')
          ..write('method: $method, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, date, withProtection, method, notes);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is IntercourseLog &&
          other.id == this.id &&
          other.date == this.date &&
          other.withProtection == this.withProtection &&
          other.method == this.method &&
          other.notes == this.notes);
}

class IntercourseLogsCompanion extends UpdateCompanion<IntercourseLog> {
  final Value<int> id;
  final Value<DateTime> date;
  final Value<bool> withProtection;
  final Value<String?> method;
  final Value<String?> notes;
  const IntercourseLogsCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.withProtection = const Value.absent(),
    this.method = const Value.absent(),
    this.notes = const Value.absent(),
  });
  IntercourseLogsCompanion.insert({
    this.id = const Value.absent(),
    required DateTime date,
    this.withProtection = const Value.absent(),
    this.method = const Value.absent(),
    this.notes = const Value.absent(),
  }) : date = Value(date);
  static Insertable<IntercourseLog> custom({
    Expression<int>? id,
    Expression<DateTime>? date,
    Expression<bool>? withProtection,
    Expression<String>? method,
    Expression<String>? notes,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (withProtection != null) 'with_protection': withProtection,
      if (method != null) 'method': method,
      if (notes != null) 'notes': notes,
    });
  }

  IntercourseLogsCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? date,
    Value<bool>? withProtection,
    Value<String?>? method,
    Value<String?>? notes,
  }) {
    return IntercourseLogsCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      withProtection: withProtection ?? this.withProtection,
      method: method ?? this.method,
      notes: notes ?? this.notes,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (withProtection.present) {
      map['with_protection'] = Variable<bool>(withProtection.value);
    }
    if (method.present) {
      map['method'] = Variable<String>(method.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('IntercourseLogsCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('withProtection: $withProtection, ')
          ..write('method: $method, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }
}

class $PredictionsTable extends Predictions
    with TableInfo<$PredictionsTable, Prediction> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PredictionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _cycleIdMeta = const VerificationMeta(
    'cycleId',
  );
  @override
  late final GeneratedColumn<int> cycleId = GeneratedColumn<int>(
    'cycle_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES cycles (id)',
    ),
  );
  static const VerificationMeta _ovulationDateMeta = const VerificationMeta(
    'ovulationDate',
  );
  @override
  late final GeneratedColumn<DateTime> ovulationDate =
      GeneratedColumn<DateTime>(
        'ovulation_date',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _fertileStartMeta = const VerificationMeta(
    'fertileStart',
  );
  @override
  late final GeneratedColumn<DateTime> fertileStart = GeneratedColumn<DateTime>(
    'fertile_start',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fertileEndMeta = const VerificationMeta(
    'fertileEnd',
  );
  @override
  late final GeneratedColumn<DateTime> fertileEnd = GeneratedColumn<DateTime>(
    'fertile_end',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _methodMeta = const VerificationMeta('method');
  @override
  late final GeneratedColumn<String> method = GeneratedColumn<String>(
    'method',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _confidenceMeta = const VerificationMeta(
    'confidence',
  );
  @override
  late final GeneratedColumn<double> confidence = GeneratedColumn<double>(
    'confidence',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.5),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    cycleId,
    ovulationDate,
    fertileStart,
    fertileEnd,
    method,
    confidence,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'predictions';
  @override
  VerificationContext validateIntegrity(
    Insertable<Prediction> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('cycle_id')) {
      context.handle(
        _cycleIdMeta,
        cycleId.isAcceptableOrUnknown(data['cycle_id']!, _cycleIdMeta),
      );
    }
    if (data.containsKey('ovulation_date')) {
      context.handle(
        _ovulationDateMeta,
        ovulationDate.isAcceptableOrUnknown(
          data['ovulation_date']!,
          _ovulationDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_ovulationDateMeta);
    }
    if (data.containsKey('fertile_start')) {
      context.handle(
        _fertileStartMeta,
        fertileStart.isAcceptableOrUnknown(
          data['fertile_start']!,
          _fertileStartMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_fertileStartMeta);
    }
    if (data.containsKey('fertile_end')) {
      context.handle(
        _fertileEndMeta,
        fertileEnd.isAcceptableOrUnknown(data['fertile_end']!, _fertileEndMeta),
      );
    } else if (isInserting) {
      context.missing(_fertileEndMeta);
    }
    if (data.containsKey('method')) {
      context.handle(
        _methodMeta,
        method.isAcceptableOrUnknown(data['method']!, _methodMeta),
      );
    } else if (isInserting) {
      context.missing(_methodMeta);
    }
    if (data.containsKey('confidence')) {
      context.handle(
        _confidenceMeta,
        confidence.isAcceptableOrUnknown(data['confidence']!, _confidenceMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Prediction map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Prediction(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      cycleId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cycle_id'],
      ),
      ovulationDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}ovulation_date'],
      )!,
      fertileStart: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}fertile_start'],
      )!,
      fertileEnd: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}fertile_end'],
      )!,
      method: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}method'],
      )!,
      confidence: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}confidence'],
      )!,
    );
  }

  @override
  $PredictionsTable createAlias(String alias) {
    return $PredictionsTable(attachedDatabase, alias);
  }
}

class Prediction extends DataClass implements Insertable<Prediction> {
  final int id;
  final int? cycleId;
  final DateTime ovulationDate;
  final DateTime fertileStart;
  final DateTime fertileEnd;
  final String method;
  final double confidence;
  const Prediction({
    required this.id,
    this.cycleId,
    required this.ovulationDate,
    required this.fertileStart,
    required this.fertileEnd,
    required this.method,
    required this.confidence,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || cycleId != null) {
      map['cycle_id'] = Variable<int>(cycleId);
    }
    map['ovulation_date'] = Variable<DateTime>(ovulationDate);
    map['fertile_start'] = Variable<DateTime>(fertileStart);
    map['fertile_end'] = Variable<DateTime>(fertileEnd);
    map['method'] = Variable<String>(method);
    map['confidence'] = Variable<double>(confidence);
    return map;
  }

  PredictionsCompanion toCompanion(bool nullToAbsent) {
    return PredictionsCompanion(
      id: Value(id),
      cycleId: cycleId == null && nullToAbsent
          ? const Value.absent()
          : Value(cycleId),
      ovulationDate: Value(ovulationDate),
      fertileStart: Value(fertileStart),
      fertileEnd: Value(fertileEnd),
      method: Value(method),
      confidence: Value(confidence),
    );
  }

  factory Prediction.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Prediction(
      id: serializer.fromJson<int>(json['id']),
      cycleId: serializer.fromJson<int?>(json['cycleId']),
      ovulationDate: serializer.fromJson<DateTime>(json['ovulationDate']),
      fertileStart: serializer.fromJson<DateTime>(json['fertileStart']),
      fertileEnd: serializer.fromJson<DateTime>(json['fertileEnd']),
      method: serializer.fromJson<String>(json['method']),
      confidence: serializer.fromJson<double>(json['confidence']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'cycleId': serializer.toJson<int?>(cycleId),
      'ovulationDate': serializer.toJson<DateTime>(ovulationDate),
      'fertileStart': serializer.toJson<DateTime>(fertileStart),
      'fertileEnd': serializer.toJson<DateTime>(fertileEnd),
      'method': serializer.toJson<String>(method),
      'confidence': serializer.toJson<double>(confidence),
    };
  }

  Prediction copyWith({
    int? id,
    Value<int?> cycleId = const Value.absent(),
    DateTime? ovulationDate,
    DateTime? fertileStart,
    DateTime? fertileEnd,
    String? method,
    double? confidence,
  }) => Prediction(
    id: id ?? this.id,
    cycleId: cycleId.present ? cycleId.value : this.cycleId,
    ovulationDate: ovulationDate ?? this.ovulationDate,
    fertileStart: fertileStart ?? this.fertileStart,
    fertileEnd: fertileEnd ?? this.fertileEnd,
    method: method ?? this.method,
    confidence: confidence ?? this.confidence,
  );
  Prediction copyWithCompanion(PredictionsCompanion data) {
    return Prediction(
      id: data.id.present ? data.id.value : this.id,
      cycleId: data.cycleId.present ? data.cycleId.value : this.cycleId,
      ovulationDate: data.ovulationDate.present
          ? data.ovulationDate.value
          : this.ovulationDate,
      fertileStart: data.fertileStart.present
          ? data.fertileStart.value
          : this.fertileStart,
      fertileEnd: data.fertileEnd.present
          ? data.fertileEnd.value
          : this.fertileEnd,
      method: data.method.present ? data.method.value : this.method,
      confidence: data.confidence.present
          ? data.confidence.value
          : this.confidence,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Prediction(')
          ..write('id: $id, ')
          ..write('cycleId: $cycleId, ')
          ..write('ovulationDate: $ovulationDate, ')
          ..write('fertileStart: $fertileStart, ')
          ..write('fertileEnd: $fertileEnd, ')
          ..write('method: $method, ')
          ..write('confidence: $confidence')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    cycleId,
    ovulationDate,
    fertileStart,
    fertileEnd,
    method,
    confidence,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Prediction &&
          other.id == this.id &&
          other.cycleId == this.cycleId &&
          other.ovulationDate == this.ovulationDate &&
          other.fertileStart == this.fertileStart &&
          other.fertileEnd == this.fertileEnd &&
          other.method == this.method &&
          other.confidence == this.confidence);
}

class PredictionsCompanion extends UpdateCompanion<Prediction> {
  final Value<int> id;
  final Value<int?> cycleId;
  final Value<DateTime> ovulationDate;
  final Value<DateTime> fertileStart;
  final Value<DateTime> fertileEnd;
  final Value<String> method;
  final Value<double> confidence;
  const PredictionsCompanion({
    this.id = const Value.absent(),
    this.cycleId = const Value.absent(),
    this.ovulationDate = const Value.absent(),
    this.fertileStart = const Value.absent(),
    this.fertileEnd = const Value.absent(),
    this.method = const Value.absent(),
    this.confidence = const Value.absent(),
  });
  PredictionsCompanion.insert({
    this.id = const Value.absent(),
    this.cycleId = const Value.absent(),
    required DateTime ovulationDate,
    required DateTime fertileStart,
    required DateTime fertileEnd,
    required String method,
    this.confidence = const Value.absent(),
  }) : ovulationDate = Value(ovulationDate),
       fertileStart = Value(fertileStart),
       fertileEnd = Value(fertileEnd),
       method = Value(method);
  static Insertable<Prediction> custom({
    Expression<int>? id,
    Expression<int>? cycleId,
    Expression<DateTime>? ovulationDate,
    Expression<DateTime>? fertileStart,
    Expression<DateTime>? fertileEnd,
    Expression<String>? method,
    Expression<double>? confidence,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (cycleId != null) 'cycle_id': cycleId,
      if (ovulationDate != null) 'ovulation_date': ovulationDate,
      if (fertileStart != null) 'fertile_start': fertileStart,
      if (fertileEnd != null) 'fertile_end': fertileEnd,
      if (method != null) 'method': method,
      if (confidence != null) 'confidence': confidence,
    });
  }

  PredictionsCompanion copyWith({
    Value<int>? id,
    Value<int?>? cycleId,
    Value<DateTime>? ovulationDate,
    Value<DateTime>? fertileStart,
    Value<DateTime>? fertileEnd,
    Value<String>? method,
    Value<double>? confidence,
  }) {
    return PredictionsCompanion(
      id: id ?? this.id,
      cycleId: cycleId ?? this.cycleId,
      ovulationDate: ovulationDate ?? this.ovulationDate,
      fertileStart: fertileStart ?? this.fertileStart,
      fertileEnd: fertileEnd ?? this.fertileEnd,
      method: method ?? this.method,
      confidence: confidence ?? this.confidence,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (cycleId.present) {
      map['cycle_id'] = Variable<int>(cycleId.value);
    }
    if (ovulationDate.present) {
      map['ovulation_date'] = Variable<DateTime>(ovulationDate.value);
    }
    if (fertileStart.present) {
      map['fertile_start'] = Variable<DateTime>(fertileStart.value);
    }
    if (fertileEnd.present) {
      map['fertile_end'] = Variable<DateTime>(fertileEnd.value);
    }
    if (method.present) {
      map['method'] = Variable<String>(method.value);
    }
    if (confidence.present) {
      map['confidence'] = Variable<double>(confidence.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PredictionsCompanion(')
          ..write('id: $id, ')
          ..write('cycleId: $cycleId, ')
          ..write('ovulationDate: $ovulationDate, ')
          ..write('fertileStart: $fertileStart, ')
          ..write('fertileEnd: $fertileEnd, ')
          ..write('method: $method, ')
          ..write('confidence: $confidence')
          ..write(')'))
        .toString();
  }
}

class $RemindersTable extends Reminders
    with TableInfo<$RemindersTable, Reminder> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RemindersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _timeOfDayMeta = const VerificationMeta(
    'timeOfDay',
  );
  @override
  late final GeneratedColumn<String> timeOfDay = GeneratedColumn<String>(
    'time_of_day',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _daysBeforeMeta = const VerificationMeta(
    'daysBefore',
  );
  @override
  late final GeneratedColumn<int> daysBefore = GeneratedColumn<int>(
    'days_before',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _enabledMeta = const VerificationMeta(
    'enabled',
  );
  @override
  late final GeneratedColumn<bool> enabled = GeneratedColumn<bool>(
    'enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    type,
    timeOfDay,
    daysBefore,
    enabled,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'reminders';
  @override
  VerificationContext validateIntegrity(
    Insertable<Reminder> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('time_of_day')) {
      context.handle(
        _timeOfDayMeta,
        timeOfDay.isAcceptableOrUnknown(data['time_of_day']!, _timeOfDayMeta),
      );
    } else if (isInserting) {
      context.missing(_timeOfDayMeta);
    }
    if (data.containsKey('days_before')) {
      context.handle(
        _daysBeforeMeta,
        daysBefore.isAcceptableOrUnknown(data['days_before']!, _daysBeforeMeta),
      );
    }
    if (data.containsKey('enabled')) {
      context.handle(
        _enabledMeta,
        enabled.isAcceptableOrUnknown(data['enabled']!, _enabledMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Reminder map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Reminder(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      timeOfDay: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}time_of_day'],
      )!,
      daysBefore: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}days_before'],
      )!,
      enabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}enabled'],
      )!,
    );
  }

  @override
  $RemindersTable createAlias(String alias) {
    return $RemindersTable(attachedDatabase, alias);
  }
}

class Reminder extends DataClass implements Insertable<Reminder> {
  final int id;
  final String type;
  final String timeOfDay;
  final int daysBefore;
  final bool enabled;
  const Reminder({
    required this.id,
    required this.type,
    required this.timeOfDay,
    required this.daysBefore,
    required this.enabled,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['type'] = Variable<String>(type);
    map['time_of_day'] = Variable<String>(timeOfDay);
    map['days_before'] = Variable<int>(daysBefore);
    map['enabled'] = Variable<bool>(enabled);
    return map;
  }

  RemindersCompanion toCompanion(bool nullToAbsent) {
    return RemindersCompanion(
      id: Value(id),
      type: Value(type),
      timeOfDay: Value(timeOfDay),
      daysBefore: Value(daysBefore),
      enabled: Value(enabled),
    );
  }

  factory Reminder.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Reminder(
      id: serializer.fromJson<int>(json['id']),
      type: serializer.fromJson<String>(json['type']),
      timeOfDay: serializer.fromJson<String>(json['timeOfDay']),
      daysBefore: serializer.fromJson<int>(json['daysBefore']),
      enabled: serializer.fromJson<bool>(json['enabled']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'type': serializer.toJson<String>(type),
      'timeOfDay': serializer.toJson<String>(timeOfDay),
      'daysBefore': serializer.toJson<int>(daysBefore),
      'enabled': serializer.toJson<bool>(enabled),
    };
  }

  Reminder copyWith({
    int? id,
    String? type,
    String? timeOfDay,
    int? daysBefore,
    bool? enabled,
  }) => Reminder(
    id: id ?? this.id,
    type: type ?? this.type,
    timeOfDay: timeOfDay ?? this.timeOfDay,
    daysBefore: daysBefore ?? this.daysBefore,
    enabled: enabled ?? this.enabled,
  );
  Reminder copyWithCompanion(RemindersCompanion data) {
    return Reminder(
      id: data.id.present ? data.id.value : this.id,
      type: data.type.present ? data.type.value : this.type,
      timeOfDay: data.timeOfDay.present ? data.timeOfDay.value : this.timeOfDay,
      daysBefore: data.daysBefore.present
          ? data.daysBefore.value
          : this.daysBefore,
      enabled: data.enabled.present ? data.enabled.value : this.enabled,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Reminder(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('timeOfDay: $timeOfDay, ')
          ..write('daysBefore: $daysBefore, ')
          ..write('enabled: $enabled')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, type, timeOfDay, daysBefore, enabled);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Reminder &&
          other.id == this.id &&
          other.type == this.type &&
          other.timeOfDay == this.timeOfDay &&
          other.daysBefore == this.daysBefore &&
          other.enabled == this.enabled);
}

class RemindersCompanion extends UpdateCompanion<Reminder> {
  final Value<int> id;
  final Value<String> type;
  final Value<String> timeOfDay;
  final Value<int> daysBefore;
  final Value<bool> enabled;
  const RemindersCompanion({
    this.id = const Value.absent(),
    this.type = const Value.absent(),
    this.timeOfDay = const Value.absent(),
    this.daysBefore = const Value.absent(),
    this.enabled = const Value.absent(),
  });
  RemindersCompanion.insert({
    this.id = const Value.absent(),
    required String type,
    required String timeOfDay,
    this.daysBefore = const Value.absent(),
    this.enabled = const Value.absent(),
  }) : type = Value(type),
       timeOfDay = Value(timeOfDay);
  static Insertable<Reminder> custom({
    Expression<int>? id,
    Expression<String>? type,
    Expression<String>? timeOfDay,
    Expression<int>? daysBefore,
    Expression<bool>? enabled,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (type != null) 'type': type,
      if (timeOfDay != null) 'time_of_day': timeOfDay,
      if (daysBefore != null) 'days_before': daysBefore,
      if (enabled != null) 'enabled': enabled,
    });
  }

  RemindersCompanion copyWith({
    Value<int>? id,
    Value<String>? type,
    Value<String>? timeOfDay,
    Value<int>? daysBefore,
    Value<bool>? enabled,
  }) {
    return RemindersCompanion(
      id: id ?? this.id,
      type: type ?? this.type,
      timeOfDay: timeOfDay ?? this.timeOfDay,
      daysBefore: daysBefore ?? this.daysBefore,
      enabled: enabled ?? this.enabled,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (timeOfDay.present) {
      map['time_of_day'] = Variable<String>(timeOfDay.value);
    }
    if (daysBefore.present) {
      map['days_before'] = Variable<int>(daysBefore.value);
    }
    if (enabled.present) {
      map['enabled'] = Variable<bool>(enabled.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RemindersCompanion(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('timeOfDay: $timeOfDay, ')
          ..write('daysBefore: $daysBefore, ')
          ..write('enabled: $enabled')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ProfileTable profile = $ProfileTable(this);
  late final $CyclesTable cycles = $CyclesTable(this);
  late final $FlowLogsTable flowLogs = $FlowLogsTable(this);
  late final $SymptomLogsTable symptomLogs = $SymptomLogsTable(this);
  late final $MucusLogsTable mucusLogs = $MucusLogsTable(this);
  late final $BbtLogsTable bbtLogs = $BbtLogsTable(this);
  late final $OpkLogsTable opkLogs = $OpkLogsTable(this);
  late final $IntercourseLogsTable intercourseLogs = $IntercourseLogsTable(
    this,
  );
  late final $PredictionsTable predictions = $PredictionsTable(this);
  late final $RemindersTable reminders = $RemindersTable(this);
  late final CycleDao cycleDao = CycleDao(this as AppDatabase);
  late final FlowLogDao flowLogDao = FlowLogDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    profile,
    cycles,
    flowLogs,
    symptomLogs,
    mucusLogs,
    bbtLogs,
    opkLogs,
    intercourseLogs,
    predictions,
    reminders,
  ];
}

typedef $$ProfileTableCreateCompanionBuilder =
    ProfileCompanion Function({
      Value<int> id,
      required String cycleGoal,
      Value<int> avgCycleLength,
      Value<int> avgPeriodLength,
      Value<int> lutealPhase,
      Value<DateTime?> dob,
      Value<bool> remindersEnabled,
      required DateTime createdAt,
    });
typedef $$ProfileTableUpdateCompanionBuilder =
    ProfileCompanion Function({
      Value<int> id,
      Value<String> cycleGoal,
      Value<int> avgCycleLength,
      Value<int> avgPeriodLength,
      Value<int> lutealPhase,
      Value<DateTime?> dob,
      Value<bool> remindersEnabled,
      Value<DateTime> createdAt,
    });

class $$ProfileTableFilterComposer
    extends Composer<_$AppDatabase, $ProfileTable> {
  $$ProfileTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cycleGoal => $composableBuilder(
    column: $table.cycleGoal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get avgCycleLength => $composableBuilder(
    column: $table.avgCycleLength,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get avgPeriodLength => $composableBuilder(
    column: $table.avgPeriodLength,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lutealPhase => $composableBuilder(
    column: $table.lutealPhase,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dob => $composableBuilder(
    column: $table.dob,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get remindersEnabled => $composableBuilder(
    column: $table.remindersEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ProfileTableOrderingComposer
    extends Composer<_$AppDatabase, $ProfileTable> {
  $$ProfileTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cycleGoal => $composableBuilder(
    column: $table.cycleGoal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get avgCycleLength => $composableBuilder(
    column: $table.avgCycleLength,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get avgPeriodLength => $composableBuilder(
    column: $table.avgPeriodLength,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lutealPhase => $composableBuilder(
    column: $table.lutealPhase,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dob => $composableBuilder(
    column: $table.dob,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get remindersEnabled => $composableBuilder(
    column: $table.remindersEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProfileTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProfileTable> {
  $$ProfileTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get cycleGoal =>
      $composableBuilder(column: $table.cycleGoal, builder: (column) => column);

  GeneratedColumn<int> get avgCycleLength => $composableBuilder(
    column: $table.avgCycleLength,
    builder: (column) => column,
  );

  GeneratedColumn<int> get avgPeriodLength => $composableBuilder(
    column: $table.avgPeriodLength,
    builder: (column) => column,
  );

  GeneratedColumn<int> get lutealPhase => $composableBuilder(
    column: $table.lutealPhase,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get dob =>
      $composableBuilder(column: $table.dob, builder: (column) => column);

  GeneratedColumn<bool> get remindersEnabled => $composableBuilder(
    column: $table.remindersEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$ProfileTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProfileTable,
          ProfileData,
          $$ProfileTableFilterComposer,
          $$ProfileTableOrderingComposer,
          $$ProfileTableAnnotationComposer,
          $$ProfileTableCreateCompanionBuilder,
          $$ProfileTableUpdateCompanionBuilder,
          (
            ProfileData,
            BaseReferences<_$AppDatabase, $ProfileTable, ProfileData>,
          ),
          ProfileData,
          PrefetchHooks Function()
        > {
  $$ProfileTableTableManager(_$AppDatabase db, $ProfileTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProfileTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProfileTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProfileTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> cycleGoal = const Value.absent(),
                Value<int> avgCycleLength = const Value.absent(),
                Value<int> avgPeriodLength = const Value.absent(),
                Value<int> lutealPhase = const Value.absent(),
                Value<DateTime?> dob = const Value.absent(),
                Value<bool> remindersEnabled = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => ProfileCompanion(
                id: id,
                cycleGoal: cycleGoal,
                avgCycleLength: avgCycleLength,
                avgPeriodLength: avgPeriodLength,
                lutealPhase: lutealPhase,
                dob: dob,
                remindersEnabled: remindersEnabled,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String cycleGoal,
                Value<int> avgCycleLength = const Value.absent(),
                Value<int> avgPeriodLength = const Value.absent(),
                Value<int> lutealPhase = const Value.absent(),
                Value<DateTime?> dob = const Value.absent(),
                Value<bool> remindersEnabled = const Value.absent(),
                required DateTime createdAt,
              }) => ProfileCompanion.insert(
                id: id,
                cycleGoal: cycleGoal,
                avgCycleLength: avgCycleLength,
                avgPeriodLength: avgPeriodLength,
                lutealPhase: lutealPhase,
                dob: dob,
                remindersEnabled: remindersEnabled,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ProfileTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProfileTable,
      ProfileData,
      $$ProfileTableFilterComposer,
      $$ProfileTableOrderingComposer,
      $$ProfileTableAnnotationComposer,
      $$ProfileTableCreateCompanionBuilder,
      $$ProfileTableUpdateCompanionBuilder,
      (ProfileData, BaseReferences<_$AppDatabase, $ProfileTable, ProfileData>),
      ProfileData,
      PrefetchHooks Function()
    >;
typedef $$CyclesTableCreateCompanionBuilder =
    CyclesCompanion Function({
      Value<int> id,
      required DateTime startDate,
      Value<DateTime?> endDate,
      Value<int?> cycleLength,
      Value<int?> periodLength,
      Value<String?> notes,
    });
typedef $$CyclesTableUpdateCompanionBuilder =
    CyclesCompanion Function({
      Value<int> id,
      Value<DateTime> startDate,
      Value<DateTime?> endDate,
      Value<int?> cycleLength,
      Value<int?> periodLength,
      Value<String?> notes,
    });

final class $$CyclesTableReferences
    extends BaseReferences<_$AppDatabase, $CyclesTable, Cycle> {
  $$CyclesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$PredictionsTable, List<Prediction>>
  _predictionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.predictions,
    aliasName: 'cycles__id__predictions__cycle_id',
  );

  $$PredictionsTableProcessedTableManager get predictionsRefs {
    final manager = $$PredictionsTableTableManager(
      $_db,
      $_db.predictions,
    ).filter((f) => f.cycleId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_predictionsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CyclesTableFilterComposer
    extends Composer<_$AppDatabase, $CyclesTable> {
  $$CyclesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endDate => $composableBuilder(
    column: $table.endDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get cycleLength => $composableBuilder(
    column: $table.cycleLength,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get periodLength => $composableBuilder(
    column: $table.periodLength,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> predictionsRefs(
    Expression<bool> Function($$PredictionsTableFilterComposer f) f,
  ) {
    final $$PredictionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.predictions,
      getReferencedColumn: (t) => t.cycleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PredictionsTableFilterComposer(
            $db: $db,
            $table: $db.predictions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CyclesTableOrderingComposer
    extends Composer<_$AppDatabase, $CyclesTable> {
  $$CyclesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endDate => $composableBuilder(
    column: $table.endDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get cycleLength => $composableBuilder(
    column: $table.cycleLength,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get periodLength => $composableBuilder(
    column: $table.periodLength,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CyclesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CyclesTable> {
  $$CyclesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<DateTime> get endDate =>
      $composableBuilder(column: $table.endDate, builder: (column) => column);

  GeneratedColumn<int> get cycleLength => $composableBuilder(
    column: $table.cycleLength,
    builder: (column) => column,
  );

  GeneratedColumn<int> get periodLength => $composableBuilder(
    column: $table.periodLength,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  Expression<T> predictionsRefs<T extends Object>(
    Expression<T> Function($$PredictionsTableAnnotationComposer a) f,
  ) {
    final $$PredictionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.predictions,
      getReferencedColumn: (t) => t.cycleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PredictionsTableAnnotationComposer(
            $db: $db,
            $table: $db.predictions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CyclesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CyclesTable,
          Cycle,
          $$CyclesTableFilterComposer,
          $$CyclesTableOrderingComposer,
          $$CyclesTableAnnotationComposer,
          $$CyclesTableCreateCompanionBuilder,
          $$CyclesTableUpdateCompanionBuilder,
          (Cycle, $$CyclesTableReferences),
          Cycle,
          PrefetchHooks Function({bool predictionsRefs})
        > {
  $$CyclesTableTableManager(_$AppDatabase db, $CyclesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CyclesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CyclesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CyclesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> startDate = const Value.absent(),
                Value<DateTime?> endDate = const Value.absent(),
                Value<int?> cycleLength = const Value.absent(),
                Value<int?> periodLength = const Value.absent(),
                Value<String?> notes = const Value.absent(),
              }) => CyclesCompanion(
                id: id,
                startDate: startDate,
                endDate: endDate,
                cycleLength: cycleLength,
                periodLength: periodLength,
                notes: notes,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required DateTime startDate,
                Value<DateTime?> endDate = const Value.absent(),
                Value<int?> cycleLength = const Value.absent(),
                Value<int?> periodLength = const Value.absent(),
                Value<String?> notes = const Value.absent(),
              }) => CyclesCompanion.insert(
                id: id,
                startDate: startDate,
                endDate: endDate,
                cycleLength: cycleLength,
                periodLength: periodLength,
                notes: notes,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$CyclesTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({predictionsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (predictionsRefs) db.predictions],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (predictionsRefs)
                    await $_getPrefetchedData<Cycle, $CyclesTable, Prediction>(
                      currentTable: table,
                      referencedTable: $$CyclesTableReferences
                          ._predictionsRefsTable(db),
                      managerFromTypedResult: (p0) => $$CyclesTableReferences(
                        db,
                        table,
                        p0,
                      ).predictionsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.cycleId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$CyclesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CyclesTable,
      Cycle,
      $$CyclesTableFilterComposer,
      $$CyclesTableOrderingComposer,
      $$CyclesTableAnnotationComposer,
      $$CyclesTableCreateCompanionBuilder,
      $$CyclesTableUpdateCompanionBuilder,
      (Cycle, $$CyclesTableReferences),
      Cycle,
      PrefetchHooks Function({bool predictionsRefs})
    >;
typedef $$FlowLogsTableCreateCompanionBuilder =
    FlowLogsCompanion Function({
      Value<int> id,
      required DateTime date,
      required String flowLevel,
      Value<String?> bloodColor,
      Value<bool> hasClots,
      Value<String?> clotSize,
      Value<int> padsCount,
      Value<int> tamponsCount,
      Value<bool> cupDisc,
      Value<String?> notes,
    });
typedef $$FlowLogsTableUpdateCompanionBuilder =
    FlowLogsCompanion Function({
      Value<int> id,
      Value<DateTime> date,
      Value<String> flowLevel,
      Value<String?> bloodColor,
      Value<bool> hasClots,
      Value<String?> clotSize,
      Value<int> padsCount,
      Value<int> tamponsCount,
      Value<bool> cupDisc,
      Value<String?> notes,
    });

class $$FlowLogsTableFilterComposer
    extends Composer<_$AppDatabase, $FlowLogsTable> {
  $$FlowLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get flowLevel => $composableBuilder(
    column: $table.flowLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bloodColor => $composableBuilder(
    column: $table.bloodColor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get hasClots => $composableBuilder(
    column: $table.hasClots,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get clotSize => $composableBuilder(
    column: $table.clotSize,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get padsCount => $composableBuilder(
    column: $table.padsCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get tamponsCount => $composableBuilder(
    column: $table.tamponsCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get cupDisc => $composableBuilder(
    column: $table.cupDisc,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );
}

class $$FlowLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $FlowLogsTable> {
  $$FlowLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get flowLevel => $composableBuilder(
    column: $table.flowLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bloodColor => $composableBuilder(
    column: $table.bloodColor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get hasClots => $composableBuilder(
    column: $table.hasClots,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get clotSize => $composableBuilder(
    column: $table.clotSize,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get padsCount => $composableBuilder(
    column: $table.padsCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get tamponsCount => $composableBuilder(
    column: $table.tamponsCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get cupDisc => $composableBuilder(
    column: $table.cupDisc,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FlowLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $FlowLogsTable> {
  $$FlowLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get flowLevel =>
      $composableBuilder(column: $table.flowLevel, builder: (column) => column);

  GeneratedColumn<String> get bloodColor => $composableBuilder(
    column: $table.bloodColor,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get hasClots =>
      $composableBuilder(column: $table.hasClots, builder: (column) => column);

  GeneratedColumn<String> get clotSize =>
      $composableBuilder(column: $table.clotSize, builder: (column) => column);

  GeneratedColumn<int> get padsCount =>
      $composableBuilder(column: $table.padsCount, builder: (column) => column);

  GeneratedColumn<int> get tamponsCount => $composableBuilder(
    column: $table.tamponsCount,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get cupDisc =>
      $composableBuilder(column: $table.cupDisc, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);
}

class $$FlowLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FlowLogsTable,
          FlowLog,
          $$FlowLogsTableFilterComposer,
          $$FlowLogsTableOrderingComposer,
          $$FlowLogsTableAnnotationComposer,
          $$FlowLogsTableCreateCompanionBuilder,
          $$FlowLogsTableUpdateCompanionBuilder,
          (FlowLog, BaseReferences<_$AppDatabase, $FlowLogsTable, FlowLog>),
          FlowLog,
          PrefetchHooks Function()
        > {
  $$FlowLogsTableTableManager(_$AppDatabase db, $FlowLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FlowLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FlowLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FlowLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<String> flowLevel = const Value.absent(),
                Value<String?> bloodColor = const Value.absent(),
                Value<bool> hasClots = const Value.absent(),
                Value<String?> clotSize = const Value.absent(),
                Value<int> padsCount = const Value.absent(),
                Value<int> tamponsCount = const Value.absent(),
                Value<bool> cupDisc = const Value.absent(),
                Value<String?> notes = const Value.absent(),
              }) => FlowLogsCompanion(
                id: id,
                date: date,
                flowLevel: flowLevel,
                bloodColor: bloodColor,
                hasClots: hasClots,
                clotSize: clotSize,
                padsCount: padsCount,
                tamponsCount: tamponsCount,
                cupDisc: cupDisc,
                notes: notes,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required DateTime date,
                required String flowLevel,
                Value<String?> bloodColor = const Value.absent(),
                Value<bool> hasClots = const Value.absent(),
                Value<String?> clotSize = const Value.absent(),
                Value<int> padsCount = const Value.absent(),
                Value<int> tamponsCount = const Value.absent(),
                Value<bool> cupDisc = const Value.absent(),
                Value<String?> notes = const Value.absent(),
              }) => FlowLogsCompanion.insert(
                id: id,
                date: date,
                flowLevel: flowLevel,
                bloodColor: bloodColor,
                hasClots: hasClots,
                clotSize: clotSize,
                padsCount: padsCount,
                tamponsCount: tamponsCount,
                cupDisc: cupDisc,
                notes: notes,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$FlowLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FlowLogsTable,
      FlowLog,
      $$FlowLogsTableFilterComposer,
      $$FlowLogsTableOrderingComposer,
      $$FlowLogsTableAnnotationComposer,
      $$FlowLogsTableCreateCompanionBuilder,
      $$FlowLogsTableUpdateCompanionBuilder,
      (FlowLog, BaseReferences<_$AppDatabase, $FlowLogsTable, FlowLog>),
      FlowLog,
      PrefetchHooks Function()
    >;
typedef $$SymptomLogsTableCreateCompanionBuilder =
    SymptomLogsCompanion Function({
      Value<int> id,
      required DateTime date,
      required String category,
      required String symptomKey,
      Value<int> severity,
      Value<String?> notes,
    });
typedef $$SymptomLogsTableUpdateCompanionBuilder =
    SymptomLogsCompanion Function({
      Value<int> id,
      Value<DateTime> date,
      Value<String> category,
      Value<String> symptomKey,
      Value<int> severity,
      Value<String?> notes,
    });

class $$SymptomLogsTableFilterComposer
    extends Composer<_$AppDatabase, $SymptomLogsTable> {
  $$SymptomLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get symptomKey => $composableBuilder(
    column: $table.symptomKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get severity => $composableBuilder(
    column: $table.severity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SymptomLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $SymptomLogsTable> {
  $$SymptomLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get symptomKey => $composableBuilder(
    column: $table.symptomKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get severity => $composableBuilder(
    column: $table.severity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SymptomLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SymptomLogsTable> {
  $$SymptomLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get symptomKey => $composableBuilder(
    column: $table.symptomKey,
    builder: (column) => column,
  );

  GeneratedColumn<int> get severity =>
      $composableBuilder(column: $table.severity, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);
}

class $$SymptomLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SymptomLogsTable,
          SymptomLog,
          $$SymptomLogsTableFilterComposer,
          $$SymptomLogsTableOrderingComposer,
          $$SymptomLogsTableAnnotationComposer,
          $$SymptomLogsTableCreateCompanionBuilder,
          $$SymptomLogsTableUpdateCompanionBuilder,
          (
            SymptomLog,
            BaseReferences<_$AppDatabase, $SymptomLogsTable, SymptomLog>,
          ),
          SymptomLog,
          PrefetchHooks Function()
        > {
  $$SymptomLogsTableTableManager(_$AppDatabase db, $SymptomLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SymptomLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SymptomLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SymptomLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<String> symptomKey = const Value.absent(),
                Value<int> severity = const Value.absent(),
                Value<String?> notes = const Value.absent(),
              }) => SymptomLogsCompanion(
                id: id,
                date: date,
                category: category,
                symptomKey: symptomKey,
                severity: severity,
                notes: notes,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required DateTime date,
                required String category,
                required String symptomKey,
                Value<int> severity = const Value.absent(),
                Value<String?> notes = const Value.absent(),
              }) => SymptomLogsCompanion.insert(
                id: id,
                date: date,
                category: category,
                symptomKey: symptomKey,
                severity: severity,
                notes: notes,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SymptomLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SymptomLogsTable,
      SymptomLog,
      $$SymptomLogsTableFilterComposer,
      $$SymptomLogsTableOrderingComposer,
      $$SymptomLogsTableAnnotationComposer,
      $$SymptomLogsTableCreateCompanionBuilder,
      $$SymptomLogsTableUpdateCompanionBuilder,
      (
        SymptomLog,
        BaseReferences<_$AppDatabase, $SymptomLogsTable, SymptomLog>,
      ),
      SymptomLog,
      PrefetchHooks Function()
    >;
typedef $$MucusLogsTableCreateCompanionBuilder =
    MucusLogsCompanion Function({
      Value<int> id,
      required DateTime date,
      required String type,
      Value<String?> notes,
    });
typedef $$MucusLogsTableUpdateCompanionBuilder =
    MucusLogsCompanion Function({
      Value<int> id,
      Value<DateTime> date,
      Value<String> type,
      Value<String?> notes,
    });

class $$MucusLogsTableFilterComposer
    extends Composer<_$AppDatabase, $MucusLogsTable> {
  $$MucusLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MucusLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $MucusLogsTable> {
  $$MucusLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MucusLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MucusLogsTable> {
  $$MucusLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);
}

class $$MucusLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MucusLogsTable,
          MucusLog,
          $$MucusLogsTableFilterComposer,
          $$MucusLogsTableOrderingComposer,
          $$MucusLogsTableAnnotationComposer,
          $$MucusLogsTableCreateCompanionBuilder,
          $$MucusLogsTableUpdateCompanionBuilder,
          (MucusLog, BaseReferences<_$AppDatabase, $MucusLogsTable, MucusLog>),
          MucusLog,
          PrefetchHooks Function()
        > {
  $$MucusLogsTableTableManager(_$AppDatabase db, $MucusLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MucusLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MucusLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MucusLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String?> notes = const Value.absent(),
              }) => MucusLogsCompanion(
                id: id,
                date: date,
                type: type,
                notes: notes,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required DateTime date,
                required String type,
                Value<String?> notes = const Value.absent(),
              }) => MucusLogsCompanion.insert(
                id: id,
                date: date,
                type: type,
                notes: notes,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MucusLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MucusLogsTable,
      MucusLog,
      $$MucusLogsTableFilterComposer,
      $$MucusLogsTableOrderingComposer,
      $$MucusLogsTableAnnotationComposer,
      $$MucusLogsTableCreateCompanionBuilder,
      $$MucusLogsTableUpdateCompanionBuilder,
      (MucusLog, BaseReferences<_$AppDatabase, $MucusLogsTable, MucusLog>),
      MucusLog,
      PrefetchHooks Function()
    >;
typedef $$BbtLogsTableCreateCompanionBuilder =
    BbtLogsCompanion Function({
      Value<int> id,
      required DateTime date,
      required double temperature,
      Value<String> unit,
      Value<String?> timeTaken,
    });
typedef $$BbtLogsTableUpdateCompanionBuilder =
    BbtLogsCompanion Function({
      Value<int> id,
      Value<DateTime> date,
      Value<double> temperature,
      Value<String> unit,
      Value<String?> timeTaken,
    });

class $$BbtLogsTableFilterComposer
    extends Composer<_$AppDatabase, $BbtLogsTable> {
  $$BbtLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get temperature => $composableBuilder(
    column: $table.temperature,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get timeTaken => $composableBuilder(
    column: $table.timeTaken,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BbtLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $BbtLogsTable> {
  $$BbtLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get temperature => $composableBuilder(
    column: $table.temperature,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get timeTaken => $composableBuilder(
    column: $table.timeTaken,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BbtLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $BbtLogsTable> {
  $$BbtLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<double> get temperature => $composableBuilder(
    column: $table.temperature,
    builder: (column) => column,
  );

  GeneratedColumn<String> get unit =>
      $composableBuilder(column: $table.unit, builder: (column) => column);

  GeneratedColumn<String> get timeTaken =>
      $composableBuilder(column: $table.timeTaken, builder: (column) => column);
}

class $$BbtLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BbtLogsTable,
          BbtLog,
          $$BbtLogsTableFilterComposer,
          $$BbtLogsTableOrderingComposer,
          $$BbtLogsTableAnnotationComposer,
          $$BbtLogsTableCreateCompanionBuilder,
          $$BbtLogsTableUpdateCompanionBuilder,
          (BbtLog, BaseReferences<_$AppDatabase, $BbtLogsTable, BbtLog>),
          BbtLog,
          PrefetchHooks Function()
        > {
  $$BbtLogsTableTableManager(_$AppDatabase db, $BbtLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BbtLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BbtLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BbtLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<double> temperature = const Value.absent(),
                Value<String> unit = const Value.absent(),
                Value<String?> timeTaken = const Value.absent(),
              }) => BbtLogsCompanion(
                id: id,
                date: date,
                temperature: temperature,
                unit: unit,
                timeTaken: timeTaken,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required DateTime date,
                required double temperature,
                Value<String> unit = const Value.absent(),
                Value<String?> timeTaken = const Value.absent(),
              }) => BbtLogsCompanion.insert(
                id: id,
                date: date,
                temperature: temperature,
                unit: unit,
                timeTaken: timeTaken,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BbtLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BbtLogsTable,
      BbtLog,
      $$BbtLogsTableFilterComposer,
      $$BbtLogsTableOrderingComposer,
      $$BbtLogsTableAnnotationComposer,
      $$BbtLogsTableCreateCompanionBuilder,
      $$BbtLogsTableUpdateCompanionBuilder,
      (BbtLog, BaseReferences<_$AppDatabase, $BbtLogsTable, BbtLog>),
      BbtLog,
      PrefetchHooks Function()
    >;
typedef $$OpkLogsTableCreateCompanionBuilder =
    OpkLogsCompanion Function({
      Value<int> id,
      required DateTime date,
      required String result,
    });
typedef $$OpkLogsTableUpdateCompanionBuilder =
    OpkLogsCompanion Function({
      Value<int> id,
      Value<DateTime> date,
      Value<String> result,
    });

class $$OpkLogsTableFilterComposer
    extends Composer<_$AppDatabase, $OpkLogsTable> {
  $$OpkLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get result => $composableBuilder(
    column: $table.result,
    builder: (column) => ColumnFilters(column),
  );
}

class $$OpkLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $OpkLogsTable> {
  $$OpkLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get result => $composableBuilder(
    column: $table.result,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$OpkLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $OpkLogsTable> {
  $$OpkLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get result =>
      $composableBuilder(column: $table.result, builder: (column) => column);
}

class $$OpkLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $OpkLogsTable,
          OpkLog,
          $$OpkLogsTableFilterComposer,
          $$OpkLogsTableOrderingComposer,
          $$OpkLogsTableAnnotationComposer,
          $$OpkLogsTableCreateCompanionBuilder,
          $$OpkLogsTableUpdateCompanionBuilder,
          (OpkLog, BaseReferences<_$AppDatabase, $OpkLogsTable, OpkLog>),
          OpkLog,
          PrefetchHooks Function()
        > {
  $$OpkLogsTableTableManager(_$AppDatabase db, $OpkLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$OpkLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$OpkLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$OpkLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<String> result = const Value.absent(),
              }) => OpkLogsCompanion(id: id, date: date, result: result),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required DateTime date,
                required String result,
              }) => OpkLogsCompanion.insert(id: id, date: date, result: result),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$OpkLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $OpkLogsTable,
      OpkLog,
      $$OpkLogsTableFilterComposer,
      $$OpkLogsTableOrderingComposer,
      $$OpkLogsTableAnnotationComposer,
      $$OpkLogsTableCreateCompanionBuilder,
      $$OpkLogsTableUpdateCompanionBuilder,
      (OpkLog, BaseReferences<_$AppDatabase, $OpkLogsTable, OpkLog>),
      OpkLog,
      PrefetchHooks Function()
    >;
typedef $$IntercourseLogsTableCreateCompanionBuilder =
    IntercourseLogsCompanion Function({
      Value<int> id,
      required DateTime date,
      Value<bool> withProtection,
      Value<String?> method,
      Value<String?> notes,
    });
typedef $$IntercourseLogsTableUpdateCompanionBuilder =
    IntercourseLogsCompanion Function({
      Value<int> id,
      Value<DateTime> date,
      Value<bool> withProtection,
      Value<String?> method,
      Value<String?> notes,
    });

class $$IntercourseLogsTableFilterComposer
    extends Composer<_$AppDatabase, $IntercourseLogsTable> {
  $$IntercourseLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get withProtection => $composableBuilder(
    column: $table.withProtection,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get method => $composableBuilder(
    column: $table.method,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );
}

class $$IntercourseLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $IntercourseLogsTable> {
  $$IntercourseLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get withProtection => $composableBuilder(
    column: $table.withProtection,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get method => $composableBuilder(
    column: $table.method,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$IntercourseLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $IntercourseLogsTable> {
  $$IntercourseLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<bool> get withProtection => $composableBuilder(
    column: $table.withProtection,
    builder: (column) => column,
  );

  GeneratedColumn<String> get method =>
      $composableBuilder(column: $table.method, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);
}

class $$IntercourseLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $IntercourseLogsTable,
          IntercourseLog,
          $$IntercourseLogsTableFilterComposer,
          $$IntercourseLogsTableOrderingComposer,
          $$IntercourseLogsTableAnnotationComposer,
          $$IntercourseLogsTableCreateCompanionBuilder,
          $$IntercourseLogsTableUpdateCompanionBuilder,
          (
            IntercourseLog,
            BaseReferences<
              _$AppDatabase,
              $IntercourseLogsTable,
              IntercourseLog
            >,
          ),
          IntercourseLog,
          PrefetchHooks Function()
        > {
  $$IntercourseLogsTableTableManager(
    _$AppDatabase db,
    $IntercourseLogsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$IntercourseLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$IntercourseLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$IntercourseLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<bool> withProtection = const Value.absent(),
                Value<String?> method = const Value.absent(),
                Value<String?> notes = const Value.absent(),
              }) => IntercourseLogsCompanion(
                id: id,
                date: date,
                withProtection: withProtection,
                method: method,
                notes: notes,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required DateTime date,
                Value<bool> withProtection = const Value.absent(),
                Value<String?> method = const Value.absent(),
                Value<String?> notes = const Value.absent(),
              }) => IntercourseLogsCompanion.insert(
                id: id,
                date: date,
                withProtection: withProtection,
                method: method,
                notes: notes,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$IntercourseLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $IntercourseLogsTable,
      IntercourseLog,
      $$IntercourseLogsTableFilterComposer,
      $$IntercourseLogsTableOrderingComposer,
      $$IntercourseLogsTableAnnotationComposer,
      $$IntercourseLogsTableCreateCompanionBuilder,
      $$IntercourseLogsTableUpdateCompanionBuilder,
      (
        IntercourseLog,
        BaseReferences<_$AppDatabase, $IntercourseLogsTable, IntercourseLog>,
      ),
      IntercourseLog,
      PrefetchHooks Function()
    >;
typedef $$PredictionsTableCreateCompanionBuilder =
    PredictionsCompanion Function({
      Value<int> id,
      Value<int?> cycleId,
      required DateTime ovulationDate,
      required DateTime fertileStart,
      required DateTime fertileEnd,
      required String method,
      Value<double> confidence,
    });
typedef $$PredictionsTableUpdateCompanionBuilder =
    PredictionsCompanion Function({
      Value<int> id,
      Value<int?> cycleId,
      Value<DateTime> ovulationDate,
      Value<DateTime> fertileStart,
      Value<DateTime> fertileEnd,
      Value<String> method,
      Value<double> confidence,
    });

final class $$PredictionsTableReferences
    extends BaseReferences<_$AppDatabase, $PredictionsTable, Prediction> {
  $$PredictionsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CyclesTable _cycleIdTable(_$AppDatabase db) =>
      db.cycles.createAlias('predictions__cycle_id__cycles__id');

  $$CyclesTableProcessedTableManager? get cycleId {
    final $_column = $_itemColumn<int>('cycle_id');
    if ($_column == null) return null;
    final manager = $$CyclesTableTableManager(
      $_db,
      $_db.cycles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_cycleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PredictionsTableFilterComposer
    extends Composer<_$AppDatabase, $PredictionsTable> {
  $$PredictionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get ovulationDate => $composableBuilder(
    column: $table.ovulationDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get fertileStart => $composableBuilder(
    column: $table.fertileStart,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get fertileEnd => $composableBuilder(
    column: $table.fertileEnd,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get method => $composableBuilder(
    column: $table.method,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => ColumnFilters(column),
  );

  $$CyclesTableFilterComposer get cycleId {
    final $$CyclesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.cycleId,
      referencedTable: $db.cycles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CyclesTableFilterComposer(
            $db: $db,
            $table: $db.cycles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PredictionsTableOrderingComposer
    extends Composer<_$AppDatabase, $PredictionsTable> {
  $$PredictionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get ovulationDate => $composableBuilder(
    column: $table.ovulationDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get fertileStart => $composableBuilder(
    column: $table.fertileStart,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get fertileEnd => $composableBuilder(
    column: $table.fertileEnd,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get method => $composableBuilder(
    column: $table.method,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => ColumnOrderings(column),
  );

  $$CyclesTableOrderingComposer get cycleId {
    final $$CyclesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.cycleId,
      referencedTable: $db.cycles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CyclesTableOrderingComposer(
            $db: $db,
            $table: $db.cycles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PredictionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PredictionsTable> {
  $$PredictionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get ovulationDate => $composableBuilder(
    column: $table.ovulationDate,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get fertileStart => $composableBuilder(
    column: $table.fertileStart,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get fertileEnd => $composableBuilder(
    column: $table.fertileEnd,
    builder: (column) => column,
  );

  GeneratedColumn<String> get method =>
      $composableBuilder(column: $table.method, builder: (column) => column);

  GeneratedColumn<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => column,
  );

  $$CyclesTableAnnotationComposer get cycleId {
    final $$CyclesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.cycleId,
      referencedTable: $db.cycles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CyclesTableAnnotationComposer(
            $db: $db,
            $table: $db.cycles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PredictionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PredictionsTable,
          Prediction,
          $$PredictionsTableFilterComposer,
          $$PredictionsTableOrderingComposer,
          $$PredictionsTableAnnotationComposer,
          $$PredictionsTableCreateCompanionBuilder,
          $$PredictionsTableUpdateCompanionBuilder,
          (Prediction, $$PredictionsTableReferences),
          Prediction,
          PrefetchHooks Function({bool cycleId})
        > {
  $$PredictionsTableTableManager(_$AppDatabase db, $PredictionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PredictionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PredictionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PredictionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> cycleId = const Value.absent(),
                Value<DateTime> ovulationDate = const Value.absent(),
                Value<DateTime> fertileStart = const Value.absent(),
                Value<DateTime> fertileEnd = const Value.absent(),
                Value<String> method = const Value.absent(),
                Value<double> confidence = const Value.absent(),
              }) => PredictionsCompanion(
                id: id,
                cycleId: cycleId,
                ovulationDate: ovulationDate,
                fertileStart: fertileStart,
                fertileEnd: fertileEnd,
                method: method,
                confidence: confidence,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> cycleId = const Value.absent(),
                required DateTime ovulationDate,
                required DateTime fertileStart,
                required DateTime fertileEnd,
                required String method,
                Value<double> confidence = const Value.absent(),
              }) => PredictionsCompanion.insert(
                id: id,
                cycleId: cycleId,
                ovulationDate: ovulationDate,
                fertileStart: fertileStart,
                fertileEnd: fertileEnd,
                method: method,
                confidence: confidence,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PredictionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({cycleId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (cycleId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.cycleId,
                                referencedTable: $$PredictionsTableReferences
                                    ._cycleIdTable(db),
                                referencedColumn: $$PredictionsTableReferences
                                    ._cycleIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$PredictionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PredictionsTable,
      Prediction,
      $$PredictionsTableFilterComposer,
      $$PredictionsTableOrderingComposer,
      $$PredictionsTableAnnotationComposer,
      $$PredictionsTableCreateCompanionBuilder,
      $$PredictionsTableUpdateCompanionBuilder,
      (Prediction, $$PredictionsTableReferences),
      Prediction,
      PrefetchHooks Function({bool cycleId})
    >;
typedef $$RemindersTableCreateCompanionBuilder =
    RemindersCompanion Function({
      Value<int> id,
      required String type,
      required String timeOfDay,
      Value<int> daysBefore,
      Value<bool> enabled,
    });
typedef $$RemindersTableUpdateCompanionBuilder =
    RemindersCompanion Function({
      Value<int> id,
      Value<String> type,
      Value<String> timeOfDay,
      Value<int> daysBefore,
      Value<bool> enabled,
    });

class $$RemindersTableFilterComposer
    extends Composer<_$AppDatabase, $RemindersTable> {
  $$RemindersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get timeOfDay => $composableBuilder(
    column: $table.timeOfDay,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get daysBefore => $composableBuilder(
    column: $table.daysBefore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get enabled => $composableBuilder(
    column: $table.enabled,
    builder: (column) => ColumnFilters(column),
  );
}

class $$RemindersTableOrderingComposer
    extends Composer<_$AppDatabase, $RemindersTable> {
  $$RemindersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get timeOfDay => $composableBuilder(
    column: $table.timeOfDay,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get daysBefore => $composableBuilder(
    column: $table.daysBefore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get enabled => $composableBuilder(
    column: $table.enabled,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RemindersTableAnnotationComposer
    extends Composer<_$AppDatabase, $RemindersTable> {
  $$RemindersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get timeOfDay =>
      $composableBuilder(column: $table.timeOfDay, builder: (column) => column);

  GeneratedColumn<int> get daysBefore => $composableBuilder(
    column: $table.daysBefore,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get enabled =>
      $composableBuilder(column: $table.enabled, builder: (column) => column);
}

class $$RemindersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RemindersTable,
          Reminder,
          $$RemindersTableFilterComposer,
          $$RemindersTableOrderingComposer,
          $$RemindersTableAnnotationComposer,
          $$RemindersTableCreateCompanionBuilder,
          $$RemindersTableUpdateCompanionBuilder,
          (Reminder, BaseReferences<_$AppDatabase, $RemindersTable, Reminder>),
          Reminder,
          PrefetchHooks Function()
        > {
  $$RemindersTableTableManager(_$AppDatabase db, $RemindersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RemindersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RemindersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RemindersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String> timeOfDay = const Value.absent(),
                Value<int> daysBefore = const Value.absent(),
                Value<bool> enabled = const Value.absent(),
              }) => RemindersCompanion(
                id: id,
                type: type,
                timeOfDay: timeOfDay,
                daysBefore: daysBefore,
                enabled: enabled,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String type,
                required String timeOfDay,
                Value<int> daysBefore = const Value.absent(),
                Value<bool> enabled = const Value.absent(),
              }) => RemindersCompanion.insert(
                id: id,
                type: type,
                timeOfDay: timeOfDay,
                daysBefore: daysBefore,
                enabled: enabled,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$RemindersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RemindersTable,
      Reminder,
      $$RemindersTableFilterComposer,
      $$RemindersTableOrderingComposer,
      $$RemindersTableAnnotationComposer,
      $$RemindersTableCreateCompanionBuilder,
      $$RemindersTableUpdateCompanionBuilder,
      (Reminder, BaseReferences<_$AppDatabase, $RemindersTable, Reminder>),
      Reminder,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ProfileTableTableManager get profile =>
      $$ProfileTableTableManager(_db, _db.profile);
  $$CyclesTableTableManager get cycles =>
      $$CyclesTableTableManager(_db, _db.cycles);
  $$FlowLogsTableTableManager get flowLogs =>
      $$FlowLogsTableTableManager(_db, _db.flowLogs);
  $$SymptomLogsTableTableManager get symptomLogs =>
      $$SymptomLogsTableTableManager(_db, _db.symptomLogs);
  $$MucusLogsTableTableManager get mucusLogs =>
      $$MucusLogsTableTableManager(_db, _db.mucusLogs);
  $$BbtLogsTableTableManager get bbtLogs =>
      $$BbtLogsTableTableManager(_db, _db.bbtLogs);
  $$OpkLogsTableTableManager get opkLogs =>
      $$OpkLogsTableTableManager(_db, _db.opkLogs);
  $$IntercourseLogsTableTableManager get intercourseLogs =>
      $$IntercourseLogsTableTableManager(_db, _db.intercourseLogs);
  $$PredictionsTableTableManager get predictions =>
      $$PredictionsTableTableManager(_db, _db.predictions);
  $$RemindersTableTableManager get reminders =>
      $$RemindersTableTableManager(_db, _db.reminders);
}
