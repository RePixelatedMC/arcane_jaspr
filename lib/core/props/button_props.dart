import 'package:jaspr/jaspr.dart';

/// Button style variants.
///
/// These are semantic variants that each stylesheet interprets
/// according to its design language.
enum ButtonVariant {
  /// Primary call-to-action button
  primary,

  /// Secondary/muted button
  secondary,

  /// Outline/bordered button
  outline,

  /// Ghost/transparent button
  ghost,

  /// Destructive/danger button
  destructive,

  /// Link-styled button
  link,

  /// Success/positive action button
  success,

  /// Warning/caution button
  warning,

  /// Informational button
  info,
}

/// Button size variants.
enum ButtonSize {
  /// Small button
  small,

  /// Medium/default button
  medium,

  /// Large button
  large,

  /// Icon-only button (square)
  icon,

  /// Small icon button
  iconSmall,

  /// Large icon button
  iconLarge,
}

/// Properties for button components.
///
/// This is the shared props class used by all stylesheet renderers.
/// The actual rendering is determined by the active stylesheet.
class ButtonProps {
  /// Button label text
  final String? label;

  /// Child component (alternative to label)
  final Component? child;

  /// Leading icon
  final Component? icon;

  /// Trailing icon
  final Component? trailing;

  /// Click handler
  final void Function()? onPressed;

  /// Button style variant
  final ButtonVariant variant;

  /// Button size
  final ButtonSize size;

  /// Whether the button is disabled
  final bool disabled;

  /// Whether the button is in loading state
  final bool loading;

  /// Whether to expand to full width
  final bool fullWidth;

  /// Optional element ID
  final String? id;

  /// Additional HTML attributes
  final Map<String, String>? attributes;

  const ButtonProps({
    this.label,
    this.child,
    this.icon,
    this.trailing,
    this.onPressed,
    this.variant = ButtonVariant.primary,
    this.size = ButtonSize.medium,
    this.disabled = false,
    this.loading = false,
    this.fullWidth = false,
    this.id,
    this.attributes,
  });

  /// Create a copy with modified properties
  ButtonProps copyWith({
    String? label,
    Component? child,
    Component? icon,
    Component? trailing,
    void Function()? onPressed,
    ButtonVariant? variant,
    ButtonSize? size,
    bool? disabled,
    bool? loading,
    bool? fullWidth,
    String? id,
    Map<String, String>? attributes,
  }) {
    return ButtonProps(
      label: label ?? this.label,
      child: child ?? this.child,
      icon: icon ?? this.icon,
      trailing: trailing ?? this.trailing,
      onPressed: onPressed ?? this.onPressed,
      variant: variant ?? this.variant,
      size: size ?? this.size,
      disabled: disabled ?? this.disabled,
      loading: loading ?? this.loading,
      fullWidth: fullWidth ?? this.fullWidth,
      id: id ?? this.id,
      attributes: attributes ?? this.attributes,
    );
  }
}
