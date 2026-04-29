import 'package:arcane_jaspr/flutter.dart';
import 'package:jaspr/jaspr.dart' hide BuildContext, InheritedComponent, Key, State, StatefulComponent, StatelessComponent, UniqueKey, ValueKey, runApp;

import '../../core/theme_provider.dart';

export '../../core/props/time_picker_props.dart';

/// A time picker input with dropdown selection. The runtime drives all
/// open/close, hour/minute selection, and display updates from the
/// emitted DOM, so this widget is purely declarative.
class ArcaneTimePicker extends StatelessWidget {
  final String? id;
  final TimeOfDay? value;
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
    this.id,
    this.value,
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

  String get _displayText {
    if (value == null) {
      return placeholder ?? 'Select time...';
    }
    return value!.format(use24Hour: use24Hour);
  }

  @override
  Widget build(BuildContext context) {
    return context.renderers.timePicker(TimePickerProps(
      id: id,
      value: value,
      displayText: _displayText,
      placeholder: placeholder,
      label: label,
      disabled: disabled,
      error: error,
      clearable: clearable,
      size: size,
      use24Hour: use24Hour,
      minuteInterval: minuteInterval,
    ));
  }
}
