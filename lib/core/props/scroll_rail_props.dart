import 'package:jaspr/jaspr.dart';

/// Scroll rail position
enum ScrollRailPosition {
  left,
  right,
}

/// Scroll rail sizing
enum ScrollRailSize {
  narrow,
  sm,
  md,
  lg,
  xl,
}

/// Properties for scroll rail components.
class ScrollRailProps {
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

  /// Background color
  final String? background;

  /// Padding
  final String padding;

  /// Whether to show a custom scrollbar
  final bool customScrollbar;

  /// ID for scroll persistence
  final String? scrollPersistenceId;

  const ScrollRailProps({
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
  });
}

/// Properties for scroll rail layout components.
class ScrollRailLayoutProps {
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

  /// Height of fixed header
  final String headerHeight;

  /// Whether to show border
  final bool showBorder;

  /// Rail background color
  final String? railBackground;

  /// Main content background color
  final String? contentBackground;

  const ScrollRailLayoutProps({
    required this.rail,
    required this.child,
    this.railPosition = ScrollRailPosition.left,
    this.railSize = ScrollRailSize.md,
    this.railWidth,
    this.headerHeight = '0px',
    this.showBorder = true,
    this.railBackground,
    this.contentBackground,
  });
}
