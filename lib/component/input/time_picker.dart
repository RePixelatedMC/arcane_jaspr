import 'package:arcane_jaspr/flutter.dart';
import 'package:jaspr/jaspr.dart' hide BuildContext, InheritedComponent, Key, State, StatefulComponent, StatelessComponent, UniqueKey, ValueKey, runApp;

import '../../core/theme_provider.dart';

export '../../core/props/time_picker_props.dart';

/// A time picker input with dropdown selection.
class ArcaneTimePicker extends StatefulWidget {
  final TimeOfDay? value;
  final void Function(TimeOfDay?)? onChanged;
  final String? label;
  final String? placeholder;
  final bool use24Hour;
  final int minuteInterval;
  final bool disabled;
  final String? error;
  final bool clearable;
  final bool showSeconds;
  final ComponentSize size;

  const ArcaneTimePicker({
    this.value,
    this.onChanged,
    this.label,
    this.placeholder,
    this.use24Hour = false,
    this.minuteInterval = 1,
    this.disabled = false,
    this.error,
    this.clearable = true,
    this.showSeconds = false,
    this.size = ComponentSize.md,
    super.key,
  });

  @override
  State<ArcaneTimePicker> createState() => _ArcaneTimePickerState();
}

class _ArcaneTimePickerState extends State<ArcaneTimePicker> {
  bool _isOpen = false;
  int _selectedHour = 0;
  int _selectedMinute = 0;
  bool _isPM = false;

  @override
  void initState() {
    super.initState();
    _initFromValue();
  }

  void _initFromValue() {
    if (component.value != null) {
      _selectedHour = component.use24Hour
          ? component.value!.hour
          : component.value!.hourOfPeriod;
      _selectedMinute = component.value!.minute;
      _isPM = component.value!.isPM;
    } else {
      final now = TimeOfDay.now();
      _selectedHour = component.use24Hour ? now.hour : now.hourOfPeriod;
      _selectedMinute = 0;
      _isPM = now.isPM;
    }
  }

  String get _displayText {
    if (component.value == null) {
      return component.placeholder ?? 'Select time...';
    }
    return component.value!.format(use24Hour: component.use24Hour);
  }

  void _toggleOpen() {
    if (component.disabled) return;
    setState(() => _isOpen = !_isOpen);
  }

  void _selectHour(int hour) {
    setState(() => _selectedHour = hour);
    _emitChange();
  }

  void _selectMinute(int minute) {
    setState(() => _selectedMinute = minute);
    _emitChange();
  }

  void _togglePeriod() {
    setState(() => _isPM = !_isPM);
    _emitChange();
  }

  void _emitChange() {
    int hour24 = _selectedHour;
    if (!component.use24Hour) {
      if (_isPM && _selectedHour != 12) {
        hour24 = _selectedHour + 12;
      } else if (!_isPM && _selectedHour == 12) {
        hour24 = 0;
      }
    }
    component.onChanged?.call(TimeOfDay(hour: hour24, minute: _selectedMinute));
  }

  void _clear() {
    component.onChanged?.call(null);
    setState(() => _isOpen = false);
  }

  void _confirm() {
    _emitChange();
    setState(() => _isOpen = false);
  }

  void _cancel() {
    setState(() => _isOpen = false);
  }

  @override
  Widget build(BuildContext context) {
    return context.renderers.timePicker(TimePickerProps(
      value: component.value,
      displayText: _displayText,
      label: component.label,
      disabled: component.disabled,
      error: component.error,
      clearable: component.clearable,
      size: component.size,
      isOpen: _isOpen,
      use24Hour: component.use24Hour,
      selectedHour: _selectedHour,
      selectedMinute: _selectedMinute,
      isPM: _isPM,
      minuteInterval: component.minuteInterval,
      onToggle: _toggleOpen,
      onClear: _clear,
      onSelectHour: _selectHour,
      onSelectMinute: _selectMinute,
      onTogglePeriod: _togglePeriod,
      onConfirm: _confirm,
      onCancel: _cancel,
    ));
  }
}
