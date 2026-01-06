import 'package:jaspr/jaspr.dart';

import '../../core/props/card_section_props.dart';
import '../../core/theme_provider.dart';
import '../../util/arcane.dart';

// Re-export props for usage
export '../../core/props/card_section_props.dart';

/// A card with section-style content organization.
class ArcaneCardSection extends StatelessComponent {
  /// Section header
  final String? header;

  /// Header component (overrides header string)
  final Component? headerComponent;

  /// The child components
  final List<Component> children;

  /// Custom padding
  final EdgeInsets? padding;

  /// Border radius
  final double? radius;

  /// Gap between children
  final double gap;

  /// Trailing actions for the header
  final List<Component>? trailing;

  const ArcaneCardSection({
    this.header,
    this.headerComponent,
    required this.children,
    this.padding,
    this.radius,
    this.gap = 12,
    this.trailing,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return context.renderers.cardSection(CardSectionProps(
      header: header,
      headerComponent: headerComponent,
      children: children,
      padding: (padding ?? const EdgeInsets.all(16)).padding,
      radius: radius != null ? '${radius}px' : null,
      gap: '${gap}px',
      trailing: trailing,
    ));
  }
}

/// A list card that contains list items
class ArcaneListCard extends StatelessComponent {
  final String? header;
  final List<Component> children;
  final double? radius;
  final bool divided;

  const ArcaneListCard({
    this.header,
    required this.children,
    this.radius,
    this.divided = true,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return context.renderers.listCard(ListCardProps(
      header: header,
      children: children,
      radius: radius != null ? '${radius}px' : null,
      divided: divided,
    ));
  }
}
