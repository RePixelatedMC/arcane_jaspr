import 'package:jaspr/jaspr.dart';

import '../../core/props/flexi_cards_props.dart';
import '../../core/theme_provider.dart';

// Re-export props for usage
export '../../core/props/flexi_cards_props.dart';

/// A group of cards where hovering magnifies the focused card while shrinking others.
///
/// Creates an interactive card layout where the hovered card expands to show
/// more detail while the other cards shrink to give it more space.
///
/// ```dart
/// ArcaneFlexiCards(
///   items: [
///     FlexiCardItem(
///       icon: Icon(LucideIcons.server),
///       shortText: 'Fast Servers',
///       longText: 'Enterprise-grade hardware with NVMe SSDs...',
///       footer: Text('Learn more'),
///     ),
///     FlexiCardItem(
///       icon: Icon(LucideIcons.shield),
///       shortText: 'DDoS Protection',
///       longText: 'Multi-layer protection against attacks...',
///     ),
///     FlexiCardItem(
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
class ArcaneFlexiCards extends StatelessComponent {
  /// The list of card items to display
  final List<FlexiCardItem> items;

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
    this.gap = '1.5rem',
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
  Component build(BuildContext context) {
    return context.renderers.flexiCards(FlexiCardsProps(
      items: items,
      collapsedFlex: collapsedFlex,
      expandedFlex: expandedFlex,
      scaleHeight: scaleHeight,
      heightScaleFactor: heightScaleFactor,
      gap: gap,
      minCardWidth: minCardWidth,
      transitionDuration: transitionDuration,
      expandLongTextOnHover: expandLongTextOnHover,
      heightPreLock: heightPreLock,
      heightPostLock: heightPostLock,
      widthPreLock: widthPreLock,
      widthPostLock: widthPostLock,
    ));
  }
}

/// A simpler flexi cards variant that just uses CSS :hover without state management.
/// This is more performant but less customizable.
class ArcaneFlexiCardsSimple extends StatelessComponent {
  /// The list of card items to display
  final List<FlexiCardItem> items;

  /// Gap between cards
  final String gap;

  const ArcaneFlexiCardsSimple({
    required this.items,
    this.gap = '1.5rem',
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return context.renderers.flexiCardsSimple(FlexiCardsSimpleProps(
      items: items,
      gap: gap,
    ));
  }
}
