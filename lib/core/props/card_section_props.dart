import 'package:jaspr/jaspr.dart';

/// Props for card section components.
class CardSectionProps {
  /// Section header
  final String? header;

  /// Header component (overrides header string)
  final Component? headerComponent;

  /// The child components
  final List<Component> children;

  /// Custom padding
  final String? padding;

  /// Border radius
  final String? radius;

  /// Gap between children
  final String? gap;

  /// Trailing actions for the header
  final List<Component>? trailing;

  const CardSectionProps({
    this.header,
    this.headerComponent,
    required this.children,
    this.padding,
    this.radius,
    this.gap,
    this.trailing,
  });
}

/// Props for list card components.
class ListCardProps {
  /// Header text
  final String? header;

  /// The child components
  final List<Component> children;

  /// Border radius
  final String? radius;

  /// Whether to show dividers between items
  final bool divided;

  const ListCardProps({
    this.header,
    required this.children,
    this.radius,
    this.divided = true,
  });
}
