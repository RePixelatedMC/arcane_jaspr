import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart'
    hide
        Color,
        Colors,
        ColorScheme,
        Gap,
        Padding,
        TextAlign,
        TextOverflow,
        Border,
        BorderRadius,
        BoxShadow,
        FontWeight;

import '../view/flexi_cards.dart';

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
  final List<ArcaneFeatureShowcaseItem> items;

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
    return section(
      classes: 'arcane-feature-showcase',
      styles: Styles(raw: {
        'padding': '3rem 1.5rem',
        if (background != null) 'background': background!,
      }),
      [
        div(
          classes: 'arcane-feature-showcase-container',
          styles: const Styles(raw: {
            'max-width': '1200px',
            'margin': '0 auto',
          }),
          [
            // Header
            div(
              classes: 'arcane-feature-showcase-header',
              styles: Styles(raw: {
                if (centerHeader) 'text-align': 'center',
                'margin-bottom': '3rem',
              }),
              [
                // Title
                h2(
                  classes: 'arcane-feature-showcase-title',
                  styles: const Styles(raw: {
                    'font-size': '1.5rem',
                    'font-weight': '700',
                    'color': 'var(--foreground)',
                    'margin': '0 0 1rem 0',
                  }),
                  [Component.text(title)],
                ),

                // Subtitle
                if (subtitle != null)
                  p(
                    classes: 'arcane-feature-showcase-subtitle',
                    styles: Styles(raw: {
                      'font-size': '1.125rem',
                      'color': 'var(--muted-foreground)',
                      'margin': '0',
                      'max-width': '600px',
                      if (centerHeader) 'margin-left': 'auto',
                      if (centerHeader) 'margin-right': 'auto',
                    }),
                    [Component.text(subtitle!)],
                  ),
              ],
            ),

            // FlexiCards
            ArcaneFlexiCards(
              expandedFlex: expandedFlex,
              collapsedFlex: collapsedFlex,
              gap: gap,
              minCardWidth: minCardWidth,
              expandLongTextOnHover: expandOnHover,
              items: items
                  .map((item) => ArcaneFlexiCardItem(
                        icon: item.icon,
                        shortText: item.title,
                        longText: item.description,
                        header: item.header,
                        footer: item.footer,
                        onTap: item.onTap,
                        href: item.href,
                      ))
                  .toList(),
            ),
          ],
        ),
      ],
    );
  }
}

/// Data class for a feature showcase item.
class ArcaneFeatureShowcaseItem {
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

  const ArcaneFeatureShowcaseItem({
    required this.icon,
    required this.title,
    required this.description,
    this.header,
    this.footer,
    this.onTap,
    this.href,
  });
}
