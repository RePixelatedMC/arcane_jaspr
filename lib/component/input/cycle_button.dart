import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

export '../../core/props/cycle_button_props.dart'
    show CycleButtonSize, CycleButtonVariant, CycleOption;

/// A button that cycles through a list of values on each click.
///
/// ```dart
/// ArcaneCycleButton(
///   options: [CycleOption(value: 1, label: 'One'), ...],
///   value: 1,
///   variant: CycleButtonVariant.outline,
/// )
/// ```
class ArcaneCycleButton<T> extends StatelessComponent {
  /// The available options
  final List<CycleOption<T>> options;

  /// The current value
  final T value;

  /// Callback when value changes
  final void Function(T value)? onChanged;

  /// Button style variant
  final CycleButtonVariant variant;

  /// Button size
  final CycleButtonSize size;

  /// Whether the button is disabled
  final bool disabled;

  /// Optional element ID
  final String? id;

  /// Additional HTML attributes
  final Map<String, String>? attributes;

  const ArcaneCycleButton({
    required this.options,
    required this.value,
    this.onChanged,
    this.variant = CycleButtonVariant.outline,
    this.size = CycleButtonSize.medium,
    this.disabled = false,
    this.id,
    this.attributes,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return context.renderers.cycleButton<T>(CycleButtonProps<T>(
      options: options,
      value: value,
      onChanged: onChanged,
      variant: variant,
      size: size,
      disabled: disabled,
      id: id,
      attributes: attributes,
    ));
  }
}

/// A toggle button (on/off state)
class ArcaneToggleButton extends StatelessComponent {
  /// Whether the button is pressed/active
  final bool value;

  /// Callback when value changes
  final void Function(bool value)? onChanged;

  /// Optional label text
  final String? label;

  /// Optional icon
  final Component? icon;

  /// Button size
  final CycleButtonSize size;

  /// Whether the button is disabled
  final bool disabled;

  /// Optional element ID
  final String? id;

  /// Additional HTML attributes
  final Map<String, String>? attributes;

  const ArcaneToggleButton({
    required this.value,
    this.onChanged,
    this.label,
    this.icon,
    this.size = CycleButtonSize.medium,
    this.disabled = false,
    this.id,
    this.attributes,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return context.renderers.toggleButton(ToggleButtonProps(
      value: value,
      onChanged: onChanged,
      label: label,
      icon: icon,
      size: size,
      disabled: disabled,
      id: id,
      attributes: attributes,
    ));
  }
}
