/// Represents the seven days of a weekly meal plan schedule.
enum DayOfWeek {
  monday('Monday', 'Mon', 1),
  tuesday('Tuesday', 'Tue', 2),
  wednesday('Wednesday', 'Wed', 3),
  thursday('Thursday', 'Thu', 4),
  friday('Friday', 'Fri', 5),
  saturday('Saturday', 'Sat', 6),
  sunday('Sunday', 'Sun', 7);

  final String fullName;
  final String shortName;
  final int isoDayNumber;

  const DayOfWeek(this.fullName, this.shortName, this.isoDayNumber);

  /// Converts a weekday integer (1 = Monday, 7 = Sunday) to [DayOfWeek].
  static DayOfWeek fromDateTime(DateTime dateTime) {
    return DayOfWeek.values[dateTime.weekday - 1];
  }

  /// Parses a string into a [DayOfWeek] enum.
  static DayOfWeek fromString(String? value) {
    if (value == null) return DayOfWeek.monday;
    final normalized = value.toLowerCase().trim();
    return DayOfWeek.values.firstWhere(
      (d) => d.name == normalized || d.fullName.toLowerCase() == normalized || d.shortName.toLowerCase() == normalized,
      orElse: () => DayOfWeek.monday,
    );
  }
}
