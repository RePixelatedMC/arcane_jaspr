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

import '../../util/tokens/tokens.dart';

/// Data class for a flexi card item.
class ArcaneFlexiCardItem {
  /// Icon component displayed at the top of the card
  final Component icon;

  /// Short text - always visible, used as the title
  final String shortText;

  /// Long text - expanded description shown when card is focused
  final String longText;

  /// Optional header/top bar component
  final Component? header;

  /// Optional footer component
  final Component? footer;

  /// Optional click handler
  final void Function()? onTap;

  /// Optional link href
  final String? href;

  const ArcaneFlexiCardItem({
    required this.icon,
    required this.shortText,
    required this.longText,
    this.header,
    this.footer,
    this.onTap,
    this.href,
  });
}

/// A group of cards where hovering magnifies the focused card while shrinking others.
///
/// Creates an interactive card layout where the hovered card expands to show
/// more detail while the other cards shrink to give it more space.
///
/// ```dart
/// ArcaneFlexiCards(
///   items: [
///     ArcaneFlexiCardItem(
///       icon: Icon(LucideIcons.server),
///       shortText: 'Fast Servers',
///       longText: 'Enterprise-grade hardware with NVMe SSDs...',
///       footer: Text('Learn more'),
///     ),
///     ArcaneFlexiCardItem(
///       icon: Icon(LucideIcons.shield),
///       shortText: 'DDoS Protection',
///       longText: 'Multi-layer protection against attacks...',
///     ),
///     ArcaneFlexiCardItem(
///       icon: Icon(LucideIcons.zap),
///       shortText: 'Low Latency',
///       longText: 'Optimized routing for minimal ping...',
///     ),
///   ],
/// )
/// ```
///
/// ## Locked Dimensions
///
/// Use pre/post lock parameters to constrain card dimensions during transitions:
///
/// ```dart
/// ArcaneFlexiCards(
///   items: items,
///   heightPreLock: '200px',   // Height when collapsed
///   heightPostLock: '280px',  // Height when expanded
///   widthPreLock: '180px',    // Width when collapsed
///   widthPostLock: '320px',   // Width when expanded
/// )
/// ```
class ArcaneFlexiCards extends StatefulComponent {
  /// The list of card items to display
  final List<ArcaneFlexiCardItem> items;

  /// The flex-grow value for non-hovered cards (default: 1)
  final double collapsedFlex;

  /// The flex-grow value for the hovered card (default: 2)
  final double expandedFlex;

  /// Whether to also scale height on hover
  final bool scaleHeight;

  /// Height scale factor when scaleHeight is true (e.g., 1.1 = 10% taller)
  final double heightScaleFactor;

  /// Gap between cards
  final String gap;

  /// Minimum width of each card
  final String minCardWidth;

  /// Transition duration in milliseconds
  final int transitionDuration;

  /// Whether to show the long text only on hover (true) or always (false)
  final bool expandLongTextOnHover;

  /// Locked height for collapsed (non-hovered) cards.
  /// When set, cards will have this fixed height when not hovered.
  final String? heightPreLock;

  /// Locked height for expanded (hovered) cards.
  /// When set, the hovered card will animate to this height.
  final String? heightPostLock;

  /// Locked width for collapsed (non-hovered) cards.
  /// When set, cards will have this fixed width when not hovered.
  /// This overrides flex behavior for width.
  final String? widthPreLock;

  /// Locked width for expanded (hovered) cards.
  /// When set, the hovered card will animate to this width.
  /// This overrides flex behavior for width.
  final String? widthPostLock;

  const ArcaneFlexiCards({
    required this.items,
    this.collapsedFlex = 1.0,
    this.expandedFlex = 2.0,
    this.scaleHeight = false,
    this.heightScaleFactor = 1.05,
    this.gap = ArcaneSpacing.lg,
    this.minCardWidth = '200px',
    this.transitionDuration = 300,
    this.expandLongTextOnHover = true,
    this.heightPreLock,
    this.heightPostLock,
    this.widthPreLock,
    this.widthPostLock,
    super.key,
  });

  @override
  State<ArcaneFlexiCards> createState() => _ArcaneFlexiCardsState();

  @css
  static final List<StyleRule> styles = [
    css('.arcane-flexi-card').styles(raw: {
      'transition': 'all 300ms cubic-bezier(0.4, 0, 0.2, 1)',
    }),
    css('.arcane-flexi-card:hover').styles(raw: {
      'border-color': ArcaneColors.accent,
    }),
    css('.arcane-flexi-card-long-text').styles(raw: {
      'transition': 'opacity 200ms ease, max-height 300ms ease',
      'overflow': 'hidden',
    }),
  ];
}

class _ArcaneFlexiCardsState extends State<ArcaneFlexiCards> {
  int? _hoveredIndex;

  void _onCardHover(int index) {
    setState(() => _hoveredIndex = index);
  }

