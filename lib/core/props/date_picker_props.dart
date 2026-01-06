
import 'calendar_props.dart';

/// Size variants for date picker
enum DatePickerSizeVariant {
  sm,
  md,
  lg,
}

/// Props for the date picker component
class DatePickerProps {
  /// Currently selected date
  final DateTime? value;

  /// Label above the input
  final String? label;

  /// Placeholder text
  final String? placeholder;

  /// Minimum selectable date
  final DateTime? minDate;

  /// Maximum selectable date
  final DateTime? maxDate;

  /// Whether the picker is disabled
  final bool disabled;

  /// Error message
  final String? error;

  /// Whether to allow clearing the date
  final bool clearable;

  /// Size variant
  final DatePickerSizeVariant size;

  /// Selection mode
  final CalendarModeVariant mode;

  /// Selected date range (for range mode)
  final DateRangeValue? rangeValue;

  /// Whether the dropdown is open
  final bool isOpen;

  /// Display text
  final String displayText;

  /// Handlers
  final void Function()? onToggle;
  final void Function(DateTime date)? onSelect;
  final void Function(DateRangeValue range)? onRangeSelect;
  final void Function()? onClear;

  /// Calendar props for the dropdown
  final CalendarProps? calendarProps;

  const DatePickerProps({
    this.value,
    this.label,
    this.placeholder,
    this.minDate,
    this.maxDate,
    this.disabled = false,
    this.error,
    this.clearable = true,
    this.size = DatePickerSizeVariant.md,
    this.mode = CalendarModeVariant.single,
    this.rangeValue,
    this.isOpen = false,
    this.displayText = 'Select date...',
    this.onToggle,
    this.onSelect,
    this.onRangeSelect,
    this.onClear,
    this.calendarProps,
  });
}
