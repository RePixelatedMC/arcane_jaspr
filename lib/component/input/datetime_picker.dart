import 'package:jaspr/jaspr.dart';

import '../../util/arcane.dart';
import '../../util/style_types/index.dart';
import '../html/div.dart';
import '../layout/flow.dart';
import 'time_picker.dart';
import 'date_picker.dart';

export '../../core/props/time_picker_props.dart' show TimeOfDay, TimePickerSize;
export '../../core/props/date_picker_props.dart' show DatePickerSizeVariant;

/// Mode for the datetime picker
enum DateTimePickerMode {
  /// Date only
  date,

  /// Time only
  time,

  /// Both date and time
  dateTime,
}

/// Size variants for the datetime picker
enum DateTimePickerSize {
  sm,
  md,
  lg,
}

/// A unified date and/or time picker component.
///
/// This component consolidates [ArcaneDatePicker] and [ArcaneTimePicker] into
/// a single component with mode selection.
///
/// ## Date Picker
/// ```dart
/// ArcaneDateTimePicker.date(
///   value: selectedDate,
///   onDateChanged: (date) => setState(() => selectedDate = date),
///   label: 'Birth Date',
/// )
/// ```
///
/// ## Time Picker
/// ```dart
/// ArcaneDateTimePicker.time(
///   timeValue: selectedTime,
///   onTimeChanged: (time) => setState(() => selectedTime = time),
///   label: 'Start Time',
/// )
/// ```
///
/// ## DateTime Picker
/// ```dart
/// ArcaneDateTimePicker(
///   value: selectedDateTime,
///   onChanged: (dateTime) => setState(() => selectedDateTime = dateTime),
///   label: 'Event Time',
/// )
/// ```
class ArcaneDateTimePicker extends StatefulComponent {
  /// The picker mode
  final DateTimePickerMode mode;

  /// Currently selected date (for date/dateTime modes)
  final DateTime? value;

  /// Currently selected time (for time mode)
  final TimeOfDay? timeValue;

  /// Called when date changes (date/dateTime modes)
  final void Function(DateTime?)? onDateChanged;

  /// Called when time changes (time mode)
  final void Function(TimeOfDay?)? onTimeChanged;

  /// Called when full datetime changes (dateTime mode)
  final void Function(DateTime?)? onChanged;

  /// Label above the input
  final String? label;

  /// Placeholder text
  final String? placeholder;

  /// Whether the picker is disabled
  final bool disabled;

  /// Error message
  final String? error;

  /// Whether to allow clearing
  final bool clearable;

  /// Size variant
  final DateTimePickerSize size;

  // Date-specific options
  /// Minimum selectable date
  final DateTime? minDate;

  /// Maximum selectable date
  final DateTime? maxDate;

  /// Custom function to disable specific dates
  final bool Function(DateTime)? disabledDates;

  /// Date format function
  final String Function(DateTime)? formatDate;

  // Time-specific options
  /// Whether to use 24-hour format
  final bool use24Hour;

  /// Minute interval (1, 5, 10, 15, 30)
  final int minuteInterval;

  /// Whether to show seconds
  final bool showSeconds;

  /// Creates a datetime picker (both date and time)
  const ArcaneDateTimePicker({
    this.value,
    this.onChanged,
    this.label,
    this.placeholder,
    this.disabled = false,
    this.error,
    this.clearable = true,
    this.size = DateTimePickerSize.md,
    this.minDate,
    this.maxDate,
    this.disabledDates,
    this.formatDate,
    this.use24Hour = false,
    this.minuteInterval = 1,
    this.showSeconds = false,
    super.key,
  })  : mode = DateTimePickerMode.dateTime,
        timeValue = null,
        onDateChanged = null,
        onTimeChanged = null;

  /// Creates a date-only picker
  const ArcaneDateTimePicker.date({
    this.value,
    this.onDateChanged,
    this.label,
    this.placeholder,
    this.disabled = false,
    this.error,
    this.clearable = true,
    this.size = DateTimePickerSize.md,
    this.minDate,
    this.maxDate,
    this.disabledDates,
    this.formatDate,
    super.key,
  })  : mode = DateTimePickerMode.date,
        timeValue = null,
        onTimeChanged = null,
        onChanged = null,
        use24Hour = false,
        minuteInterval = 1,
        showSeconds = false;

