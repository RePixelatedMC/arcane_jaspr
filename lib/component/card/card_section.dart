import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';
import '../../util/arcane.dart';

export '../../core/props/card_section_props.dart';

/// Card with section-style content organization.
class ArcaneCardSection extends StatelessComponent {
  final String? header;
  final Component? headerComponent;
  final List<Component> children;
  final EdgeInsets? padding;
  final double? radius;
  final double gap;
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

/// List card containing list items with optional dividers.
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
