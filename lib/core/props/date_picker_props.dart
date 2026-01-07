import 'calendar_props.dart';

enum DatePickerSizeVariant {
  sm,
  md,
  lg,
}

/// Date picker component properties.
class DatePickerProps {
  final DateTime? value;
  final String? label;
  final String? placeholder;
  final DateTime? minDate;
  final DateTime? maxDate;
  final bool disabled;
  final String? error;
  final bool clearable;
  final DatePickerSizeVariant size;
  final CalendarModeVariant mode;
  final DateRangeValue? rangeValue;
  final bool isOpen;
  final String displayText;
  final void Function()? onToggle;
  final void Function(DateTime date)? onSelect;
  final void Function(DateRangeValue range)? onRangeSelect;
  final void Function()? onClear;
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
