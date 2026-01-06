/// Represents a time of day with hour and minute.
class TimeOfDay {
  final int hour;
  final int minute;

  const TimeOfDay({required this.hour, required this.minute});

  /// Creates a TimeOfDay from the current time.
  factory TimeOfDay.now() {
    final now = DateTime.now();
    return TimeOfDay(hour: now.hour, minute: now.minute);
  }

  /// Creates a TimeOfDay from a DateTime.
  factory TimeOfDay.fromDateTime(DateTime dateTime) {
    return TimeOfDay(hour: dateTime.hour, minute: dateTime.minute);
  }

  /// Returns the hour in 12-hour format (1-12).
  int get hourOfPeriod => hour == 0 ? 12 : (hour > 12 ? hour - 12 : hour);

  /// Returns whether this time is AM or PM.
  bool get isPM => hour >= 12;

  /// Returns a formatted string.
  String format({bool use24Hour = false}) {
    if (use24Hour) {
      return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
    }
    final period = isPM ? 'PM' : 'AM';
    return '${hourOfPeriod.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $period';
  }

  /// Creates a copy with the given fields replaced.
  TimeOfDay copyWith({int? hour, int? minute}) {
    return TimeOfDay(
      hour: hour ?? this.hour,
      minute: minute ?? this.minute,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TimeOfDay && hour == other.hour && minute == other.minute;

  @override
  int get hashCode => hour.hashCode ^ minute.hashCode;

  @override
  String toString() => format();
}

/// Size variants for time picker
enum TimePickerSize {
  sm,
  md,
  lg,
}

/// Properties for time picker components.
class TimePickerProps {
  /// Currently selected time
  final TimeOfDay? value;

  /// Display text for the trigger
  final String displayText;

  /// Label above the input
  final String? label;

  /// Whether the picker is disabled
  final bool disabled;

  /// Error message
  final String? error;

  /// Whether to allow clearing
  final bool clearable;

  /// Size variant
  final TimePickerSize size;

  /// Whether the dropdown is open
  final bool isOpen;

  /// Whether to use 24-hour format
  final bool use24Hour;

  /// Current selected hour in the dropdown
  final int selectedHour;

  /// Current selected minute in the dropdown
  final int selectedMinute;

  /// Whether PM is selected (12-hour mode)
  final bool isPM;

  /// Minute interval (1, 5, 10, 15, 30)
  final int minuteInterval;

  /// Callback for trigger click
  final void Function()? onToggle;

  /// Callback for clear button click
  final void Function()? onClear;

  /// Callback for hour selection
  final void Function(int hour)? onSelectHour;

  /// Callback for minute selection
  final void Function(int minute)? onSelectMinute;

  /// Callback for period toggle (AM/PM)
  final void Function()? onTogglePeriod;

  /// Callback for confirm button
  final void Function()? onConfirm;

  /// Callback for cancel button
  final void Function()? onCancel;

  const TimePickerProps({
    required this.value,
    required this.displayText,
    required this.disabled,
    required this.clearable,
    required this.size,
    required this.isOpen,
    required this.use24Hour,
    required this.selectedHour,
    required this.selectedMinute,
    required this.isPM,
    required this.minuteInterval,
    this.label,
    this.error,
    this.onToggle,
    this.onClear,
    this.onSelectHour,
    this.onSelectMinute,
    this.onTogglePeriod,
    this.onConfirm,
    this.onCancel,
  });
}
