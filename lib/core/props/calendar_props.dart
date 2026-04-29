import 'package:jaspr/jaspr.dart';

enum CalendarModeVariant {
  single,
  range,
}

/// Date range value.
class DateRangeValue {
  final DateTime start;
  final DateTime end;

  const DateRangeValue({
    required this.start,
    required this.end,
  });
}

/// Calendar component properties.
class CalendarProps {
  final String? id;
  final DateTime? selected;
  final DateTime displayMonth;
  final DateTime? minDate;
  final DateTime? maxDate;
  final bool showWeekNumbers;
  final bool showToday;
  final int firstDayOfWeek;
  final CalendarModeVariant mode;
  final DateRangeValue? selectedRange;
  final DateTime? rangeStart;
  final bool Function(DateTime)? isDisabled;
  final void Function()? onPreviousMonth;
  final void Function()? onNextMonth;
  final void Function()? onGoToToday;
  final void Function(DateTime date)? onSelectDate;

  const CalendarProps({
    this.id,
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

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer methods for calendar components.
mixin CalendarRendererContract {
  Component calendar(CalendarProps props);
}
