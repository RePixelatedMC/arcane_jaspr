import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

export '../../core/props/feature_showcase_props.dart';

typedef ArcaneFeatureShowcaseItem = FeatureShowcaseItem;

/// A feature showcase section using FlexiCards.
class ArcaneFeatureShowcase extends StatelessComponent {
  final String title;
  final String? subtitle;
  final List<FeatureShowcaseItem> items;
  final double expandedFlex;
  final double collapsedFlex;
  final String gap;
  final String minCardWidth;
  final bool expandOnHover;
  final String? background;
  final bool centerHeader;

  const ArcaneFeatureShowcase({
    required this.title,
    this.subtitle,
    required this.items,
    this.expandedFlex = 2.5,
    this.collapsedFlex = 1.0,
    this.gap = '1.5rem',
    this.minCardWidth = '280px',
    this.expandOnHover = true,
    this.background,
    this.centerHeader = true,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return context.renderers.featureShowcase(FeatureShowcaseProps(
      title: title,
      subtitle: subtitle,
      items: items,
      expandedFlex: expandedFlex,
      collapsedFlex: collapsedFlex,
      gap: gap,
      minCardWidth: minCardWidth,
      expandOnHover: expandOnHover,
      background: background,
      centerHeader: centerHeader,
    ));
  }
}
