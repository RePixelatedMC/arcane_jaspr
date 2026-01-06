import 'package:jaspr/jaspr.dart';

/// Card visual style variants.
enum CardVariant {
  /// Default card with subtle shadow
  elevated,

  /// Flat card without shadow
  flat,

  /// Outlined card with border
  outlined,

  /// No border, no background
  ghost,

  /// Glass/frosted effect
  glass,

  /// Interactive with hover effect
  interactive,
}

/// Properties for card components.
class CardProps {
  /// Child content
  final Component? child;

  /// Children components
  final List<Component>? children;

  /// Visual style variant
  final CardVariant variant;

  /// Custom padding
  final String? padding;

  /// Border radius
  final String? borderRadius;

  /// Custom background color
  final String? backgroundColor;

  /// Whether to fill width
  final bool fillWidth;

  /// Click handler
  final void Function()? onTap;

  const CardProps({
    this.child,
    this.children,
    this.variant = CardVariant.elevated,
    this.padding,
    this.borderRadius,
    this.backgroundColor,
    this.fillWidth = false,
    this.onTap,
  }) : assert(child != null || children != null,
            'Either child or children must be provided');

  /// Create a copy with modified properties
  CardProps copyWith({
    Component? child,
    List<Component>? children,
    CardVariant? variant,
    String? padding,
    String? borderRadius,
    String? backgroundColor,
    bool? fillWidth,
    void Function()? onTap,
  }) {
    return CardProps(
      child: child ?? this.child,
      children: children ?? this.children,
      variant: variant ?? this.variant,
      padding: padding ?? this.padding,
      borderRadius: borderRadius ?? this.borderRadius,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      fillWidth: fillWidth ?? this.fillWidth,
      onTap: onTap ?? this.onTap,
    );
  }
}
