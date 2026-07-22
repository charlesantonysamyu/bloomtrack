// BloomTrack — Constants, enums, and reference data.

// ── Cycle defaults & ranges ──

/// Default cycle length when no history is available.
const int kDefaultCycleLength = 28;

/// Default period length when no history is available.
const int kDefaultPeriodLength = 5;

/// Default luteal phase length (days after ovulation until next period).
const int kDefaultLutealPhase = 14;

/// Minimum valid luteal phase (user-configurable).
const int kMinLutealPhase = 10;

/// Maximum valid luteal phase (user-configurable).
const int kMaxLutealPhase = 16;

/// Number of past cycles used to compute averages.
const int kCyclesForAverage = 6;

/// Normal cycle range.
const int kMinNormalCycleLength = 21;
const int kMaxNormalCycleLength = 35;

/// Maximum normal period length.
const int kMaxNormalPeriodLength = 7;

/// Cycle-length variation threshold that triggers an alert.
const int kCycleVariationAlert = 9;

/// Number of consecutive missed periods that triggers an alert.
const int kMissedPeriodsAlert = 3;

// ── Enums ──

/// How heavy the flow is on a given day.
enum FlowLevel {
  spotting('Spotting', '💧'),
  light('Light', '🩸'),
  medium('Medium', '🩸🩸'),
  heavy('Heavy', '🩸🩸🩸');

  const FlowLevel(this.label, this.icon);
  final String label;
  final String icon;
}

/// Observed blood color with medical context.
enum BloodColor {
  brightRed(
    'Bright red',
    'Fresh blood, usually at the start of your period. Normal.',
  ),
  darkRed(
    'Dark red',
    'Blood that has been in the uterus a little longer. Very common.',
  ),
  brown(
    'Brown',
    'Older blood. Common at the start or end of a period.',
  ),
  pink(
    'Pink',
    'Blood mixed with cervical fluid. Can appear mid-cycle or with light flow.',
  ),
  orange(
    'Orange',
    'May indicate blood mixed with cervical fluid, or could be a sign of infection. '
        'Consider seeing a doctor if it persists.',
  ),
  gray(
    'Gray',
    '⚠️ Gray discharge could indicate bacterial vaginosis or, in pregnancy, '
        'a possible miscarriage. Please consult a healthcare provider.',
  ),
  black(
    'Black',
    'Usually very old, oxidized blood. Can be normal at the end of a period.',
  );

  const BloodColor(this.label, this.description);
  final String label;
  final String description;
}

/// Size of blood clots.
enum ClotSize {
  small('Small', 'Smaller than a dime — usually normal'),
  large('Large', 'Larger than a quarter — consider talking to your doctor');

  const ClotSize(this.label, this.description);
  final String label;
  final String description;
}

/// Fertility label for a given day.
enum FertilityLevel {
  peak('Peak fertility', '🟣', 'Highest chance of pregnancy'),
  high('High fertility', '🟠', 'Sex can lead to pregnancy (sperm survives ~5 days)'),
  low('Low / infertile', '🔵', 'Lower chance of pregnancy'),
  postOvulation('Post-ovulation', '⚪', 'Very low chance until next cycle'),
  period('Period', '🔴', 'Menstruation'),
  unknown('Unknown', '⚫', 'Not enough data to predict');

  const FertilityLevel(this.label, this.emoji, this.description);
  final String label;
  final String emoji;
  final String description;
}

/// Symptom category.
enum SymptomCategory {
  pain('Pain'),
  mood('Mood'),
  skin('Skin'),
  energy('Energy'),
  digestion('Digestion'),
  sleep('Sleep'),
  libido('Libido'),
  other('Other');

  const SymptomCategory(this.label);
  final String label;
}

/// Predefined symptoms organized by category.
class SymptomCatalog {
  SymptomCatalog._();

