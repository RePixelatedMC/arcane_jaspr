import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

export '../../core/props/disclosure_props.dart'
    show DisclosureVariant, DisclosureItemProps;

/// Disclosure widget using native HTML details/summary elements.
class ArcaneDisclosure extends StatelessComponent {
  final Component summary;
  final Component child;
  final bool open;
  final DisclosureVariant variant;
  final bool showChevron;
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

  const ArcaneDisclosure.minimal({
    required this.summary,
    required this.child,
    this.open = false,
    this.showChevron = true,
    this.classes,
    super.key,
  }) : variant = DisclosureVariant.minimal;

  const ArcaneDisclosure.bordered({
    required this.summary,
    required this.child,
    this.open = false,
    this.showChevron = true,
    this.classes,
    super.key,
  }) : variant = DisclosureVariant.bordered;

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

/// Group of disclosure widgets.
class ArcaneDisclosureGroup extends StatelessComponent {
  final List<ArcaneDisclosureItem> items;
  final String gap;
  final DisclosureVariant variant;
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

/// Item in an ArcaneDisclosureGroup.
class ArcaneDisclosureItem {
  final Component summary;
  final Component content;
  final bool showChevron;

  const ArcaneDisclosureItem({
    required this.summary,
    required this.content,
    this.showChevron = true,
  });
}
