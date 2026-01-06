import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';
import '../../util/arcane.dart';

// Re-export props for usage
export '../../core/props/section_props.dart';

/// A section component for grouping related content with an optional header.
class ArcaneSection extends StatelessComponent {
  /// Optional section header text
  final String? header;

  /// Optional header component (overrides header text)
  final Component? headerComponent;

  /// The child components
  final List<Component> children;

  /// Whether to show a divider after the header
  final bool showDivider;

  /// Custom padding
  final EdgeInsets? padding;

  /// Gap between children
  final double gap;

  /// Whether this is a card-style section
  final bool card;

  const ArcaneSection({
    this.header,
    this.headerComponent,
    required this.children,
    this.showDivider = false,
    this.padding,
    this.gap = 12,
    this.card = false,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return context.renderers.section(SectionProps(
      header: header,
      headerComponent: headerComponent,
      children: children,
      showDivider: showDivider,
      padding: (padding ?? const EdgeInsets.all(16)).padding,
      gap: '${gap}px',
      card: card,
    ));
  }
}

/// A sliver-style section for use in scrollable lists
class ArcaneSliverSection extends StatelessComponent {
  final String? header;
  final Component? headerComponent;
  final List<Component> children;
  final double gap;

  const ArcaneSliverSection({
    this.header,
    this.headerComponent,
    required this.children,
    this.gap = 12,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return ArcaneSection(
      header: header,
      headerComponent: headerComponent,
      gap: gap,
      children: children,
    );
  }
}
