import 'package:jaspr/jaspr.dart';

import '../../core/props/disclosure_props.dart';
import '../../core/theme_provider.dart';

// Re-export enums for usage
export '../../core/props/disclosure_props.dart'
    show DisclosureVariant, DisclosureItemProps;

/// A disclosure widget that uses native HTML details/summary elements.
///
/// Unlike [ArcaneExpander], this component works on static sites without
/// JavaScript because browsers handle the expand/collapse behavior natively.
///
/// Example:
/// ```dart
/// ArcaneDisclosure(
///   summary: ArcaneText('Click to expand'),
///   child: ArcaneText('Hidden content here'),
/// )
/// ```
class ArcaneDisclosure extends StatelessComponent {
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

  const ArcaneDisclosure({
    required this.summary,
    required this.child,
    this.open = false,
    this.variant = DisclosureVariant.default_,
    this.showChevron = true,
    this.classes,
    super.key,
  });

  /// Creates a minimal disclosure with no borders or background
  const ArcaneDisclosure.minimal({
    required this.summary,
    required this.child,
    this.open = false,
    this.showChevron = true,
    this.classes,
    super.key,
  }) : variant = DisclosureVariant.minimal;

  /// Creates a bordered disclosure
  const ArcaneDisclosure.bordered({
    required this.summary,
    required this.child,
    this.open = false,
    this.showChevron = true,
    this.classes,
    super.key,
  }) : variant = DisclosureVariant.bordered;

  /// Creates a filled disclosure with background
  const ArcaneDisclosure.filled({
    required this.summary,
    required this.child,
    this.open = false,
    this.showChevron = true,
    this.classes,
    super.key,
  }) : variant = DisclosureVariant.filled;

  @override
  Component build(BuildContext context) {
    return context.renderers.disclosure(DisclosureProps(
      summary: summary,
      child: child,
      open: open,
      variant: variant,
      showChevron: showChevron,
      classes: classes,
    ));
  }
}

/// A group of disclosure widgets where optionally only one can be open at a time.
///
/// Note: The "only one open" behavior requires JavaScript. If running on a
/// static site without JS hydration, all disclosures will be independently
/// controllable (like a regular accordion).
///
/// For guaranteed static-site compatibility with exclusive behavior, consider
/// using separate [ArcaneDisclosure] widgets with `open` set appropriately.
class ArcaneDisclosureGroup extends StatelessComponent {
  /// The disclosure items
  final List<ArcaneDisclosureItem> items;

  /// Gap between items
  final String gap;

  /// Visual variant for all items
  final DisclosureVariant variant;

  /// Index of initially open item (null for all closed)
  final int? initialOpenIndex;

  const ArcaneDisclosureGroup({
    required this.items,
    this.gap = '0.5rem',
    this.variant = DisclosureVariant.default_,
    this.initialOpenIndex,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return context.renderers.disclosureGroup(DisclosureGroupProps(
      items: items
          .map((item) => DisclosureItemProps(
                summary: item.summary,
                content: item.content,
                showChevron: item.showChevron,
              ))
          .toList(),
      gap: gap,
      variant: variant,
      initialOpenIndex: initialOpenIndex,
    ));
  }
}

/// An item in an [ArcaneDisclosureGroup]
class ArcaneDisclosureItem {
  /// The summary/header component
  final Component summary;

  /// The collapsible content
  final Component content;

  /// Whether to show the chevron
  final bool showChevron;

  const ArcaneDisclosureItem({
    required this.summary,
    required this.content,
    this.showChevron = true,
  });
}
