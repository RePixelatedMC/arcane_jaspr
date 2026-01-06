import 'package:jaspr/jaspr.dart';

/// Props for section components.
class SectionProps {
  /// Optional section header text
  final String? header;

  /// Optional header component (overrides header text)
  final Component? headerComponent;

  /// The child components
  final List<Component> children;

  /// Whether to show a divider after the header
  final bool showDivider;

  /// Custom padding
  final String? padding;

  /// Gap between children
  final String? gap;

  /// Whether this is a card-style section
  final bool card;

  const SectionProps({
    this.header,
    this.headerComponent,
    required this.children,
    this.showDivider = false,
    this.padding,
    this.gap,
    this.card = false,
  });
}
