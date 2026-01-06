
/// Calendar selection mode
enum CalendarModeVariant {
  /// Select a single date
  single,

  /// Select a date range
  range,
}

/// A date range
class DateRangeValue {
  final DateTime start;
  final DateTime end;

  const DateRangeValue({
    required this.start,
    required this.end,
  });
}

/// Props for the calendar component
class CalendarProps {
  /// Currently selected date
  final DateTime? selected;

  /// The month being displayed
  final DateTime displayMonth;

  /// Minimum selectable date
  final DateTime? minDate;

  /// Maximum selectable date
  final DateTime? maxDate;

  /// Whether to show week numbers
  final bool showWeekNumbers;

  /// Whether to show today button
  final bool showToday;

  /// First day of week (0 = Sunday, 1 = Monday)
  final int firstDayOfWeek;

  /// Selection mode
  final CalendarModeVariant mode;

  /// Selected date range (for range mode)
  final DateRangeValue? selectedRange;

  /// Range start being selected (partial selection)
  final DateTime? rangeStart;

  /// Disabled date checker
  final bool Function(DateTime)? isDisabled;

  /// Handlers
  final void Function()? onPreviousMonth;
  final void Function()? onNextMonth;
  final void Function()? onGoToToday;
  final void Function(DateTime date)? onSelectDate;

  const CalendarProps({
    this.selected,
    required this.displayMonth,
    this.minDate,
    this.maxDate,
    this.showWeekNumbers = false,
    this.showToday = true,
    this.firstDayOfWeek = 0,
    this.mode = CalendarModeVariant.single,
    this.selectedRange,
    this.rangeStart,
    this.isDisabled,
    this.onPreviousMonth,
    this.onNextMonth,
    this.onGoToToday,
    this.onSelectDate,
  });
}
