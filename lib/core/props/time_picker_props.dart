/// Represents a time of day with hour and minute.
class TimeOfDay {
  final int hour;
  final int minute;

  const TimeOfDay({required this.hour, required this.minute});

  factory TimeOfDay.now() {
    final now = DateTime.now();
    return TimeOfDay(hour: now.hour, minute: now.minute);
  }

  factory TimeOfDay.fromDateTime(DateTime dateTime) {
    return TimeOfDay(hour: dateTime.hour, minute: dateTime.minute);
  }

  int get hourOfPeriod => hour == 0 ? 12 : (hour > 12 ? hour - 12 : hour);

  bool get isPM => hour >= 12;

  String format({bool use24Hour = false}) {
    if (use24Hour) {
      return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
    }
    final period = isPM ? 'PM' : 'AM';
    return '${hourOfPeriod.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $period';
  }

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

enum TimePickerSize {
  sm,
  md,
  lg,
}

/// Time picker component properties.
class TimePickerProps {
  final TimeOfDay? value;
  final String displayText;
  final String? label;
  final bool disabled;
  final String? error;
  final bool clearable;
  final TimePickerSize size;
  final bool isOpen;
  final bool use24Hour;
  final int selectedHour;
  final int selectedMinute;
  final bool isPM;
  final int minuteInterval;
  final void Function()? onToggle;
  final void Function()? onClear;
  final void Function(int hour)? onSelectHour;
  final void Function(int minute)? onSelectMinute;
  final void Function()? onTogglePeriod;
  final void Function()? onConfirm;
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
