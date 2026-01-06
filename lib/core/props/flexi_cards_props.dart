import 'package:jaspr/jaspr.dart';

/// Data class for a flexi card item.
class FlexiCardItem {
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

  const FlexiCardItem({
    required this.icon,
    required this.shortText,
    required this.longText,
    this.header,
    this.footer,
    this.onTap,
    this.href,
  });
}

/// Props for the FlexiCards component.
class FlexiCardsProps {
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
  final String? heightPreLock;

  /// Locked height for expanded (hovered) cards.
  final String? heightPostLock;

  /// Locked width for collapsed (non-hovered) cards.
  final String? widthPreLock;

  /// Locked width for expanded (hovered) cards.
  final String? widthPostLock;

  const FlexiCardsProps({
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
  });
}

/// Props for the simple FlexiCards component.
class FlexiCardsSimpleProps {
  /// The list of card items to display
  final List<FlexiCardItem> items;

  /// Gap between cards
  final String gap;

  const FlexiCardsSimpleProps({
    required this.items,
    this.gap = '1.5rem',
  });
}