  void _onCardLeave() {
    setState(() => _hoveredIndex = null);
  }

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'arcane-flexi-cards',
      styles: Styles(raw: {
        'display': 'flex',
        'flex-direction': 'row',
        'gap': component.gap,
        'width': '100%',
      }),
      [
        for (int i = 0; i < component.items.length; i++)
          _buildCard(context, i, component.items[i]),
      ],
    );
  }

  Component _buildCard(BuildContext context, int index, ArcaneFlexiCardItem item) {
    final bool isHovered = _hoveredIndex == index;
    final bool hasHoveredCard = _hoveredIndex != null;

    // Calculate flex values
    final double flexValue = isHovered
        ? component.expandedFlex
        : (hasHoveredCard ? component.collapsedFlex * 0.8 : component.collapsedFlex);

    // Calculate height transform if enabled
    final String transform = component.scaleHeight && isHovered
        ? 'scale(1, ${component.heightScaleFactor})'
        : 'scale(1, 1)';

    // Determine opacity for long text
    final bool showLongText = !component.expandLongTextOnHover || isHovered;

    final List<Component> cardContent = [
      // Header (optional)
      if (item.header != null)
        div(
          classes: 'arcane-flexi-card-header',
          styles: const Styles(raw: {
            'padding': '${ArcaneSpacing.sm} ${ArcaneSpacing.md}',
            'border-bottom': '1px solid ${ArcaneColors.border}',
            'margin': '-${ArcaneSpacing.lg}',
            'margin-bottom': ArcaneSpacing.md,
          }),
          [item.header!],
        ),

      // Icon
      div(
        classes: 'arcane-flexi-card-icon',
        styles: const Styles(raw: {
          'display': 'flex',
          'align-items': 'center',
          'justify-content': 'center',
          'width': '56px',
          'height': '56px',
          'border-radius': ArcaneRadius.lg,
          'background-color': ArcaneColors.accentContainer,
          'color': ArcaneColors.accent,
          'margin-bottom': ArcaneSpacing.md,
          'flex-shrink': '0',
        }),
        [item.icon],
      ),

      // Short text (title)
      div(
        classes: 'arcane-flexi-card-title',
        styles: const Styles(raw: {
          'font-size': ArcaneTypography.fontLg,
          'font-weight': ArcaneTypography.weightSemibold,
          'color': ArcaneColors.onSurface,
          'margin-bottom': ArcaneSpacing.sm,
        }),
        [Component.text(item.shortText)],
      ),

      // Long text (description) - with animation
      div(
        classes: 'arcane-flexi-card-long-text',
        styles: Styles(raw: {
          'font-size': ArcaneTypography.fontMd,
          'line-height': ArcaneTypography.leadingRelaxed,
          'color': ArcaneColors.muted,
          'opacity': showLongText ? '1' : '0',
          'max-height': showLongText ? '200px' : '0',
          'margin-bottom': showLongText ? ArcaneSpacing.md : '0',
        }),
        [Component.text(item.longText)],
      ),

      // Spacer to push footer to bottom
      const div(
        styles: Styles(raw: {'flex': '1'}),
        [],
      ),

      // Footer (optional)
      if (item.footer != null)
        div(
          classes: 'arcane-flexi-card-footer',
          styles: Styles(raw: {
            'padding-top': ArcaneSpacing.md,
            'border-top': '1px solid ${ArcaneColors.border}',
            'opacity': showLongText ? '1' : '0.6',
            'transition': 'opacity 200ms ease',
          }),
          [item.footer!],
        ),
    ];

    // Determine locked dimensions based on hover state
    final bool useLockedWidth = component.widthPreLock != null || component.widthPostLock != null;
    final bool useLockedHeight = component.heightPreLock != null || component.heightPostLock != null;

    // Calculate width - use locked values if provided, otherwise use flex
    String? cardWidth;
    if (useLockedWidth) {
      if (isHovered && component.widthPostLock != null) {
        cardWidth = component.widthPostLock;
      } else if (component.widthPreLock != null) {
        cardWidth = component.widthPreLock;
      }
    }

    // Calculate height - use locked values if provided
    String? cardHeight;
    if (useLockedHeight) {
      if (isHovered && component.heightPostLock != null) {
        cardHeight = component.heightPostLock;
      } else if (component.heightPreLock != null) {
        cardHeight = component.heightPreLock;
      }
    }

    final Map<String, String> cardStyles = {
      // Only use flex if not using locked width
      if (!useLockedWidth) 'flex': '$flexValue',
      if (cardWidth != null) 'width': cardWidth,
      if (cardHeight != null) 'height': cardHeight,
      'min-width': component.minCardWidth,
      'display': 'flex',
      'flex-direction': 'column',
      'padding': ArcaneSpacing.lg,
      'background-color': ArcaneColors.card,
      'border': '1px solid ${ArcaneColors.border}',
      'border-radius': ArcaneRadius.xl,
      'transform': transform,
      'transform-origin': 'center center',
      'transition': 'all ${component.transitionDuration}ms cubic-bezier(0.4, 0, 0.2, 1)',
      'overflow': 'hidden',
      if (item.onTap != null || item.href != null) 'cursor': 'pointer',
    };

    // Wrap in link if href provided
    if (item.href != null) {
      return a(
        classes: 'arcane-flexi-card',
        href: item.href!,
        styles: Styles(raw: {
          ...cardStyles,
          'text-decoration': 'none',
          'color': 'inherit',
        }),
        events: {
          'mouseenter': (_) => _onCardHover(index),
          'mouseleave': (_) => _onCardLeave(),
        },
        cardContent,
      );
    }

    // Wrap in button if onTap provided
    if (item.onTap != null) {
      return button(
        classes: 'arcane-flexi-card',
        attributes: {'type': 'button'},
        styles: Styles(raw: {
          ...cardStyles,
          'text-align': 'left',
        }),
        events: {
          'mouseenter': (_) => _onCardHover(index),
          'mouseleave': (_) => _onCardLeave(),
          'click': (_) => item.onTap!(),
        },
        cardContent,
      );
    }

    // Default div
    return div(
      classes: 'arcane-flexi-card',
      styles: Styles(raw: cardStyles),
      events: {
        'mouseenter': (_) => _onCardHover(index),
        'mouseleave': (_) => _onCardLeave(),
      },
      cardContent,
    );
  }
}

