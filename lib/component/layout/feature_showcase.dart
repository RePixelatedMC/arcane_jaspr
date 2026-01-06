import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

export '../../core/props/feature_showcase_props.dart';

/// A feature showcase item (re-export from props)
typedef ArcaneFeatureShowcaseItem = FeatureShowcaseItem;

/// A feature showcase section using FlexiCards.
///
/// Creates a full-width section with a title, subtitle, and interactive
/// flexi cards that expand on hover to reveal more detail.
///
/// ```dart
/// ArcaneFeatureShowcase(
///   title: 'Why Choose Us?',
///   subtitle: 'Hover over any card to learn more.',
///   items: [
///     ArcaneFeatureShowcaseItem(
///       icon: ArcaneIcon.server(size: IconSize.xl),
///       title: 'Fast Servers',
///       description: 'Enterprise-grade hardware...',
///     ),
///     // ...more items
///   ],
/// )
/// ```
class ArcaneFeatureShowcase extends StatelessComponent {
  /// Section title
  final String title;

  /// Section subtitle/description
  final String? subtitle;

  /// The feature items to display
  final List<FeatureShowcaseItem> items;

  /// Flex value for expanded (hovered) cards
  final double expandedFlex;

  /// Flex value for collapsed (non-hovered) cards
  final double collapsedFlex;

  /// Gap between cards
  final String gap;

  /// Minimum width of each card
  final String minCardWidth;

  /// Whether to show long text only on hover
  final bool expandOnHover;

  /// Custom background color for the section
  final String? background;

  /// Whether to center the title/subtitle
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
