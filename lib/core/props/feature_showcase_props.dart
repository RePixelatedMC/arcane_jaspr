import 'package:jaspr/jaspr.dart';

/// A feature showcase item
class FeatureShowcaseItem {
  /// Icon component displayed at the top of the card
  final Component icon;

  /// Feature title (always visible)
  final String title;

  /// Feature description (shown on hover/expand)
  final String description;

  /// Optional header component
  final Component? header;

  /// Optional footer component (e.g., "Learn more" link)
  final Component? footer;

  /// Optional click handler
  final void Function()? onTap;

  /// Optional link href
  final String? href;

  const FeatureShowcaseItem({
    required this.icon,
    required this.title,
    required this.description,
    this.header,
    this.footer,
    this.onTap,
    this.href,
  });
}

/// Properties for feature showcase components.
class FeatureShowcaseProps {
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

  const FeatureShowcaseProps({
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
  });
}