/// A simpler flexi cards variant that just uses CSS :hover without state management.
/// This is more performant but less customizable.
class ArcaneFlexiCardsSimple extends StatelessComponent {
  /// The list of card items to display
  final List<ArcaneFlexiCardItem> items;

  /// Gap between cards
  final String gap;

  const ArcaneFlexiCardsSimple({
    required this.items,
    this.gap = ArcaneSpacing.lg,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'arcane-flexi-cards-simple',
      styles: Styles(raw: {
        'display': 'flex',
        'flex-direction': 'row',
        'gap': gap,
        'width': '100%',
      }),
      [
        for (final item in items) _buildCard(item),
      ],
    );
  }

  Component _buildCard(ArcaneFlexiCardItem item) {
    return div(
      classes: 'arcane-flexi-card-simple',
      styles: const Styles(raw: {
        'flex': '1',
        'min-width': '200px',
        'display': 'flex',
        'flex-direction': 'column',
        'padding': ArcaneSpacing.lg,
        'background-color': ArcaneColors.card,
        'border': '1px solid ${ArcaneColors.border}',
        'border-radius': ArcaneRadius.xl,
      }),
      [
        // Icon
        div(
          styles: const Styles(raw: {
            'display': 'flex',
            'align-items': 'center',
            'justify-content': 'center',
            'width': '56px',
            'height': '56px',
            'border-radius': ArcaneRadius.lg,
            'background-color': ArcaneColors.accentContainer,
            'color': ArcaneColors.accent,
            'margin-bottom': ArcaneSpacing.md,
          }),
          [item.icon],
        ),

        // Title
        div(
          classes: 'arcane-flexi-card-simple-title',
          styles: const Styles(raw: {
            'font-size': ArcaneTypography.fontLg,
            'font-weight': ArcaneTypography.weightSemibold,
            'color': ArcaneColors.onSurface,
            'margin-bottom': ArcaneSpacing.sm,
          }),
          [Component.text(item.shortText)],
        ),

        // Description (shown/hidden via CSS)
        div(
          classes: 'arcane-flexi-card-simple-desc',
          styles: const Styles(raw: {
            'font-size': ArcaneTypography.fontMd,
            'line-height': ArcaneTypography.leadingRelaxed,
            'color': ArcaneColors.muted,
          }),
          [Component.text(item.longText)],
        ),

        // Spacer
        const div(styles: Styles(raw: {'flex': '1'}), []),

        // Footer
        if (item.footer != null)
          div(
            classes: 'arcane-flexi-card-simple-footer',
            styles: const Styles(raw: {
              'padding-top': ArcaneSpacing.md,
              'border-top': '1px solid ${ArcaneColors.border}',
            }),
            [item.footer!],
          ),
      ],
    );
  }

  @css
  static final List<StyleRule> styles = [
    // Container uses :has() to detect hover and adjust siblings
    css('.arcane-flexi-cards-simple').styles(raw: {
      'display': 'flex',
    }),

    // Base card transition
    css('.arcane-flexi-card-simple').styles(raw: {
      'transition': 'all 300ms cubic-bezier(0.4, 0, 0.2, 1)',
    }),

    // Description hidden by default
    css('.arcane-flexi-card-simple-desc').styles(raw: {
      'opacity': '0',
      'max-height': '0',
      'overflow': 'hidden',
      'transition': 'opacity 200ms ease, max-height 300ms ease',
    }),

    // Hovered card expands
    css('.arcane-flexi-card-simple:hover').styles(raw: {
      'flex': '2',
      'border-color': ArcaneColors.accent,
    }),

    // Show description on hover
    css('.arcane-flexi-card-simple:hover .arcane-flexi-card-simple-desc').styles(raw: {
      'opacity': '1',
      'max-height': '200px',
      'margin-bottom': ArcaneSpacing.md,
    }),

    // Siblings of hovered card shrink (using :has which is now widely supported)
    css('.arcane-flexi-cards-simple:has(.arcane-flexi-card-simple:hover) .arcane-flexi-card-simple:not(:hover)')
        .styles(raw: {
      'flex': '0.8',
    }),
  ];
}
