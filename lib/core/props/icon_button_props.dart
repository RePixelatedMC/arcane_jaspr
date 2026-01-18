import 'package:jaspr/jaspr.dart';

enum IconButtonSize {
  small,
  medium,
  large,
}

enum IconButtonVariant {
  primary,
  secondary,
  outline,
  ghost,
  destructive,
  success,
  warning,
}

/// Icon button component properties.
class IconButtonProps {
  final Component icon;
  final void Function()? onPressed;
  final IconButtonVariant variant;
  final IconButtonSize size;
  final bool disabled;
  final bool loading;
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

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer method for icon button components.
mixin IconButtonRendererContract {
  /// Render an icon button component.
  Component iconButton(IconButtonProps props);
}
