import 'package:jaspr/jaspr.dart';

/// Icon button size variants.
enum IconButtonSize {
  /// Small - 28px
  small,

  /// Medium (default) - 36px
  medium,

  /// Large - 44px
  large,
}

/// Icon button visual variants.
enum IconButtonVariant {
  /// Primary - solid primary color background
  primary,

  /// Secondary - subtle background
  secondary,

  /// Outline - bordered with transparent background
  outline,

  /// Ghost - minimal styling, transparent
  ghost,

  /// Destructive - error/delete actions
  destructive,

  /// Success - positive actions
  success,

  /// Warning - caution actions
  warning,
}

/// Properties for icon button components.
class IconButtonProps {
  /// The icon to display
  final Component icon;

  /// Click handler
  final void Function()? onPressed;

  /// Visual variant
  final IconButtonVariant variant;

  /// Size variant
  final IconButtonSize size;

  /// Whether the button is disabled
  final bool disabled;

  /// Whether the button is in loading state
  final bool loading;

  /// Optional tooltip text
  final String? tooltip;

  const IconButtonProps({
    required this.icon,
    this.onPressed,
    this.variant = IconButtonVariant.ghost,
    this.size = IconButtonSize.medium,
    this.disabled = false,
    this.loading = false,
    this.tooltip,
  });

  /// Create a copy with modified properties
  IconButtonProps copyWith({
    Component? icon,
    void Function()? onPressed,
    IconButtonVariant? variant,
    IconButtonSize? size,
    bool? disabled,
    bool? loading,
    String? tooltip,
  }) {
    return IconButtonProps(
      icon: icon ?? this.icon,
      onPressed: onPressed ?? this.onPressed,
      variant: variant ?? this.variant,
      size: size ?? this.size,
      disabled: disabled ?? this.disabled,
      loading: loading ?? this.loading,
      tooltip: tooltip ?? this.tooltip,
    );
  }
}
