import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

// Re-export enums from props for convenience
export '../../core/props/scroll_rail_props.dart' show ScrollRailPosition, ScrollRailSize;

/// A scrollable sidebar rail that maintains position independently of page scroll.
///
/// This component creates a sticky sidebar that:
/// - Stays fixed relative to the viewport
/// - Scrolls independently of the main content
/// - Maintains scroll position during page navigation
/// - Perfect for documentation sidebars and navigation menus
///
/// ```dart
/// ArcaneScrollRail(
///   width: '280px',
///   topOffset: '64px', // Below a fixed header
///   children: [
///     // Navigation items
///   ],
/// )
/// ```
class ArcaneScrollRail extends StatelessComponent {
  /// Children to render inside the rail
  final List<Component> children;

  /// Position of the rail (left or right)
  final ScrollRailPosition position;

  /// Size preset for the rail width
  final ScrollRailSize size;

  /// Custom width (overrides size)
  final String? width;

  /// Top offset (e.g., to account for fixed header)
  final String topOffset;

  /// Bottom offset
  final String bottomOffset;

  /// Whether to show border on the rail edge
  final bool showBorder;

  /// Background color (uses CSS variable if null)
  final String? background;

  /// Padding preset
  final String padding;

  /// Whether to show a custom scrollbar
  final bool customScrollbar;

  /// ID for scroll persistence (used to restore scroll position)
  final String? scrollPersistenceId;

  const ArcaneScrollRail({
    required this.children,
    this.position = ScrollRailPosition.left,
    this.size = ScrollRailSize.md,
    this.width,
    this.topOffset = '0px',
    this.bottomOffset = '0px',
    this.showBorder = true,
    this.background,
    this.padding = '1rem',
    this.customScrollbar = true,
    this.scrollPersistenceId,
    super.key,
  });

  /// Constructor for left-positioned rail
  const ArcaneScrollRail.left({
    required this.children,
    this.size = ScrollRailSize.md,
    this.width,
    this.topOffset = '0px',
    this.bottomOffset = '0px',
    this.showBorder = true,
    this.background,
    this.padding = '1rem',
    this.customScrollbar = true,
    this.scrollPersistenceId,
    super.key,
  }) : position = ScrollRailPosition.left;

  /// Constructor for right-positioned rail
  const ArcaneScrollRail.right({
    required this.children,
    this.size = ScrollRailSize.md,
    this.width,
    this.topOffset = '0px',
    this.bottomOffset = '0px',
    this.showBorder = true,
    this.background,
    this.padding = '1rem',
    this.customScrollbar = true,
    this.scrollPersistenceId,
    super.key,
  }) : position = ScrollRailPosition.right;

  @override
  Component build(BuildContext context) {
    return context.renderers.scrollRail(ScrollRailProps(
      position: position,
      size: size,
      width: width,
      topOffset: topOffset,
      bottomOffset: bottomOffset,
      showBorder: showBorder,
      background: background,
      padding: padding,
      customScrollbar: customScrollbar,
      scrollPersistenceId: scrollPersistenceId,
      children: children,
    ));
  }
}

/// A layout component that combines a scroll rail with main content.
///
/// This provides a complete two-column layout with a sticky scrollable
/// sidebar and main content area.
///
/// ```dart
/// ArcaneScrollRailLayout(
///   headerHeight: '64px',
///   rail: DocsSidebar(),
///   child: DocsContent(),
/// )
/// ```
class ArcaneScrollRailLayout extends StatelessComponent {
  /// The rail/sidebar content
  final Component rail;

  /// The main content
  final Component child;

  /// Position of the rail
  final ScrollRailPosition railPosition;

  /// Size of the rail
  final ScrollRailSize railSize;

  /// Custom rail width
  final String? railWidth;

  /// Height of fixed header (used to calculate rail offset)
  final String headerHeight;

  /// Whether to show border between rail and content
  final bool showBorder;

  /// Rail background color
  final String? railBackground;

  /// Main content background color
  final String? contentBackground;

  const ArcaneScrollRailLayout({
    required this.rail,
    required this.child,
    this.railPosition = ScrollRailPosition.left,
    this.railSize = ScrollRailSize.md,
    this.railWidth,
    this.headerHeight = '0px',
    this.showBorder = true,
    this.railBackground,
    this.contentBackground,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return context.renderers.scrollRailLayout(ScrollRailLayoutProps(
      rail: rail,
      child: child,
      railPosition: railPosition,
      railSize: railSize,
      railWidth: railWidth,
      headerHeight: headerHeight,
      showBorder: showBorder,
      railBackground: railBackground,
      contentBackground: contentBackground,
    ));
  }
}
