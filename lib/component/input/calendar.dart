import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

export '../../core/props/calendar_props.dart'
    show CalendarModeVariant, DateRangeValue, CalendarProps;

/// Calendar selection mode
enum CalendarMode {
  /// Select a single date
  single,

  /// Select a date range
  range,
}

/// A date range
class DateRange {
  final DateTime start;
  final DateTime end;

  const DateRange({
    required this.start,
    required this.end,
  });
}

/// A calendar component for date selection.
///
/// Example:
/// ```dart
/// ArcaneCalendar(
///   selected: selectedDate,
///   onSelect: (date) => setState(() => selectedDate = date),
/// )
/// ```
class ArcaneCalendar extends StatefulComponent {
  /// Currently selected date
  final DateTime? selected;

  /// Called when a date is selected
  final void Function(DateTime)? onSelect;

  /// The month to display (defaults to current month)
  final DateTime? month;

  /// Called when month changes
  final void Function(DateTime)? onMonthChange;

  /// Minimum selectable date
  final DateTime? minDate;

  /// Maximum selectable date
  final DateTime? maxDate;

  /// Custom function to disable specific dates
  final bool Function(DateTime)? disabledDates;

  /// Whether to show week numbers
  final bool showWeekNumbers;

  /// Whether to highlight today
  final bool showToday;

  /// First day of week (0 = Sunday, 1 = Monday)
  final int firstDayOfWeek;

  /// Selection mode
  final CalendarMode mode;

  /// Selected date range (for range mode)
  final DateRange? selectedRange;

  /// Called when range is selected
  final void Function(DateRange)? onRangeSelect;

  const ArcaneCalendar({
    this.selected,
    this.onSelect,
    this.month,
    this.onMonthChange,
    this.minDate,
    this.maxDate,
    this.disabledDates,
    this.showWeekNumbers = false,
    this.showToday = true,
    this.firstDayOfWeek = 0,
    this.mode = CalendarMode.single,
    this.selectedRange,
    this.onRangeSelect,
    super.key,
  });

  @override
  State<ArcaneCalendar> createState() => _ArcaneCalendarState();
}

class _ArcaneCalendarState extends State<ArcaneCalendar> {
  late DateTime _displayMonth;
  DateTime? _rangeStart;

  @override
  void initState() {
    super.initState();
    _displayMonth = component.month ?? component.selected ?? DateTime.now();
    _displayMonth = DateTime(_displayMonth.year, _displayMonth.month, 1);
  }

  void _previousMonth() {
    setState(() {
      _displayMonth = DateTime(_displayMonth.year, _displayMonth.month - 1, 1);
    });
    component.onMonthChange?.call(_displayMonth);
  }

  void _nextMonth() {
    setState(() {
      _displayMonth = DateTime(_displayMonth.year, _displayMonth.month + 1, 1);
    });
    component.onMonthChange?.call(_displayMonth);
  }

  void _goToToday() {
    final now = DateTime.now();
    setState(() {
      _displayMonth = DateTime(now.year, now.month, 1);
    });
    component.onMonthChange?.call(_displayMonth);
  }

  bool _isDisabled(DateTime date) {
    if (component.disabledDates?.call(date) ?? false) return true;
    if (component.minDate != null && date.isBefore(component.minDate!)) return true;
    if (component.maxDate != null && date.isAfter(component.maxDate!)) return true;
    return false;
  }

  void _selectDate(DateTime date) {
    if (_isDisabled(date)) return;

    if (component.mode == CalendarMode.range) {
      if (_rangeStart == null) {
        setState(() => _rangeStart = date);
      } else {
        final start = _rangeStart!.isBefore(date) ? _rangeStart! : date;
        final end = _rangeStart!.isBefore(date) ? date : _rangeStart!;
        component.onRangeSelect?.call(DateRange(start: start, end: end));
        setState(() => _rangeStart = null);
      }
    } else {
      component.onSelect?.call(date);
    }
  }

  CalendarModeVariant get _propsMode => switch (component.mode) {
        CalendarMode.single => CalendarModeVariant.single,
        CalendarMode.range => CalendarModeVariant.range,
      };

  DateRangeValue? get _propsSelectedRange {
    if (component.selectedRange == null) return null;
    return DateRangeValue(
      start: component.selectedRange!.start,
      end: component.selectedRange!.end,
    );
  }

  @override
  Component build(BuildContext context) {
    return context.renderers.calendar(CalendarProps(
      selected: component.selected,
      displayMonth: _displayMonth,
      minDate: component.minDate,
      maxDate: component.maxDate,
      showWeekNumbers: component.showWeekNumbers,
      showToday: component.showToday,
      firstDayOfWeek: component.firstDayOfWeek,
      mode: _propsMode,
      selectedRange: _propsSelectedRange,
      rangeStart: _rangeStart,
      isDisabled: _isDisabled,
      onPreviousMonth: _previousMonth,
      onNextMonth: _nextMonth,
      onGoToToday: _goToToday,
      onSelectDate: _selectDate,
    ));
  }
}
