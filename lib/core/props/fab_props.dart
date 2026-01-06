import 'package:jaspr/jaspr.dart';

/// FAB style variants.
enum FABVariant {
  /// Primary accent color
  primary,

  /// Surface/neutral color
  surface,

  /// Success/green color
  success,

  /// Destructive/red color
  destructive,

  /// Secondary color
  secondary,
}

/// FAB size variants.
enum FABSize {
  /// Small FAB
  small,

  /// Regular/default FAB
  regular,

  /// Large FAB
  large,
}

/// FAB position variants.
enum FABPosition {
  /// Fixed to bottom-right corner
  bottomRight,

  /// Fixed to bottom-left corner
  bottomLeft,

  /// Fixed to bottom-center
  bottomCenter,

  /// Fixed to top-right corner
  topRight,

  /// Fixed to top-left corner
  topLeft,

  /// Relative positioning (no fixed position)
  relative,
}

/// Properties for FAB (Floating Action Button) components.
class FABProps {
  /// The icon to display
  final Component icon;

  /// Optional label for extended FAB
  final String? label;

  /// Click handler
  final void Function()? onPressed;

  /// Style variant
  final FABVariant variant;

  /// FAB size
  final FABSize size;

  /// Whether the FAB is disabled
  final bool disabled;

  /// Position of the FAB
  final FABPosition position;

  /// Tooltip text
  final String? tooltip;

  /// Optional element ID
  final String? id;

  /// Additional HTML attributes
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

  /// Create a copy with modified properties
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
