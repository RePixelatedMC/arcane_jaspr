import 'package:jaspr/jaspr.dart';

/// Auth layout component properties.
class AuthLayoutProps {
  final Component child;
  final Component? header;
  final Component? footer;
  final bool showGrid;
  final bool showGlows;
  final String primaryGlowColor;
  final String secondaryGlowColor;
  final String gridColor;
  final String maxWidth;
  final String backgroundColor;

  const AuthLayoutProps({
    required this.child,
    this.header,
    this.footer,
    this.showGrid = true,
    this.showGlows = true,
    this.primaryGlowColor = 'color-mix(in srgb, var(--accent) 15%, transparent)',
    this.secondaryGlowColor = 'color-mix(in srgb, var(--info) 15%, transparent)',
    this.gridColor = 'color-mix(in srgb, var(--border) 30%, transparent)',
    this.maxWidth = '420px',
    this.backgroundColor = 'var(--background)',
  });
}

/// Auth back link component properties.
class AuthBackLinkProps {
  final String href;
  final String text;

  const AuthBackLinkProps({
    required this.href,
    this.text = 'Back to home',
  });
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer methods for auth layout components.
mixin AuthLayoutRendererContract {
  Component authLayout(AuthLayoutProps props);
  Component authBackLink(AuthBackLinkProps props);
}
