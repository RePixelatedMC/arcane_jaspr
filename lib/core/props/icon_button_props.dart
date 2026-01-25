import 'package:jaspr/jaspr.dart';
import '../shared/shared.dart';

export '../shared/shared.dart' show ComponentSize, ColorVariant, StyleVariant;

/// Icon button component properties.
class IconButtonProps {
  final Component icon;
  final void Function()? onPressed;
  final ColorVariant color;
  final StyleVariant style;
  final ComponentSize size;
  final bool disabled;
  final bool loading;
  final String? tooltip;

  const IconButtonProps({
    required this.icon,
    this.onPressed,
    this.color = ColorVariant.secondary,
    this.style = StyleVariant.ghost,
    this.size = ComponentSize.md,
    this.disabled = false,
    this.loading = false,
    this.tooltip,
  });

  IconButtonProps copyWith({
    Component? icon,
    void Function()? onPressed,
    ColorVariant? color,
    StyleVariant? style,
    ComponentSize? size,
    bool? disabled,
    bool? loading,
    String? tooltip,
  }) {
    return IconButtonProps(
      icon: icon ?? this.icon,
      onPressed: onPressed ?? this.onPressed,
      color: color ?? this.color,
      style: style ?? this.style,
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
