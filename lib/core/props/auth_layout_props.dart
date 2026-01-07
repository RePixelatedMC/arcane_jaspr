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
    this.primaryGlowColor = 'hsl(var(--accent) / 0.15)',
    this.secondaryGlowColor = 'hsl(199 89% 48% / 0.15)',
    this.gridColor = 'hsl(var(--border) / 0.3)',
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