  /// Creates a time-only picker
  const ArcaneDateTimePicker.time({
    this.timeValue,
    this.onTimeChanged,
    this.label,
    this.placeholder,
    this.disabled = false,
    this.error,
    this.clearable = true,
    this.size = DateTimePickerSize.md,
    this.use24Hour = false,
    this.minuteInterval = 1,
    this.showSeconds = false,
    super.key,
  })  : mode = DateTimePickerMode.time,
        value = null,
        onDateChanged = null,
        onChanged = null,
        minDate = null,
        maxDate = null,
        disabledDates = null,
        formatDate = null;

  @override
  State<ArcaneDateTimePicker> createState() => _ArcaneDateTimePickerState();
}

class _ArcaneDateTimePickerState extends State<ArcaneDateTimePicker> {
  @override
  Component build(BuildContext context) {
    return switch (component.mode) {
      DateTimePickerMode.date => _buildDatePicker(),
      DateTimePickerMode.time => _buildTimePicker(),
      DateTimePickerMode.dateTime => _buildDateTimePicker(),
    };
  }

  DatePickerSize get _datePickerSize => switch (component.size) {
        DateTimePickerSize.sm => DatePickerSize.sm,
        DateTimePickerSize.md => DatePickerSize.md,
        DateTimePickerSize.lg => DatePickerSize.lg,
      };

  TimePickerSize get _timePickerSize => switch (component.size) {
        DateTimePickerSize.sm => TimePickerSize.sm,
        DateTimePickerSize.md => TimePickerSize.md,
        DateTimePickerSize.lg => TimePickerSize.lg,
      };

  Component _buildDatePicker() {
    return ArcaneDatePicker(
      value: component.value,
      onChanged: component.onDateChanged,
      label: component.label,
      placeholder: component.placeholder,
      disabled: component.disabled,
      error: component.error,
      clearable: component.clearable,
      size: _datePickerSize,
      minDate: component.minDate,
      maxDate: component.maxDate,
      disabledDates: component.disabledDates,
      formatDate: component.formatDate,
    );
  }

  Component _buildTimePicker() {
    return ArcaneTimePicker(
      value: component.timeValue,
      onChanged: component.onTimeChanged,
      label: component.label,
      placeholder: component.placeholder,
      disabled: component.disabled,
      error: component.error,
      clearable: component.clearable,
      size: _timePickerSize,
      use24Hour: component.use24Hour,
      minuteInterval: component.minuteInterval,
      showSeconds: component.showSeconds,
    );
  }

  Component _buildDateTimePicker() {
    // For full datetime mode, we show both date and time pickers
    // Extract time from the datetime value
    final timeValue = component.value != null
        ? TimeOfDay.fromDateTime(component.value!)
        : null;

    return ArcaneRow(
      gapSize: Gap.sm,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        ArcaneExpanded(
          child: ArcaneDatePicker(
            value: component.value,
            onChanged: (date) {
              if (date == null) {
                component.onChanged?.call(null);
                return;
              }
              // Preserve the time when changing date
              final currentTime = component.value != null
                  ? TimeOfDay.fromDateTime(component.value!)
                  : TimeOfDay(hour: 0, minute: 0);
              final newDateTime = DateTime(
                date.year,
                date.month,
                date.day,
                currentTime.hour,
                currentTime.minute,
              );
              component.onChanged?.call(newDateTime);
            },
            label: component.label,
            placeholder: component.placeholder ?? 'Select date...',
            disabled: component.disabled,
            error: component.error,
            clearable: false, // Only allow clearing from time picker
            size: _datePickerSize,
            minDate: component.minDate,
            maxDate: component.maxDate,
            disabledDates: component.disabledDates,
            formatDate: component.formatDate,
          ),
        ),
        ArcaneDiv(
          styles: const ArcaneStyleData(widthCustom: '140px'),
          children: [
            ArcaneTimePicker(
              value: timeValue,
              onChanged: (time) {
                if (time == null) {
                  component.onChanged?.call(null);
                  return;
                }
                // Use today's date if no date is selected
                final currentDate = component.value ?? DateTime.now();
                final newDateTime = DateTime(
                  currentDate.year,
                  currentDate.month,
                  currentDate.day,
                  time.hour,
                  time.minute,
                );
                component.onChanged?.call(newDateTime);
              },
              placeholder: component.placeholder ?? 'Time...',
              disabled: component.disabled,
              clearable: component.clearable,
              size: _timePickerSize,
              use24Hour: component.use24Hour,
              minuteInterval: component.minuteInterval,
              showSeconds: component.showSeconds,
            ),
          ],
        ),
      ],
    );
  }
}
