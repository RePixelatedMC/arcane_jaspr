import 'package:jaspr/jaspr.dart';

import '../../util/arcane.dart';
import '../../util/style_types/index.dart';
import '../html/div.dart';
import '../layout/flow.dart';
import 'time_picker.dart';
import 'date_picker.dart';

export '../../core/props/time_picker_props.dart' show TimeOfDay, TimePickerSize;
export '../../core/props/date_picker_props.dart' show DatePickerSizeVariant;

/// Mode for the datetime picker.
enum DateTimePickerMode {
  date,
  time,
  dateTime,
}

/// Size variants for the datetime picker.
enum DateTimePickerSize {
  sm,
  md,
  lg,
}

/// A unified date and/or time picker component.
class ArcaneDateTimePicker extends StatefulComponent {
  final DateTimePickerMode mode;
  final DateTime? value;
  final TimeOfDay? timeValue;
  final void Function(DateTime?)? onDateChanged;
  final void Function(TimeOfDay?)? onTimeChanged;
  final void Function(DateTime?)? onChanged;
  final String? label;
  final String? placeholder;
  final bool disabled;
  final String? error;
  final bool clearable;
  final DateTimePickerSize size;
  final DateTime? minDate;
  final DateTime? maxDate;
  final bool Function(DateTime)? disabledDates;
  final String Function(DateTime)? formatDate;
  final bool use24Hour;
  final int minuteInterval;
  final bool showSeconds;

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
            clearable: false,
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
