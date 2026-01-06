import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

export '../../core/props/auth_layout_props.dart';

/// A layout for authentication screens with centered content and optional background effects.
///
/// Provides a full-viewport container with optional grid pattern and glow effects,
/// perfect for login, signup, and password reset screens.
class ArcaneAuthLayout extends StatelessComponent {
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

  const ArcaneAuthLayout({
    super.key,
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

  /// Creates an auth layout with accent-colored glows based on theme
  const ArcaneAuthLayout.themed({
    super.key,
    required this.child,
    this.header,
    this.footer,
    this.showGrid = true,
    this.showGlows = true,
    this.maxWidth = '420px',
    this.backgroundColor = 'var(--background)',
  })  : primaryGlowColor = 'hsl(var(--accent) / 0.15)',
        secondaryGlowColor = 'hsl(199 89% 48% / 0.15)',
        gridColor = 'hsl(var(--border) / 0.3)';

  @override
  Component build(BuildContext context) {
    return context.renderers.authLayout(AuthLayoutProps(
      child: child,
      header: header,
      footer: footer,
      showGrid: showGrid,
      showGlows: showGlows,
      primaryGlowColor: primaryGlowColor,
      secondaryGlowColor: secondaryGlowColor,
      gridColor: gridColor,
      maxWidth: maxWidth,
      backgroundColor: backgroundColor,
    ));
  }
}

/// A simple "back to" link for auth layouts.
class ArcaneAuthBackLink extends StatelessComponent {
  /// The href to navigate to
  final String href;

  /// The link text (defaults to "Back to home")
  final String text;

  const ArcaneAuthBackLink({
    super.key,
    required this.href,
    this.text = 'Back to home',
  });

  @override
  Component build(BuildContext context) {
    return context.renderers.authBackLink(AuthBackLinkProps(
      href: href,
      text: text,
    ));
  }
}
