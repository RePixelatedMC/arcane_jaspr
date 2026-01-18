import 'package:jaspr/jaspr.dart';

enum FABVariant {
  primary,
  surface,
  success,
  destructive,
  secondary,
}

enum FABSize {
  small,
  regular,
  large,
}

enum FABPosition {
  bottomRight,
  bottomLeft,
  bottomCenter,
  topRight,
  topLeft,
  relative,
}

/// FAB (Floating Action Button) component properties.
class FABProps {
  final Component icon;
  final String? label;
  final void Function()? onPressed;
  final FABVariant variant;
  final FABSize size;
  final bool disabled;
  final FABPosition position;
  final String? tooltip;
  final String? id;
  final Map<String, String>? attributes;

  const FABProps({
    required this.icon,
    this.label,
    this.onPressed,
    this.variant = FABVariant.primary,
    this.size = FABSize.regular,
    this.disabled = false,
    this.position = FABPosition.bottomRight,
    this.tooltip,
    this.id,
    this.attributes,
  });

  FABProps copyWith({
    Component? icon,
    String? label,
    void Function()? onPressed,
    FABVariant? variant,
    FABSize? size,
    bool? disabled,
    FABPosition? position,
    String? tooltip,
    String? id,
    Map<String, String>? attributes,
  }) {
    return FABProps(
      icon: icon ?? this.icon,
      label: label ?? this.label,
      onPressed: onPressed ?? this.onPressed,
      variant: variant ?? this.variant,
      size: size ?? this.size,
      disabled: disabled ?? this.disabled,
      position: position ?? this.position,
      tooltip: tooltip ?? this.tooltip,
      id: id ?? this.id,
      attributes: attributes ?? this.attributes,
    );
  }
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer method for floating action button components.
mixin FabRendererContract {
  /// Render a floating action button component.
  Component fab(FABProps props);
}
