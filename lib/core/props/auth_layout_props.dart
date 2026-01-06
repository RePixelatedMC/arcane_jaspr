import 'package:jaspr/jaspr.dart';

/// Properties for auth layout components.
class AuthLayoutProps {
  /// The main content (typically an auth card/form)
  final Component child;

  /// Optional header content (typically a logo) displayed above the main content
  final Component? header;

  /// Optional footer content (typically a "back to home" link)
  final Component? footer;

  /// Whether to show the grid pattern background
  final bool showGrid;

  /// Whether to show the glow effects
  final bool showGlows;

  /// Primary glow color (top-left)
  final String primaryGlowColor;

  /// Secondary glow color (bottom-right)
  final String secondaryGlowColor;

  /// Grid line color
  final String gridColor;

  /// Maximum width of the content area
  final String maxWidth;

  /// Background color
  final String backgroundColor;

  const AuthLayoutProps({
    required this.child,
    this.header,
    this.footer,
    this.showGrid = true,
    this.showGlows = true,
    this.primaryGlowColor = 'hsl(var(--accent) / 0.15)',
    this.secondaryGlowColor = 'hsl(199 89% 48% / 0.15)',
    this.gridColor = 'hsl(var(--border) / 0.3)',
    this.maxWidth = '420px',
    this.backgroundColor = 'var(--background)',
  });
}

/// Properties for auth back link components.
class AuthBackLinkProps {
  /// The href to navigate to
  final String href;

  /// The link text (defaults to "Back to home")
  final String text;

  const AuthBackLinkProps({
    required this.href,
    this.text = 'Back to home',
  });
}
