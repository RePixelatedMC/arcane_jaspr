import 'package:jaspr/jaspr.dart';

enum DisclosureVariant {
  default_,
  minimal,
  bordered,
  filled,
}

/// Disclosure component properties.
class DisclosureProps {
  final Component summary;
  final Component child;
  final bool open;
  final DisclosureVariant variant;
  final bool showChevron;
  final bool showTreeLines;
  final String? classes;

  const DisclosureProps({
    required this.summary,
    required this.child,
    this.open = false,
    this.variant = DisclosureVariant.default_,
    this.showChevron = true,
    this.showTreeLines = false,
    this.classes,
  });
}

/// Disclosure group component properties.
class DisclosureGroupProps {
  final List<DisclosureItemProps> items;
  final String gap;
  final DisclosureVariant variant;
  final int? initialOpenIndex;

  const DisclosureGroupProps({
    required this.items,
    this.gap = '0.5rem',
    this.variant = DisclosureVariant.default_,
    this.initialOpenIndex,
  });
}

/// Disclosure item data.
class DisclosureItemProps {
  final Component summary;
  final Component content;
  final bool showChevron;

  const DisclosureItemProps({
    required this.summary,
    required this.content,
    this.showChevron = true,
  });
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer methods for disclosure components.
mixin DisclosureRendererContract {
  Component disclosure(DisclosureProps props);
  Component disclosureGroup(DisclosureGroupProps props);
}
