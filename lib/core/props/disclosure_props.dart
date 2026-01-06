import 'package:jaspr/jaspr.dart';

/// Visual variants for disclosure components.
enum DisclosureVariant {
  /// Default style with subtle summary background
  default_,

  /// Minimal style with no backgrounds or borders
  minimal,

  /// Bordered container
  bordered,

  /// Filled background with border
  filled,
}

/// Properties for disclosure components.
class DisclosureProps {
  /// The always-visible summary/header content
  final Component summary;

  /// The collapsible content
  final Component child;

  /// Whether initially open
  final bool open;

  /// Visual variant
  final DisclosureVariant variant;

  /// Whether to show the chevron indicator
  final bool showChevron;

  /// Custom CSS class for the container
  final String? classes;

  const DisclosureProps({
    required this.summary,
    required this.child,
    this.open = false,
    this.variant = DisclosureVariant.default_,
    this.showChevron = true,
    this.classes,
  });
}

/// Properties for disclosure group components.
class DisclosureGroupProps {
  /// The disclosure items
  final List<DisclosureItemProps> items;

  /// Gap between items
  final String gap;

  /// Visual variant for all items
  final DisclosureVariant variant;

  /// Index of initially open item (null for all closed)
  final int? initialOpenIndex;

  const DisclosureGroupProps({
    required this.items,
    this.gap = '0.5rem',
    this.variant = DisclosureVariant.default_,
    this.initialOpenIndex,
  });
}

/// An item in a disclosure group.
class DisclosureItemProps {
  /// The summary/header component
  final Component summary;

  /// The collapsible content
  final Component content;

  /// Whether to show the chevron
  final bool showChevron;

  const DisclosureItemProps({
    required this.summary,
    required this.content,
    this.showChevron = true,
  });
}
