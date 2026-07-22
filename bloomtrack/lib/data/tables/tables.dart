import 'package:drift/drift.dart';

/// User profile settings table.
///
/// Stores cycle-tracking preferences, biometric info, and notification prefs.
/// Only one row should exist — enforced at the application layer.
class Profile extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get cycleGoal => text()();
  IntColumn get avgCycleLength => integer().withDefault(const Constant(28))();
  IntColumn get avgPeriodLength => integer().withDefault(const Constant(5))();
  IntColumn get lutealPhase => integer().withDefault(const Constant(14))();
  DateTimeColumn get dob => dateTime().nullable()();
  BoolColumn get remindersEnabled =>
      boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime()();
}

/// Menstrual cycles table.
///
/// Each row represents one full cycle from the first day of a period to the day
/// before the next period starts. An active (ongoing) cycle has a null
/// [endDate].
class Cycles extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get startDate => dateTime()();
  DateTimeColumn get endDate => dateTime().nullable()();
  IntColumn get cycleLength => integer().nullable()();
  IntColumn get periodLength => integer().nullable()();
  TextColumn get notes => text().nullable()();
}

/// Daily flow-intensity logs.
///
/// Captures menstrual flow details for a given date including level, colour,
/// clotting information, and product usage counts.
class FlowLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get date => dateTime()();
  TextColumn get flowLevel => text()();
  TextColumn get bloodColor => text().nullable()();
  BoolColumn get hasClots =>
      boolean().withDefault(const Constant(false))();
  TextColumn get clotSize => text().nullable()();
  IntColumn get padsCount => integer().withDefault(const Constant(0))();
  IntColumn get tamponsCount => integer().withDefault(const Constant(0))();
  BoolColumn get cupDisc =>
      boolean().withDefault(const Constant(false))();
  TextColumn get notes => text().nullable()();
}

/// Symptom log entries.
///
/// Tracks symptoms by category (e.g. "mood", "pain", "digestion") with a
/// freeform key, an optional severity scale, and notes.
class SymptomLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get date => dateTime()();
  TextColumn get category => text()();
  TextColumn get symptomKey => text()();
  IntColumn get severity => integer().withDefault(const Constant(0))();
  TextColumn get notes => text().nullable()();
}

/// Cervical mucus observation logs.
///
/// Records the mucus type observed on a given date (e.g. "dry", "sticky",
/// "creamy", "watery", "egg-white").
class MucusLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get date => dateTime()();
  TextColumn get type => text()();
  TextColumn get notes => text().nullable()();
}

/// Basal body temperature (BBT) logs.
///
/// Stores temperature readings with unit (Celsius or Fahrenheit) and the
/// optional time the measurement was taken.
class BbtLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get date => dateTime()();
  RealColumn get temperature => real()();
  TextColumn get unit => text().withDefault(const Constant('C'))();
  TextColumn get timeTaken => text().nullable()();
}

/// Ovulation predictor kit (OPK) result logs.
///
/// Records the result of an OPK test on a given date (e.g. "positive",
/// "negative", "peak").
class OpkLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get date => dateTime()();
  TextColumn get result => text()();
}

/// Intercourse logs.
///
/// Tracks intercourse events, whether protection was used, the method of
/// protection, and optional notes.
class IntercourseLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get date => dateTime()();
  BoolColumn get withProtection =>
      boolean().withDefault(const Constant(false))();
  TextColumn get method => text().nullable()();
  TextColumn get notes => text().nullable()();
}

/// Fertility and ovulation predictions.
///
/// Each prediction is optionally linked to a [Cycles] row and stores the
/// predicted ovulation date, fertile window, calculation method, and a
/// confidence score between 0.0 and 1.0.
class Predictions extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get cycleId =>
      integer().nullable().references(Cycles, #id)();
  DateTimeColumn get ovulationDate => dateTime()();
  DateTimeColumn get fertileStart => dateTime()();
  DateTimeColumn get fertileEnd => dateTime()();
  TextColumn get method => text()();
  RealColumn get confidence =>
      real().withDefault(const Constant(0.5))();
}

/// User-configured reminders.
///
/// Stores reminder type (e.g. "period", "pill", "ovulation"), the time of day
/// as an HH:mm string, how many days before the event to fire, and whether the
/// reminder is currently enabled.
class Reminders extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get type => text()();
  TextColumn get timeOfDay => text()();
  IntColumn get daysBefore => integer().withDefault(const Constant(1))();
  BoolColumn get enabled => boolean().withDefault(const Constant(true))();
}