  static const Map<SymptomCategory, List<String>> symptoms = {
    SymptomCategory.pain: [
      'Cramps',
      'Breast tenderness',
      'Headache',
      'Migraine',
      'Backache',
      'Joint pain',
      'Leg pain',
      'Pelvic pain',
    ],
    SymptomCategory.mood: [
      'Happy',
      'Calm',
      'Irritable',
      'Anxious',
      'Sad',
      'Mood swings',
      'Sensitive',
      'Crying',
      'Angry',
      'Stressed',
    ],
    SymptomCategory.skin: [
      'Acne',
      'Oily skin',
      'Dry skin',
      'Breakout',
      'Glowing skin',
    ],
    SymptomCategory.energy: [
      'Energetic',
      'Tired',
      'Fatigue',
      'Exhausted',
      'Normal energy',
    ],
    SymptomCategory.digestion: [
      'Bloating',
      'Nausea',
      'Cravings',
      'Constipation',
      'Diarrhea',
      'Gas',
      'Appetite increase',
      'Appetite decrease',
    ],
    SymptomCategory.sleep: [
      'Insomnia',
      'Good sleep',
      'Restless',
      'Oversleeping',
      'Vivid dreams',
    ],
    SymptomCategory.libido: [
      'High libido',
      'Low libido',
      'Normal libido',
    ],
    SymptomCategory.other: [
      'Dizziness',
      'Hot flashes',
      'Chills',
      'Swelling',
      'Frequent urination',
      'Vaginal dryness',
    ],
  };
}

/// Cervical mucus type (fertility indicator).
enum MucusType {
  dry('Dry', 'No noticeable mucus — least fertile'),
  sticky('Sticky', 'Thick, tacky mucus — low fertility'),
  creamy('Creamy', 'Lotion-like, white mucus — moderate fertility'),
  watery('Watery', 'Clear, wet, slippery — high fertility'),
  eggWhite('Egg white', 'Stretchy, clear, like raw egg white — peak fertility');

  const MucusType(this.label, this.description);
  final String label;
  final String description;
}

/// Protection / contraceptive method.
enum ProtectionMethod {
  none('None'),
  condom('Condom'),
  pill('Birth control pill'),
  iud('IUD'),
  implant('Implant'),
  patch('Patch'),
  ring('Vaginal ring'),
  withdrawal('Withdrawal'),
  other('Other');

  const ProtectionMethod(this.label);
  final String label;
}

/// Cycle tracking goal.
enum CycleGoal {
  track('Track my cycle', 'Just want to understand my body'),
  conceive('Trying to conceive', 'Want to know the best days to get pregnant'),
  avoid('Avoiding pregnancy', 'Want to know which days to be extra careful');

  const CycleGoal(this.label, this.description);
  final String label;
  final String description;
}

/// OPK (ovulation predictor kit) test result.
enum OpkResult {
  positive('Positive', 'LH surge detected — ovulation likely within 24–48h'),
  negative('Negative', 'No LH surge detected');

  const OpkResult(this.label, this.description);
  final String label;
  final String description;
}

// ── Disclaimers ──

class Disclaimers {
  Disclaimers._();

  static const String notContraceptive =
      'BloomTrack is NOT a contraceptive method. Fertility-awareness methods '
      'have a typical-use failure rate of ~24% per year. Do not rely on this '
      'app to prevent pregnancy.';

  static const String notDiagnostic =
      'This app is NOT a diagnostic tool, pregnancy test, or substitute for '
      'professional medical advice. Always consult a qualified healthcare '
      'provider for medical concerns.';

  static const String seeDoctor =
      'See a doctor if you experience: unusually heavy bleeding, periods '
      'longer than 7 days, cycles shorter than 21 or longer than 35 days, '
      'severe pain, gray or unusual discharge, or 3+ missed periods.';

  static const String privacyPromise =
      'All your data stays on this device. Nothing is uploaded, shared, or '
      'sent anywhere. Your data is encrypted and protected.';
}
